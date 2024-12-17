import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messify/main.dart';
import 'package:messify/model/user_model.dart';
import 'package:messify/pages/MainDashboard.dart';
import 'package:messify/pages/Registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messify/pages/sessionData.dart';

class Loginscreen extends StatefulWidget {
  Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  List<UserModel> userList = [];

  // For toggling password visibility
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login Screen",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(
              left: 15,
              right: 15,
              top: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MainApp.heightCal(400),
                width: MainApp.widthCal(400),
                child:
                    Image.asset("assets/loginfinal.png", fit: BoxFit.contain),
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
                obscureText: !_isPasswordVisible, // Hide or show text
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  label: const Text(
                    "Enter Password",
                  ),
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
                      MainApp.isLoggedIn = true;

                      QuerySnapshot response = await FirebaseFirestore.instance
                          .collection("Userinfo")
                          .get();
                      userList.clear();

                      int index = 0;

                      for (int i = 0; i < response.docs.length; i++) {
                        print("${response.docs[i]['Email']}");
                        if (_userCredential.user!.email ==
                            "${response.docs[i]['Email']}") {
                          index = i;
                          break;
                        }
                      }

                      MainApp.name = response.docs[index]['name'];
                      MainApp.username = response.docs[index]['username'];

                      await Sessiondata.storeSessionData(
                          loginData: true,
                          username: MainApp.name,
                          userusername: MainApp.username);

                      print("username" + MainApp.name);
                      print("Session" + Sessiondata.usernameget!);
                      print(
                          "Session user username" + Sessiondata.userusername!);

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
                  height: MainApp.heightCal(50),
                  width: MainApp.widthCal(400),
                  alignment: Alignment.center,
                  color: const Color.fromARGB(255, 2, 25, 44),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 18,
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
