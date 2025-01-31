import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messify_owner/pages/BoardingPages/firstonboardingscreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCseZOQg7tDdizV6Pv51Z4dU2c041QXTL8",
          appId: "1:579643748294:android:01bdbc48426f9975df0cc7",
          messagingSenderId: "579643748294",
          projectId: "messify-flutter"));

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => MessNameViewModel(messName: ""),
        ),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static String messName = '';

  static double screenWidth = 0;
  static double screenHeight = 0;

  static const double referenceWidth = 411.42;
  static const double referenceHeight = 890.28;

  static double widthCal(double width) {
    return (width / referenceWidth) * screenWidth;
  }

  static double heightCal(double height) {
    return (height / referenceHeight) * screenHeight;
  }

  static bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loginscreen(),
    );
  }
}
