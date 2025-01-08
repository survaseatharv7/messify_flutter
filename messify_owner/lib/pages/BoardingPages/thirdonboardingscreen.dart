import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messify_owner/main.dart';
import 'package:messify_owner/pages/BoardingPages/Splashscreen.dart';

class Thirdonboardingscreen extends StatelessWidget {
  const Thirdonboardingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: MainApp.heightCal(60)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: MainApp.heightCal(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Track Attendance",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color.fromRGBO(255, 121, 46, 1),
                        fontSize: MainApp.widthCal(25),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: MainApp.heightCal(10)),
                    Text(
                      "Track the attendance of students who visit the mess.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.averiaLibre(
                        color: Colors.black87,
                        fontSize: MainApp.widthCal(20),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MainApp.heightCal(10)),
              Padding(
                padding: EdgeInsets.all(MainApp.widthCal(15)),
                child: Container(
                  height: MainApp.heightCal(500),
                  width: MainApp.widthCal(500),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10.0,
                        offset: Offset(0, -2),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(MainApp.widthCal(15))),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(MainApp.widthCal(20)),
                    child: Image.asset(
                      "assets/attendence.jpeg",
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
                          builder: (context) => const Splashscreen()));
                },
                child: Container(
                  height: MainApp.heightCal(70),
                  width: MainApp.widthCal(450),
                  alignment: Alignment.center,
                  color: const Color.fromRGBO(255, 121, 46, 1),
                  child: Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MainApp.widthCal(24),
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
