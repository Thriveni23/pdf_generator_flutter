import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/data/data_model/user_model.dart';
import 'package:flutter_chat_app/logic/locator.dart';


class UserDatabaseService {

  Future<void> getUserData(User user) async {
    UserModel userData = await readUserFromRemote(user);
    await createUserInLocal(userData);
  }



   Future<UserModel> readUserFromRemote(User user) async {
    try {
      DocumentReference documentReference =
        FirebaseFirestore.instance.collection('users').doc(user.uid);

      DocumentSnapshot documentSnapshot = await documentReference.get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        UserModel userModel = UserModel.fromJson(data: data, user: user);
        return userModel;
      } else {
        print("Document doesn't exist for user UID: ${user.uid}");
        return UserModel();
      }
    } catch (e) {
      print("Error reading user from remote: $e");
      rethrow;
    }
  }

  Future<void> createUserInLocal(UserModel userModel) async {
    if (Locator.hiveService.userBox!.isNotEmpty) {
      await deleteUserFromLocal();
    }
    await Locator.hiveService.userBox?.put(userModel.uid, userModel);
  }

  Future<UserModel?> readUserFromLocal() async {
    var user = Locator.hiveService.userBox?.getAt(0);
    return user;
  }

  Future<void> updateUserInLocal(UserModel userModel) async {
    await Locator.hiveService.userBox?.put(userModel.uid, userModel);
  }

  deleteUserFromLocal() async {
    await Locator.hiveService.userBox?.clear();
  }
}
