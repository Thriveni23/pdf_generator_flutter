
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/data/data_model/profile_model.dart';
import 'package:flutter_chat_app/pages/user_page/pdf_generation.dart';
import 'package:flutter_chat_app/pages/user_page/view_profile.dart';

import '../../logic/locator.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({Key? key, required this.profile}) : super(key: key);
  final ProfileModel profile;

  void _showPopup(BuildContext context, user) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ViewProfile(profile: profile);
        },
      );
    });
  }

 


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //   onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => ViewOrder(order: order)),
      //   );
      // },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              tileColor:Color.fromARGB(255, 141, 66, 66),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        '${profile.firstName ?? 'Name: Unknown'}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${profile.phoneNumber ?? 'PhoneNo: Unknown'}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                       
                      ],
                    ),
                  ),

                  
                 
                  IconButton(
                    icon: const Icon(Icons
                        .visibility), // Changed to a visibility icon to indicate view action
                    onPressed: () {
                      _showPopup(context, profile);
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //       builder: (context) => Editprofile(
                      //           profile:
                      //               profile)), // Assuming ViewCustomerPage is the name of your detail page widget
                      // );
                    },) ,     
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons
                        .download), // Changed to a visibility icon to indicate view action
                    onPressed: () async {
                      await PdfGeneration.generatePdf(profile);
                    },
                    color: Color.fromARGB(255, 255, 255, 255), // Changed color to indicate it's a view action
                  ),
                     
                    
                    
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
