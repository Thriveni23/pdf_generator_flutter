

import 'package:flutter_chat_app/data/database_services/profile_database_service.dart';
import 'package:flutter_chat_app/data/database_services/user_database_service.dart';
import 'package:flutter_chat_app/logic/app_management_service/firestore_service.dart';
import 'package:flutter_chat_app/logic/app_management_service/hive_service.dart';
import 'package:flutter_chat_app/logic/app_management_service/navigation_service.dart';
import 'package:flutter_chat_app/logic/app_management_service/startup_service.dart';
import 'package:flutter_chat_app/logic/data_management_service/profile_management_service.dart';
import 'package:flutter_chat_app/logic/data_management_service/user_management_service.dart';
import 'package:watch_it/watch_it.dart';

class Locator {
  static void setup() {
    GetIt.instance.registerLazySingleton(() => StartupService());
    GetIt.instance.registerLazySingleton(() => HiveService());
    GetIt.instance.registerLazySingleton(() => FirestoreService());
    GetIt.instance.registerLazySingleton(() => NavigationService());
    
     
    
    GetIt.instance.registerLazySingleton(() => UserDatabaseService());
     GetIt.instance.registerLazySingleton(() => ProfileDatabaseService());
    GetIt.instance.registerLazySingleton(() => UserManagementService());
   
    GetIt.instance.registerLazySingleton(() => ProfileManagementService());
    

  }

  //Support Services
  static StartupService get startupService => GetIt.I<StartupService>();
  static HiveService get hiveService => GetIt.I<HiveService>();
  static FirestoreService get firestoreService => GetIt.I<FirestoreService>();
  static NavigationService get navigationService =>
      GetIt.I<NavigationService>();
  static UserDatabaseService get userDatabaseService =>
      GetIt.I<UserDatabaseService>();
  static UserManagementService get userManagementService =>
      GetIt.I<UserManagementService>();

static ProfileManagementService get profileManagementService =>
      GetIt.I<ProfileManagementService>();
 static ProfileDatabaseService get profileDatabaseService =>
      GetIt.I<ProfileDatabaseService>();
}
