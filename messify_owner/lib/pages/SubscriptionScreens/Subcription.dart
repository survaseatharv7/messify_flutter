import 'dart:developer';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:messify_owner/main.dart';
import 'package:messify_owner/models/lastDateOfMonth.dart';
import 'package:messify_owner/pages/SessionMananger/session_data.dart';
import 'package:messify_owner/pages/SubscriptionScreens/subscribedMembers.dart';

import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';

class EnhancedSubscriptionCard extends StatelessWidget {
  const EnhancedSubscriptionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8), // Light background
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 8,
                spreadRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Left Column
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "1 Month",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "₹3800",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16), // Space between columns

              // Right Column
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "HomeLike Food",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "2 days nonVeg",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              // Action Button
              Container(
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orangeAccent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orangeAccent.withOpacity(0.5),
                      blurRadius: 6,
                      spreadRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    // Action for button
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class CalendarDay extends StatelessWidget {
//   final String day;
//   final bool isSelected;

//   CalendarDay({required this.day, this.isSelected = false});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: 5),
//       child: Container(
//         padding: EdgeInsets.all(8),
//         height: 50,
//         width: 50,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.orange : Colors.grey[200],
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Text(
//           day,
//           style: TextStyle(
//             fontSize: 16,
//             color: isSelected ? Colors.white : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }

class Subcription extends StatefulWidget {
  const Subcription({super.key});

  @override
  State<Subcription> createState() => _SubcriptionState();
}

class _SubcriptionState extends State<Subcription> {
  // int selectedDayIndex = DateTime.now().day - 1;
  dynamic selectedDate = DateTime.now();
  DateTime now = DateTime.now();
  // static int monthInt = DateTime.now().month;
  // int lastDate = LastDate(month: monthInt).lastDate;

  // List userAttendanceList = [];

  // void userAttendanceListGetter(DateTime date) async {
  //   log("In userAttendance Method");
  //   userAttendanceList.clear();
  //   try {
  //     QuerySnapshot response = await FirebaseFirestore.instance
  //         .collection('Attendence')
  //         .doc('${SessionData.messName}')
  //         .collection(
  //             '${DateTime.now().year}-${DateFormat("MM").format(DateTime.now())}-${DateFormat("dd").format(date)} ')
  //         .get();
  //     log("${DateTime.now().year}-${DateFormat("MM").format(DateTime.now())}-${DateFormat("dd").format(date)} ");
  //     log("After response");
  //     for (int i = 0; i < response.docs.length; i++) {
  //       Map map = {};
  //       map['username'] = response.docs[i].get('username');
  //       map['name'] = response.docs[i].get('name');
  //       map['token'] = response.docs[i].get('token').toString();
  //       userAttendanceList.add(map);
  //       log("User list = $userAttendanceList");
  //       log("After list");
  //       print(userAttendanceList);
  //     }
  //   } catch (e) {
  //     log("${e}");
  //   }

  //   setState(() {});
  // }

  Stream<List<Map<String, dynamic>>> userAttendanceListStream(DateTime date) {
    return FirebaseFirestore.instance
        .collection('Attendence')
        .doc('${SessionData.messName}')
        .collection(
            '${DateFormat('yyyy').format(date)}-${DateFormat("MM").format(date)}-${DateFormat("dd").format(date)} ')
        .snapshots()
        .map((QuerySnapshot snapshot) {
      log("Snapshot received");
      List<Map<String, dynamic>> userList = [];
      for (var doc in snapshot.docs) {
        userList.add({
          'username': doc['username'],
          'name': doc['name'],
          'token': doc['token'].toString(),
        });
      }
      log("User list = $userList");
      return userList;
    });
  }

  @override
  void initState() {
    super.initState();
    // userAttendanceListGetter(DateTime.now());
  }

  Widget cardBuilder() {
    return StreamBuilder<List<Map<String, dynamic>>>(
        stream: userAttendanceListStream(selectedDate),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); // Loading indicator
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No attendance data found."));
          }

          List<Map<String, dynamic>> userAttendanceList = snapshot.data!;

          return ListView.builder(
              itemCount: userAttendanceList.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [
                            Colors.orange.shade300,
                            Colors.orange.shade600
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: 80,
                                height: 80,
                                color: Colors.blue,
                                child: Image.asset("assets/avtar.jpeg",
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${userAttendanceList[index]['name']}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "${userAttendanceList[index]['username']}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Token left: ${userAttendanceList[index]['token']}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
              });
        });
  }

  // void _scrollToSelectedDay(int index) {
  //   double screenWidth = MediaQuery.of(context).size.width;
  //   double itemWidth = 60; // Adjust based on your actual item width
  //   double targetOffset =
  //       (index * itemWidth) - (screenWidth / 2) + (itemWidth / 2);

  //   _scrollController.animateTo(
  //     targetOffset.clamp(0.0,
  //         _scrollController.position.maxScrollExtent), // Ensure valid range
  //     duration: Duration(milliseconds: 300),
  //     curve: Curves.easeInOut,
  //   );
  // }

  void updateDate(DateTime newDate) {
    setState(() {
      selectedDate =
          newDate; // Update the state and trigger StreamBuilder refresh
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDateSelected =
        DateFormat('dd/MM/yyyy').format(selectedDate);
    String formattedDateCurrent = DateFormat('dd/MM/yyyy').format(now);

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MainApp.heightCal(50),
          ),
          // Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       Text(" Todays Date: $formattedDateCurrent",style: GoogleFonts.quicksand(textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w700)),),

          //       Text(" Selected Date: $formattedDateSelected",style: GoogleFonts.quicksand(textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w700)),),
          //     ],
          //   ),
          const SizedBox(
            height: 10,
          ),
          HorizontalWeekCalendar(
            minDate: DateTime(2000, 1, 1),
            maxDate: DateTime(2030, 1, 31),
            initialDate: selectedDate,
            onDateChange: (date) {
              // int selectedDate = int.parse(DateFormat('dd').format(date));
              updateDate(date);
              setState(() {});
            },
            //showTopNavbar: false,
            monthFormat: "MMMM yyyy",
            showNavigationButtons: false,
            weekStartFrom: WeekStartFrom.Sunday,
            borderRadius: BorderRadius.circular(7),
            activeBackgroundColor: Colors.orangeAccent,
            activeTextColor: Colors.white,
            inactiveBackgroundColor: Colors.orangeAccent.withOpacity(.3),
            inactiveTextColor: Colors.white,
            disabledTextColor: Colors.grey,
            disabledBackgroundColor: Colors.grey.withOpacity(.3),
            activeNavigatorColor: Colors.deepOrange,
            inactiveNavigatorColor: Colors.grey,
            monthColor: Colors.deepOrange,
          ),

          // Container(
          //   height: 70,
          //   width: MediaQuery.of(context).size.width, // Adjust height as needed

          //   child: ListView.builder(
          //     itemCount: lastDate,
          //     controller: _scrollController,
          //     scrollDirection: Axis.horizontal,
          //     itemBuilder: (context, dayIndex) {
          //       return GestureDetector(
          //         onTap: () {
          //           selectedDayIndex = dayIndex;
          //           _scrollToSelectedDay(dayIndex);
          //           userAttendanceListGetter(dayIndex + 1);
          //           setState(() {});
          //         },
          //         child: CalendarDay(
          //           day: "${dayIndex + 1}",
          //           isSelected: selectedDayIndex == dayIndex,
          //         ),
          //       );
          //     },
          //   ),
          // ),
          SizedBox(
            height: 50,
          ),
          Expanded(child: cardBuilder()),
          Padding(
            padding: EdgeInsets.all(MainApp.widthCal(20)),
            child: Container(
              height: MainApp.heightCal(100),
              width: MainApp.widthCal(400),
              decoration: BoxDecoration(
                color: Colors.white, // Background color of the container
                borderRadius: BorderRadius.circular(10), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 2), // Shadow position
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFfb8c00),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 5,
                    // minimumSize: Size.fromHeight(50),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Subscribedmembers()),
                    );
                  },
                  child: const Text(
                    "Subscribed Members",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
