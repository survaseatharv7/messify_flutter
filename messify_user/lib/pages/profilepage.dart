import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messify/main.dart';
import 'package:messify/pages/MainDashboard.dart';
import 'package:messify/pages/editprofile.dart';
import 'package:messify/pages/loginScreen.dart';

void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Messify(),
    );
  }
}

class Messify extends StatefulWidget {
  const Messify({super.key});

  @override
  State<Messify> createState() => _MessifyState();
}

class _MessifyState extends State<Messify> {
  @override
  Widget build(BuildContext context) {
    return profilePage();
  }

  Widget profilePage() {
    return Scaffold(
      appBar: AppBar(
        title: Text(MainApp.username),
        leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Maindashboard(),
                ),
              );
            },
            child: Icon(Icons.arrow_back)),
      ),
      /*appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 141, 118, 1),
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),*/
      body: Container(
        //color: Colors.white,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 121, 46, 1),
                      Color.fromRGBO(255, 181, 100, 1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(255, 121, 46, 1),
                            Color.fromRGBO(255, 181, 100, 1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 122,
                        width: 122,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 5),
                            color: Colors.blue),
                        child: Image.asset(
                          "assets/avtar.png",
                          fit: BoxFit.cover,
                        ),
                        clipBehavior: Clip.antiAlias,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const Myapp1();
                    }));
                  },
                  child: Container(
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black),
                    child: Center(
                        child: Text(
                      "Edit Profile",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        color: Color.fromRGBO(246, 246, 246, 1),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 26),
                          child: Text(
                            "Profile",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      //width: MediaQuery.of(context).size.width,
                      //color: Color.fromRGBO(246, 246, 246, 1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 26),
                        child: Text(
                          "Subscribed Users",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      //width: MediaQuery.of(context).size.width,
                      //color: Color.fromRGBO(246, 246, 246, 1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 26),
                        child: Text(
                          "About Us",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
              /* Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      //width: MediaQuery.of(context).size.width,
                      //color: Color.fromRGBO(246, 246, 246, 1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 26),
                        child: Text(
                          "About Us",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        color: Color.fromRGBO(246, 246, 246, 1),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 26),
                          child: Text(
                            "Content",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      //width: MediaQuery.of(context).size.width,
                      //color: Color.fromRGBO(246, 246, 246, 1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 26),
                        child: Text(
                          "Downloads",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      //width: MediaQuery.of(context).size.width,
                      //color: Color.fromRGBO(246, 246, 246, 1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 26),
                        child: Text(
                          "Favourite",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        color: Color.fromRGBO(246, 246, 246, 1),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 26),
                          child: Text(
                            "Preferences",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      //width: MediaQuery.of(context).size.width,
                      //color: Color.fromRGBO(246, 246, 246, 1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 26),
                        child: Text(
                          "Language",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      //width: MediaQuery.of(context).size.width,
                      //color: Color.fromRGBO(246, 246, 246, 1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 26),
                        child: Text(
                          "Dark Mode",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              )*/

              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Add your logout functionality here
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Logout Confirmation'),
                          content: Text('Are you sure you want to log out?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                                // Perform logout
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => Loginscreen()),
                                    (route) => false);
                              },
                              child: Text('Logout'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.logout, color: Colors.white),
                  label: Text(
                    'Logout',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
