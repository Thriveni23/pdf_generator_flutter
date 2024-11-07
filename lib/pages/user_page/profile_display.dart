
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/logic/data_management_service/profile_management_service.dart';
import 'package:flutter_chat_app/logic/data_management_service/user_management_service.dart';
import 'package:flutter_chat_app/pages/user_page/profile_tile.dart';
import 'package:watch_it/watch_it.dart';



class ProfileDisplay extends StatelessWidget with WatchItMixin {
  const ProfileDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var profileListToDisplay =
        watchValue((ProfileManagementService x) => x.profilesToDisplay);
    return SizedBox(
        width: screenWidth,
        child: ListView.builder(
          
          itemCount: profileListToDisplay.length,
          itemBuilder: (context, index) => ProfileTile(
            profile: profileListToDisplay[index],
          ),
        ));
  }
}