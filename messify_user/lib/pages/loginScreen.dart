import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:messify/main.dart';
import 'package:messify/model/user_model.dart';
import 'package:messify/pages/MainDashboard.dart';
import 'package:messify/pages/Registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messify/pages/sessionData.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared preferences

class Loginscreen extends StatefulWidget {
  Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    // Check if the user is already logged in when the screen is initialized
  }

  // Method to check if the user is already logged in

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login Screen",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(
            left: 15.w,
            right: 15.w,
            top: 15.h,
            bottom: 15.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 400.h,
                width: 400.w,
                child:
                    Image.asset("assets/loginfinal.png", fit: BoxFit.contain),
              ),
              SizedBox(height: 10.h),
              Text(
                "Welcome Back User!",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 5.h),
              Text(
                "Please sign in to continue",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              SizedBox(height: 15.h),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.supervised_user_circle),
                  label: const Text("Enter Username"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                ),
              ),
              SizedBox(height: 15.h),
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  label: const Text("Enter Password"),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () async {
                  try {
                    if (_emailController.text.trim().isNotEmpty &&
                        _passwordController.text.trim().isNotEmpty) {
                      UserCredential _userCredential =
                          await _firebaseAuth.signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text);

                      // Fetch user data from Firestore
                      QuerySnapshot response = await FirebaseFirestore.instance
                          .collection("Userinfo")
                          .get();

                      int index = 0;
                      for (int i = 0; i < response.docs.length; i++) {
                        if (_userCredential.user!.email ==
                            response.docs[i]['Email']) {
                          index = i;
                          break;
                        }
                      }

                      // Store the user data in session
                      MainApp.name = response.docs[index]['name'];
                      MainApp.username = response.docs[index]['username'];

                      await Sessiondata.storeSessionData(
                          loginData: true,
                          username: MainApp.name,
                          userusername: MainApp.username);

                      // Store login status in SharedPreferences
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('isLoggedIn', true);
                      prefs.setString('username', MainApp.name);
                      prefs.setString('userusername', MainApp.username);

                      // Navigate to dashboard
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Maindashboard()));
                    }
                  } on FirebaseAuthException catch (error) {
                    print(error.message);
                  }
                },
                child: Container(
                  height: 50.h,
                  width: 400.w,
                  alignment: Alignment.center,
                  color: const Color.fromARGB(255, 2, 25, 44),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't Have an Account?",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 95, 87, 87)),
                  ),
                  SizedBox(width: 5.w),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Registration(),
                        ),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
