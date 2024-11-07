import 'package:flutter_chat_app/data/data_model/user_model.dart';
import 'package:flutter_chat_app/data/data_model/profile_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HiveService {
  Box<UserModel>? userBox;
  Box<ProfileModel>? profileBox;

  init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(ProfileModelAdapter());

    userBox = await Hive.openBox<UserModel>("userBox");
    profileBox = await Hive.openBox<ProfileModel>("profileBox");
    
  }

  clearAllBox() {}
}
