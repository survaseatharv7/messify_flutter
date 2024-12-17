import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messify/pages/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCseZOQg7tDdizV6Pv51Z4dU2c041QXTL8",
      appId: "1:579643748294:android:01bdbc48426f9975df0cc7",
      messagingSenderId: "579643748294",
      projectId: "messify-flutter",
    ),
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static bool isLoggedIn = false;
  static String messsname = "";
  static String name = "";

  static String username = "";
  static int token = 0;

  static String userMapName = "";
  static String nameMapName = '';
  static String passwordMapName = '';
  static String emailMapName = '';

  static void userDetailsGetter(Map<String, dynamic> map) {
    userMapName = map['username'];
    emailMapName = map['Email'];
    passwordMapName = map['Password'];
    nameMapName = map['name'];
  }

  // Static properties for screen dimensions
  static double screenWidth = 0;
  static double screenHeight = 0;

  // Helper function for responsive width calculation
  static double widthCal(double inputWidth) {
    return (inputWidth / 414) * screenWidth; // Assuming base width of 414
  }

  // Helper function for responsive height calculation
  static double heightCal(double inputHeight) {
    return (inputHeight / 896) * screenHeight; // Assuming base height of 896
  }

  @override
  Widget build(BuildContext context) {
    // Initialize screen dimensions
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Splashscreen(),
    );
  }
}
