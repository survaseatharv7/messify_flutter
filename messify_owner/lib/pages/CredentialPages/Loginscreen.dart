import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:messify_owner/main.dart';
import 'package:messify_owner/pages/HomeScreen/Maindashboard.dart';
import 'package:messify_owner/pages/CredentialPages/Registrationscreen.dart';

// ignore: must_be_immutable
class Loginscreen extends StatelessWidget {
  Loginscreen({super.key});

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login Screen",
          style: TextStyle(
              fontSize: MainApp.widthCal(20), fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(
              left: MainApp.widthCal(15),
              right: MainApp.widthCal(15),
              top: MainApp.heightCal(15),
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MainApp.heightCal(400),
                width: MainApp.widthCal(400),
                child:
                    Image.asset("assets/loginpage.jpeg", fit: BoxFit.contain),
              ),
              SizedBox(
                height: MainApp.heightCal(10),
              ),
              Text(
                "Welcome Back User!",
                style: TextStyle(
                    fontSize: MainApp.widthCal(20),
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: MainApp.heightCal(5),
              ),
              Text(
                "Please sign in to continue",
                //textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: MainApp.widthCal(16),
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              SizedBox(
                height: MainApp.heightCal(15),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.supervised_user_circle),
                  label: const Text(
                    "Enter Username",
                  ),
                  border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(MainApp.widthCal(10))),
                ),
              ),
              SizedBox(
                height: MainApp.heightCal(15),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  label: const Text(
                    "Enter Password",
                  ),
                  border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(MainApp.widthCal(10))),
                ),
              ),
              SizedBox(
                height: MainApp.heightCal(20),
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    if (_emailController.text.trim().isNotEmpty &&
                        _passwordController.text.trim().isNotEmpty) {
                      UserCredential _userCredential =
                          await _firebaseAuth.signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text);

                      QuerySnapshot response = await FirebaseFirestore.instance
                          .collection("Messinfo")
                          .get();

                      int index = 0;

                      for (int i = 0; i < response.docs.length; i++) {
                        if (_userCredential.user!.email ==
                            "${response.docs[i]['Email']}") {
                          index = i;
                          break;
                        }
                      }

                      MainApp.messName = response.docs[index]['username'];

                      MainApp.isLoggedIn = true;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Maindashboard()));
                    }
                  } on FirebaseAuthException catch (error) {
                    print(error.message);
                  }
                  /*Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Maindashboard()));*/
                },
                child: Container(
                  height: MainApp.heightCal(50),
                  width: MainApp.widthCal(400),
                  alignment: Alignment.center,
                  color: const Color.fromARGB(255, 2, 25, 44),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: MainApp.widthCal(18),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: MainApp.heightCal(20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't Have an Account?",
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: MainApp.widthCal(16),
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 95, 87, 87)),
                  ),
                  SizedBox(
                    width: MainApp.widthCal(5),
                  ),
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
                          fontSize: MainApp.widthCal(18),
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
