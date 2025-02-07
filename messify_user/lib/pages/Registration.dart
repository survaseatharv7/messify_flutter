import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messify/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messify/model/user_model.dart';
import 'package:messify/pages/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  List<UserModel> messList = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mobilenoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              setState(() {});
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: Text(
          "Create Account",
          style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.w400),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 150.h,
                    width: 150.w,
                    child: Image.asset(
                      "assets/reg.jpeg",
                      fit: BoxFit.cover,
                    )),
                Padding(
                  padding: EdgeInsets.only(top: MainApp.heightCal(20)),
                  child: Text(
                    "Just One Step Away ",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    "You need to register yourself before getting started ",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.contacts_rounded,
                            color: Colors.black,
                            size: 20.sp,
                          ),
                          hintText: "   Enter Your Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r))),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.contacts_rounded,
                            color: Colors.black,
                            size: 20.sp,
                          ),
                          hintText: "   Enter Username",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.r))),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: _mobilenoController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.call,
                            color: Colors.black,
                            size: 20.sp,
                          ),
                          hintText: "   Enter Phone Number",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r))),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Colors.black,
                            size: 20.sp,
                          ),
                          hintText: "   Enter Mail",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.r))),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black,
                            size: 20.sp,
                          ),
                          hintText: "   Enter Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.w))),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 54.w, right: 54.w, top: 30.h, bottom: 30.h),
                  child: GestureDetector(
                    onTap: () async {
                      try {
                        if (_emailController.text.trim().isNotEmpty &&
                            _passwordController.text.trim().isNotEmpty &&
                            _nameController.text.trim().isNotEmpty &&
                            _usernameController.text.trim().isNotEmpty &&
                            _mobilenoController.text.trim().isNotEmpty) {
                          UserCredential _userCredential = await _firebaseAuth
                              .createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text);

                          Map<String, dynamic> data = {
                            "name": _nameController.text.trim(),
                            "username": _usernameController.text.trim(),
                            "Phonenumber": _mobilenoController.text.trim(),
                            "Email": _emailController.text.trim(),
                            "Password": _passwordController.text.trim(),
                          };
                          await _firebaseFirestore
                              .collection("Userinfo")
                              .doc(_usernameController.text)
                              .set(data);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Data Added Successfully")));

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Loginscreen()));
                        }
                      } on FirebaseAuthException catch (error) {
                        print(error.message);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.black,
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: Text(
                            "Register",
                            style: GoogleFonts.poppins(
                                color: const Color.fromARGB(255, 244, 220, 0),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
