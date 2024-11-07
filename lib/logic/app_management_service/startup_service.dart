import 'package:firebase_auth/firebase_auth.dart';

import '../locator.dart';

class StartupService{
  init() async{
    await Locator.hiveService.init();
    print("hive");
    await Locator.firestoreService.init();
    await setupApplicationData();
    
    await Locator.userManagementService.init();
    await Locator.profileManagementService.init();
    
  }
  
  setupApplicationData() async {
   
    if (Locator.hiveService.userBox!.isNotEmpty) {
      var userModel = await Locator.userDatabaseService.readUserFromLocal();
      Locator.userManagementService.userData.value = userModel as User;
         await syncProfileData();
    
    }
  }

   syncProfileData() async {
    if (Locator.userManagementService.userData.value != null 
) {
      var localLastModified =
          Locator.profileDatabaseService.getLocalDbLastModified();
      var remoteLastModified =
          await Locator.profileDatabaseService.getRemoteDbLastModified();
      if (localLastModified != null) {
        if (remoteLastModified.isAfter(localLastModified)) {
          await Locator.profileDatabaseService.fetchProfiles(localLastModified);
        }
        var localLastModifiedAfterFetch =
            Locator.profileDatabaseService.getLocalDbLastModified();
        Locator.profileDatabaseService
            .streamRemoteToLocal(localLastModifiedAfterFetch!);
      }}
    
  }

}


  
 


