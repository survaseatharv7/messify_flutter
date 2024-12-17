import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messify_owner/main.dart';
import 'package:messify_owner/pages/BoardingPages/thirdonboardingscreen.dart';

class Secondboardingscreen extends StatelessWidget {
  const Secondboardingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Subscription Management",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color.fromRGBO(255, 121, 46, 1),
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: MainApp.heightCal(10)),
                    Text(
                      "Add and manage subscription details for the students in your mess.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.averiaLibre(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MainApp.heightCal(10)),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: MainApp.heightCal(500),
                  width: MainApp.widthCal(500),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10.0,
                        offset: Offset(0, -2),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/subcription.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MainApp.heightCal(10),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Thirdonboardingscreen()));
                },
                child: Container(
                  height: MainApp.heightCal(70),
                  width: MainApp.widthCal(450),
                  alignment: Alignment.center,
                  color: const Color.fromRGBO(255, 121, 46, 1),
                  child: const Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
