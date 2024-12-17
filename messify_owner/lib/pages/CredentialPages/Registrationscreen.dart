import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:messify_owner/main.dart';
import 'package:messify_owner/models/ownerdetails.dart';
import 'package:messify_owner/pages/CredentialPages/Loginscreen.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobilenoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _ownernameController = TextEditingController();

  List<Ownerdetails> owner_info = [];
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool vegType = false;
  bool nonvegType = false;
  bool tiffinType = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back_ios),
        title: Text(
          "Create Account",
          style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: MainApp.widthCal(20),
              fontWeight: FontWeight.w400),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: MainApp.heightCal(150),
                    width: MainApp.widthCal(150),
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
                        fontSize: MainApp.widthCal(25),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MainApp.heightCal(8)),
                  child: Text(
                    "You need to register yourself before getting started ",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: MainApp.widthCal(13),
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: MainApp.widthCal(30)),
                  child: Row(
                    children: [
                      Text("Veg"),
                      GestureDetector(
                        onTap: () {
                          vegType = !vegType;
                          setState(() {});
                        },
                        child: Container(
                          height: MainApp.heightCal(25),
                          width: MainApp.widthCal(25),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black)),
                          child: vegType
                              ? Icon(
                                  Icons.done,
                                  size: 20,
                                )
                              : null,
                        ),
                      ),
                      SizedBox(
                        width: MainApp.widthCal(20),
                      ),
                      Text("NonVeg"),
                      GestureDetector(
                        onTap: () {
                          nonvegType = !nonvegType;
                          setState(() {});
                        },
                        child: Container(
                          height: MainApp.heightCal(25),
                          width: MainApp.widthCal(25),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black)),
                          child: nonvegType
                              ? Icon(
                                  Icons.done,
                                  size: 20,
                                )
                              : null,
                        ),
                      ),
                      SizedBox(
                        width: MainApp.widthCal(20),
                      ),
                      Text("Tiffin"),
                      GestureDetector(
                        onTap: () {
                          tiffinType = !tiffinType;
                          setState(() {});
                        },
                        child: Container(
                          height: MainApp.heightCal(25),
                          width: MainApp.widthCal(25),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black)),
                          child: tiffinType
                              ? Icon(
                                  Icons.done,
                                  size: 20,
                                )
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MainApp.widthCal(20),
                      right: MainApp.widthCal(20),
                      top: MainApp.heightCal(15)),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.contacts_rounded,
                          color: Colors.black,
                          size: MainApp.widthCal(20),
                        ),
                        hintText: "Enter MessName",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(MainApp.widthCal(10)))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MainApp.widthCal(20),
                      right: MainApp.widthCal(20),
                      top: MainApp.heightCal(15)),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: _ownernameController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.contacts_rounded,
                            color: Colors.black,
                            size: MainApp.widthCal(20),
                          ),
                          hintText: "   Enter Owner Name",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(MainApp.widthCal(10)))),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MainApp.widthCal(20),
                      right: MainApp.widthCal(20),
                      top: MainApp.heightCal(15)),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: _mobilenoController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.call,
                            color: Colors.black,
                            size: MainApp.widthCal(20),
                          ),
                          hintText: "   Enter Phone Number",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(MainApp.widthCal(10)))),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MainApp.widthCal(20),
                      right: MainApp.widthCal(20),
                      top: MainApp.heightCal(15)),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Colors.black,
                            size: MainApp.widthCal(20),
                          ),
                          hintText: "   Enter Email",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(MainApp.widthCal(10)))),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MainApp.widthCal(20),
                      right: MainApp.widthCal(20),
                      top: MainApp.heightCal(15)),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black,
                            size: MainApp.widthCal(20),
                          ),
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(MainApp.widthCal(10)))),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MainApp.widthCal(20),
                      right: MainApp.widthCal(20),
                      top: MainApp.heightCal(15)),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black,
                            size: MainApp.widthCal(20),
                          ),
                          hintText: "Confirm Password",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(MainApp.widthCal(10)))),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MainApp.widthCal(54),
                      right: MainApp.widthCal(54),
                      top: MainApp.heightCal(30),
                      bottom: MainApp.heightCal(30)),
                  child: GestureDetector(
                    onTap: () async {
                      {
                        try {
                          if (_nameController.text.trim().isNotEmpty &&
                              _ownernameController.text.trim().isNotEmpty &&
                              _mobilenoController.text.trim().isNotEmpty &&
                              _emailController.text.trim().isNotEmpty &&
                              _passwordController.text.trim().isNotEmpty) {
                            UserCredential _userCredential = await _firebaseAuth
                                .createUserWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text);

                            Map<String, dynamic> data = {
                              "username": _nameController.text.trim(),
                              "ownername": _ownernameController.text.trim(),
                              "Phonenumber": _mobilenoController.text.trim(),
                              "Email": _emailController.text.trim(),
                              "Password": _passwordController.text.trim(),
                              'vegType': vegType,
                              'nonvegType': nonvegType,
                              'tiffinType': tiffinType,
                              'totalRating': 0,
                              'noOfRaters': 0,
                            };

                            // Use await to wait for the Firestore operation to complete
                            await FirebaseFirestore.instance
                                .collection("Messinfo")
                                .doc(_nameController.text)
                                .set(data);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Data Added Successfully")));

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Loginscreen()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Please fill in all fields")));
                          }
                        } catch (e) {
                          // Print the error for debugging
                          print("Error adding data: ${e.toString()}");
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error adding data: $e")));
                        }
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(MainApp.widthCal(10)),
                        color: Colors.black,
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(MainApp.widthCal(8)),
                          child: Text(
                            "Register",
                            style: GoogleFonts.poppins(
                                color: const Color.fromARGB(255, 244, 220, 0),
                                fontSize: MainApp.widthCal(15),
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
