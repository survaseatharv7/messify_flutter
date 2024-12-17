import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messify/model/mess_model.dart';
import 'package:messify/pages/Registration.dart';
import 'package:messify/pages/loginScreen.dart';
import 'package:messify/main.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: MainApp.heightCal(110)),
            child: Image.asset("assets/logo.png"),
          ),
          Text(
            "Messify – Simplify Your Dining Experience!",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Inter',
                fontSize: MainApp.widthCal(24),
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: MainApp.heightCal(15)),
          Text(
            "Your Food Your Choice",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Inter',
                fontSize: MainApp.widthCal(15),
                color: Colors.black,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: MainApp.heightCal(40)),
          SizedBox(
            width: MainApp.widthCal(340),
            height: MainApp.heightCal(55),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Loginscreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 213, 198, 62),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(MainApp.widthCal(10)))),
              child: Text(
                "Log In",
                style: TextStyle(
                    color: Colors.white, fontSize: MainApp.widthCal(20)),
              ),
            ),
          ),
          SizedBox(height: MainApp.heightCal(15)),
          SizedBox(
            width: MainApp.widthCal(340),
            height: MainApp.heightCal(55),
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Registration(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(MainApp.widthCal(10)))

                  //backgroundColor: Color.white,
                  ),
              child: Text(
                "Sign Up",
                style: TextStyle(
                    color: Color.fromRGBO(44, 130, 199, 1),
                    fontSize: MainApp.widthCal(20)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
