import '../../../logic/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class UserManagementService {
  final userData = ValueNotifier<User?>(null);

  final invalidUser = ValueNotifier<bool>(false);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> init() async {
    _auth.authStateChanges().listen((user) async {
      Locator.navigationService.isLoadingNotifier.value = true;
      if (user != null) {
        userData.value = user;
      } else {
        userData.value = null;
      }
      Locator.navigationService.isLoadingNotifier.value = false;
    });
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      Locator.navigationService.isLoadingNotifier.value = true;

      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      invalidUser.value = !invalidUser.value;
      Locator.navigationService.isLoadingNotifier.value = false;
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
  try {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password
    );
  } catch (e) {
    print('Error signing up: ${e.toString()}');
  }
}

  Future<void> signOut() async {
    await _auth.signOut();
  }
}