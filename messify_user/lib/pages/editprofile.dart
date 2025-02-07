import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messify/main.dart';
import 'package:messify/pages/sessionData.dart';

class Myapp1 extends StatefulWidget {
  const Myapp1({super.key});

  @override
  State<Myapp1> createState() => _MyappState();
}

class _MyappState extends State<Myapp1> {
  Map<String, dynamic> profileDetailsMap = {};
  int buildContextCounter = 0;

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    profileDetailsGetter();
  }

  void profileDetailsGetter() async {
    DocumentSnapshot response = await FirebaseFirestore.instance
        .collection('Userinfo')
        .doc(Sessiondata.userusername)
        .get();

    profileDetailsMap['Email'] = response['Email'];
    profileDetailsMap['Phonenumber'] = response['Phonenumber'];
    profileDetailsMap['Password'] = response['Password'];
    profileDetailsMap['name'] = response['name'];
    profileDetailsMap['username'] = response['username'];

    _userNameController.text = profileDetailsMap['username'];
    _emailController.text = profileDetailsMap['Email'];
    _nameController.text = profileDetailsMap['name'];
    _phoneNumberController.text = profileDetailsMap['Phonenumber'];
    _passwordController.text = profileDetailsMap['Password'];
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
                  height: 200.h,
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
                        top: 30.h,
                        left: 10.w,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);

                            setState(() {});
                          },
                          child: Container(
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: 30.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150.h,
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
                        bottom: 0,
                        child: Container(
                          height: 122.h,
                          width: 122.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 5.w),
                          ),
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
                  padding: EdgeInsets.only(left: 36.w, top: 20.h),
                  child: Row(
                    children: [
                      Text(
                        "Username",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 36.w, right: 36.w, top: 2.h),
                  child: Container(
                    child: TextField(
                      readOnly: true,
                      controller: _userNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 36.w, top: 20.h),
                  child: Row(
                    children: [
                      Text(
                        "Name",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 36.w, right: 36.w, top: 2.h),
                  child: Container(
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 36.w, top: 20.h),
                  child: Row(
                    children: [
                      Text(
                        "Email I'd",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 36.w, right: 36.w, top: 2.h),
                  child: Container(
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 36.w, top: 20.h),
                  child: Row(
                    children: [
                      Text(
                        "Phone Number",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 36.w, right: 36.w, top: 2.h),
                  child: Container(
                    child: TextField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 36.w, top: 20.h),
                  child: Row(
                    children: [
                      Text(
                        "Password",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 36.w,
                    right: 36.w,
                    top: 2.h,
                  ),
                  child: Container(
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      left: 54.w, right: 54.w, top: 30.h, bottom: 30.h),
                  child: GestureDetector(
                    onTap: () async {
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty &&
                          _userNameController.text.isNotEmpty &&
                          _nameController.text.isNotEmpty &&
                          _phoneNumberController.text.isNotEmpty) {
                        profileDetailsMap['username'] =
                            _userNameController.text.trim();
                        profileDetailsMap['name'] = _nameController.text.trim();
                        profileDetailsMap['Email'] =
                            _emailController.text.trim();
                        profileDetailsMap['Phonenumber'] =
                            _phoneNumberController.text.trim();
                        profileDetailsMap['Password'] =
                            _passwordController.text.trim();

                        await FirebaseFirestore.instance
                            .collection('Userinfo')
                            .doc(Sessiondata.usernameget)
                            .delete();
                        await FirebaseFirestore.instance
                            .collection('Userinfo')
                            .doc(_userNameController.text.trim())
                            .set(profileDetailsMap);
                        setState(() {});
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: Text(
                            "Update",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15.sp,
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
