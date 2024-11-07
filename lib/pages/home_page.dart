
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/logic/app_management_service/navigation_service.dart';
import 'package:flutter_chat_app/logic/locator.dart';


import 'package:flutter_chat_app/pages/user_page/create_profile.dart';
import 'package:flutter_chat_app/pages/user_page/profile_display.dart';

import 'package:watch_it/watch_it.dart';



class HomePage extends StatelessWidget with WatchItMixin {
  HomePage({super.key});

  // static final PageController _pageController = PageController(
  //     initialPage: Locator.navigationService.currentPageIndex.value);

  // void _onPageChanged(int index) {
  //   Locator.navigationService.setCurrentPageIndex(index);
  // }
 static TextEditingController searchController = TextEditingController();

  void _showPopup(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CreateProfile();
        },
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {

     Color selectedTextColor = const Color.fromARGB(255, 255, 255, 255);
  
    Color textColor = Theme.of(context).colorScheme.onPrimary;
    int currentPageIndex =
        watchValue((NavigationService x) => x.currentPageIndex);

    return Scaffold(
      body:Container(
       decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('lib/images/pdf_bg.webp'), // Replace with your actual image path
        fit: BoxFit.cover,
      ),
    ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
         backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                Container(
                color: Color.fromARGB(255, 141, 66, 66),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilledButton(
                    onPressed: () {
                      _showPopup(context);
                    
                    },
                    style: FilledButton.styleFrom(
                     backgroundColor: Color.fromARGB(255, 141, 66, 66),
                      shape: RoundedRectangleBorder(
                         side:BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(
                              15)), 
                      padding: const EdgeInsets.all(
                          18), 
                    ),
                    child: const Row(
                     
                      children: [
                        Icon(
                          Icons.add,
                          size: 30,
                          color:Colors.white,
                          
                        ),
                        SizedBox(
                            width: 12), 
                        Text(
                          'CREATE PROFILE',
                          style: TextStyle(
                            fontSize: 16,
                         
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 50),
                  Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          Locator.profileManagementService.profileQuery.value =
                              value;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              searchController.clear();
                              Locator.profileManagementService.profileQuery
                                  .value = "";
                            },
                            icon: const Icon(
                              Icons.clear,
                            ),
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Search',
                          labelStyle: const TextStyle(),
                        ),
                      ),
                    ),
                  const SizedBox(width: 50),
                 IconButton(onPressed: Locator.userManagementService.signOut, icon: Icon(Icons.logout))
                ],
                 
              ),
                ),
               const SizedBox(
                    height: 10,
                  ),
                 const Expanded(flex:4 , child: ProfileDisplay()),
         
            ],
          ),
        ),
      ),
    ),
      
    );
  }
}
