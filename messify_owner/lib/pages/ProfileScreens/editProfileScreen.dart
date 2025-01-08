import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messify_owner/main.dart';

class Myapp1 extends StatefulWidget {
  const Myapp1({super.key});

  @override
  State<Myapp1> createState() => _MyappState();
}

class _MyappState extends State<Myapp1> {
  Map<String, dynamic> profileDetailsMap = {};
  int buildContextCounter = 0;

  TextEditingController _messNameController = TextEditingController();
  TextEditingController _ownerNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    profileDetailsGetter();
  }

  void profileDetailsGetter() async {
    DocumentSnapshot response = await FirebaseFirestore.instance
        .collection('Messinfo')
        .doc(MainApp.messName)
        .get();

    profileDetailsMap['username'] = response['username'];
    profileDetailsMap['ownername'] = response['ownername'];
    profileDetailsMap['Email'] = response['Email'];
    profileDetailsMap['Phonenumber'] = response['Phonenumber'];
    profileDetailsMap['Password'] = response['Password'];
    profileDetailsMap['vegType'] = response['vegType'];
    profileDetailsMap['nonvegType'] = response['nonvegType'];
    profileDetailsMap['tiffinType'] = response['tiffinType'];

    _messNameController.text = profileDetailsMap['username'];
    _ownerNameController.text = profileDetailsMap['ownername'];
    _emailController.text = profileDetailsMap['Email'];
    _phoneNumberController.text = profileDetailsMap['Phonenumber'];
    _passwordController.text = profileDetailsMap['Password'];
    _confirmPasswordController.text = profileDetailsMap['Password'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //  // backgroundColor: Color.fromRGBO(255, 141, 118, 1),
      //  flexibleSpace:Container( decoration: const BoxDecoration(
      //                 gradient: LinearGradient(
      //                   colors: [
      //                     Color.fromRGBO(255, 121, 46, 1),
      //                     Color.fromRGBO(255, 181, 100, 1),
      //                   ],
      //                   begin: Alignment.topCenter,
      //                   end: Alignment.bottomCenter,
      //                 ),
      //               ),) ,
      //   leading: GestureDetector(
      //     onTap: () {
      //       Navigator.of(context).pop();
      //     },
      //     child: Container(
      //       child: Icon(
      //         Icons.arrow_back_ios,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ),
      //   // actions: [
      //   //   Padding(
      //   //     padding: const EdgeInsets.all(8.0),
      //   //     child: Icon(
      //   //       Icons.notifications_outlined,
      //   //       color: Colors.white,
      //   //       size: 30,
      //   //     ),
      //   //   ),
      //   // ],
      //   title: Text(
      //     "Edit Profile",
      //     style: GoogleFonts.poppins(
      //         color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
      //   ),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MainApp.heightCal(200),
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
                      Positioned(
                        top: MainApp.heightCal(30),
                        left: MainApp.widthCal(10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);

                            setState(() {});
                          },
                          child: Container(
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: MainApp.widthCal(30),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MainApp.heightCal(150),
                        //      decoration: const BoxDecoration(
                        //   gradient: LinearGradient(
                        //     colors: [
                        //       Color.fromRGBO(255, 121, 46, 1),
                        //       Color.fromRGBO(255, 181, 100, 1),
                        //     ],
                        //     begin: Alignment.topCenter,
                        //     end: Alignment.bottomCenter,
                        //   ),
                        // ),
                      ),
                      Positioned(
                        bottom: MainApp.heightCal(0),
                        child: Container(
                          height: MainApp.heightCal(122),
                          width: MainApp.widthCal(122),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white,
                                width: MainApp.widthCal(8)),
                          ),
                          child: Image.asset(
                            "assets/avtar.jpeg",
                            fit: BoxFit.cover,
                          ),
                          clipBehavior: Clip.antiAlias,
                        ),
                      ),
                    ],
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: GestureDetector(
                //     onTap: () {
                //       Navigator.of(context)
                //           .push(MaterialPageRoute(builder: (context) {
                //         return const Myapp1();
                //       }));
                //     },
                //     child: Container(
                //       height: 30,
                //       width: 150,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(5),
                //           color: Colors.white),
                //       child: Center(
                //           child: Text(
                //         "Change Picture",
                //         style: GoogleFonts.poppins(
                //             color: Colors.black,
                //             fontSize: 12,
                //             fontWeight: FontWeight.w500),
                //       )),
                //     ),
                //   ),
                // ),

                Padding(
                  padding: EdgeInsets.only(
                    left: MainApp.widthCal(36),
                    top: MainApp.heightCal(20),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Mess Name",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: MainApp.widthCal(14),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MainApp.widthCal(36),
                      right: MainApp.widthCal(36),
                      top: MainApp.heightCal(2)),
                  child: Container(
                    child: TextField(
                      readOnly: true,
                      controller: _messNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(MainApp.widthCal(8)),
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MainApp.widthCal(36), top: MainApp.heightCal(20)),
                  child: Row(
                    children: [
                      Text(
                        "Owner Name",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: MainApp.widthCal(14),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MainApp.widthCal(36),
                      right: MainApp.widthCal(36),
                      top: MainApp.heightCal(2)),
                  child: Container(
                    child: TextField(
                      controller: _ownerNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(MainApp.widthCal(8)),
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MainApp.widthCal(36), top: MainApp.heightCal(20)),
                  child: Row(
                    children: [
                      Text(
                        "Email I'd",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: MainApp.widthCal(14),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MainApp.widthCal(36),
                      right: MainApp.widthCal(36),
                      top: MainApp.heightCal(2)),
                  child: Container(
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              MainApp.widthCal(8),
                            ),
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MainApp.widthCal(36), top: MainApp.heightCal(20)),
                  child: Row(
                    children: [
                      Text(
                        "Phone Number",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: MainApp.widthCal(14),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MainApp.widthCal(36),
                      right: MainApp.widthCal(36),
                      top: MainApp.heightCal(2)),
                  child: Container(
                    child: TextField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              MainApp.widthCal(8),
                            ),
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MainApp.widthCal(36), top: MainApp.heightCal(20)),
                  child: Row(
                    children: [
                      Text(
                        "Password",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: MainApp.widthCal(14),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MainApp.widthCal(36),
                    right: MainApp.widthCal(36),
                    top: MainApp.heightCal(2),
                  ),
                  child: Container(
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              MainApp.widthCal(8),
                            ),
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MainApp.widthCal(36), top: MainApp.heightCal(20)),
                  child: Row(
                    children: [
                      Text(
                        "Confirm Password",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: MainApp.widthCal(14),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MainApp.widthCal(36),
                      right: MainApp.widthCal(36),
                      top: MainApp.heightCal(2)),
                  child: Container(
                    child: TextField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              MainApp.widthCal(8),
                            ),
                            borderSide: BorderSide(color: Colors.black)),
                      ),
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
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty &&
                          _messNameController.text.isNotEmpty &&
                          _ownerNameController.text.isNotEmpty &&
                          _phoneNumberController.text.isNotEmpty &&
                          _passwordController.text.trim() ==
                              _confirmPasswordController.text.trim()) {
                        profileDetailsMap['username'] =
                            _messNameController.text.trim();
                        profileDetailsMap['ownername'] =
                            _ownerNameController.text.trim();
                        profileDetailsMap['Email'] =
                            _emailController.text.trim();
                        profileDetailsMap['Phonenumber'] =
                            _phoneNumberController.text.trim();
                        profileDetailsMap['Password'] =
                            _passwordController.text.trim();

                        await FirebaseFirestore.instance
                            .collection('Messinfo')
                            .doc(MainApp.messName)
                            .delete();
                        await FirebaseFirestore.instance
                            .collection('Messinfo')
                            .doc(_messNameController.text.trim())
                            .set(profileDetailsMap);
                        setState(() {});
                        Navigator.pop(context);
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
                          padding: EdgeInsets.all(
                            MainApp.widthCal(8),
                          ),
                          child: Text(
                            "Update",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: MainApp.widthCal(15),
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
