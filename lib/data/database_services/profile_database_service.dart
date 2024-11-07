import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/data/data_model/profile_model.dart';
import 'package:flutter_chat_app/logic/locator.dart';


class ProfileDatabaseService {
  init() {}

  DateTime? getLocalDbLastModified() {
    if (Locator.hiveService.profileBox!.isEmpty) {
      return DateTime(2020);
    } else {
      List<ProfileModel> profileList =
          Locator.hiveService.profileBox!.values.toList();
      profileList.sort(((a, b) => a.lastModified!.compareTo(b.lastModified!)));
      return profileList.last.lastModified;
    }
  }

  Future<DateTime> getRemoteDbLastModified() async {
    var querySnapshot = await Locator.firestoreService.profileColRef!
        .orderBy('lastModified', descending: true)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.get('lastModified').toDate();
    } else {
      // throw Exception('No documents found in collection');
      return DateTime(2020);
    }
  }

  Future<void> fetchProfiles(DateTime localLastModified) async {
    var querySnapshot = await Locator.firestoreService.profileColRef!
        .where('lastModified', isGreaterThan: localLastModified)
        .get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      ProfileModel profile =
          ProfileModel.fromJson(json: data, documentId: doc.id);

      await Locator.profileDatabaseService.createLocal(profile);
    }
  }

  void streamRemoteToLocal(DateTime localLastModified) {
    var remoteStreamProfile = Locator.firestoreService.profileColRef!
        .where('lastModified', isGreaterThan: localLastModified)
        .snapshots();
    remoteStreamProfile.listen((snapshot) async {
      print("Received snapshot with ${snapshot.docChanges.length} changes.");
      for (var documentChange in snapshot.docChanges) {
        try {
          if (documentChange.type == DocumentChangeType.removed) {
            deleteLocal(documentChange.doc.id);
            // Handle the deletion here
          } else {
            Map<String, dynamic>? data =
                documentChange.doc.data() as Map<String, dynamic>?;
            if (data != null) {
              try {
                ProfileModel profile = ProfileModel.fromJson(
                  json: data,
                  documentId: documentChange.doc.id,
                );
                createLocal(profile);
              } catch (e) {
                print("Error creating customerModel from document data: $e");
              }
            } else {
              print(
                  "Warning: Document data is null for document ID: ${documentChange.doc.id}");
            }
          }
        } catch (e) {
          print("Unhandled exception in streamRemoteToLocal: $e");
        }
      }
    });
  }

  Future<void> createRemote(String documentId, ProfileModel profile) async {
    try {
      Map<String, dynamic> profileData = profile.toJson();
      await FirebaseFirestore.instance
          .collection('profiles')
          .doc(documentId)
          .set(profileData);
    } catch (e) {
      print("Error creating profile remotely: $e");
      throw Exception(
          "Failed to create remote profile: $e"); // Rethrow with more context
    }
  }

  createLocal(ProfileModel profileModel) {
    Locator.hiveService.profileBox!
        .put(profileModel.documentId, profileModel);
  }

  Future<List<ProfileModel>> readAllLocal() async {
    return [];
  }

  Future<void> updateProfileInLocal(ProfileModel profile) async {
    var profileBox = Locator.hiveService.profileBox;
    if (profileBox != null && profileBox.length > 0) {
      await profileBox.putAt(0, profile);
    }
  }

  deleteLocal(String documentId) {
    Locator.hiveService.profileBox!.delete(documentId);
  }
}
