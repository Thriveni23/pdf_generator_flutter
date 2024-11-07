import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../data/data_model/profile_model.dart';
import '../locator.dart';
import 'package:uuid/uuid.dart';

class ProfileManagementService {
  var profileQuery = ValueNotifier<String>("");
  var profileFilter = ValueNotifier<List<String>>([]);
  var profileList = ValueNotifier<List<ProfileModel>>([]);
  var profilesToDisplay = ValueNotifier<List<ProfileModel>>([]);

  init() {
    streamProfiles();
    profileQuery.addListener(setProfileToDisplay);
    profileList.addListener(setProfileToDisplay);
  }

  close() {}

  void setProfileToDisplay() {
    if (profileQuery.value.isNotEmpty) {
      var filteredList = profileList.value
          .where((element) => element.firstName!
              .toLowerCase()
              .contains(profileQuery.value.toLowerCase()))
          .toList();

      filteredList.sort(((a, b) => a.firstName!
          .toLowerCase()
          .compareTo(b.firstName!.toLowerCase())));

      profilesToDisplay.value = filteredList;
    } else {
      profileList.value.sort(((a, b) => a.firstName!
          .toLowerCase()
          .compareTo(b.firstName!.toLowerCase())));
      profilesToDisplay.value = profileList.value;
    }
  }

  Future<void> createProfile(ProfileModel profile) async {
    var uuid = const Uuid();
    profile.documentId = uuid.v4();

    Locator.profileDatabaseService.createLocal(profile);

    await Locator.profileDatabaseService
        .createRemote(profile.documentId!, profile);
  }

  void deleteProfile(ProfileModel profile) async {
    Locator.firestoreService.profileColRef.doc(profile.documentId).delete();

    print('profile deleted successfully');
    await Locator.profileDatabaseService.deleteLocal(profile.documentId!);
  }

  Future<void> updateProfile(String documentId, ProfileModel profile) async {
    
    try {
      DocumentSnapshot snapshot =
          await Locator.firestoreService.profileColRef.doc(documentId).get();

      if (snapshot.exists) {
        // Convert profileModel to Map<String, dynamic> before updating
        Map<String, dynamic> profileMap =
            profile.toJson(); // Ensure profileModel has a toMap method

        await Locator.firestoreService.profileColRef
            .doc(documentId)
            .update(profileMap);

        print('profile details updated successfully');
      } else {
        print('No profile found with the provided document ID.');
      }
    } catch (e) {
      print('Failed to update profile details: $e');
    }
  }

  streamProfiles() {
    profileList.value = Locator.hiveService.profileBox!.values.toList();
    var profileStream = Locator.hiveService.profileBox!.watch();
    profileStream.listen((event) {
      profileList.value = Locator.hiveService.profileBox!.values.toList();
    });
    profilesToDisplay.value = profileList.value;

    // setBrandList();
  }
}
