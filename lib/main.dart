import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_chat_app/firebase_options.dart';
import 'package:flutter_chat_app/logic/locator.dart';
import 'package:flutter_chat_app/pages/home_page.dart';
import 'package:flutter_chat_app/pages/login_page.dart';
import 'package:flutter_chat_app/pages/screen_selector.dart';



void  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
  Locator.setup();
  await Locator.startupService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:ScreenSelector(),
      
    );
  }
}
