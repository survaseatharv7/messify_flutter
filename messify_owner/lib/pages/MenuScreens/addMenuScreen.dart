import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messify_owner/main.dart';
import 'package:messify_owner/pages/MenuScreens/breakfastSnackScreen.dart';
import 'package:messify_owner/pages/MenuScreens/lunchDinnerScreen.dart';
import 'package:messify_owner/pages/pollPage.dart';

class OwnerUI extends StatefulWidget {
  const OwnerUI({super.key});

  @override
  State<OwnerUI> createState() => _OwnerUIState();
}

class _OwnerUIState extends State<OwnerUI> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "What's New Today?",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          leading: Icon(Icons.more_horiz),
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    "Your Today's Meal",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return Breakfastmenu(
                              isSnackSelected: true,
                            );
                          }));
                        },
                        child: Container(
                          height: 175,
                          width: 175,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(233, 237, 248, 1),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.sunny_snowing,
                                      size: 50,
                                    ),
                                    Text(
                                      "Snack",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return LunchDinner(
                                isLunchSelected: true,
                              );
                            }),
                          );
                        },
                        child: Container(
                          height: 175,
                          width: 175,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(233, 237, 248, 1),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.wb_sunny_outlined,
                                      size: 50,
                                    ),
                                    Text(
                                      "Lunch",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return Breakfastmenu(
                                isSnackSelected: false,
                              );
                            }),
                          );
                        },
                        child: Container(
                          height: 175,
                          width: 175,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(233, 237, 248, 1),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.sunny_snowing,
                                      size: 50,
                                    ),
                                    Text(
                                      "NonVeg",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return LunchDinner(
                                isLunchSelected: false,
                              );
                            }),
                          );
                        },
                        child: Container(
                          height: 175,
                          width: 175,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(233, 237, 248, 1),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.mode_night_outlined,
                                      size: 50,
                                    ),
                                    Text(
                                      "Dinner",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            bottomSheetOpener();
            setState(() {});
          },
          child: const Icon(
            Icons.poll_outlined,
            size: 30,
          ),
          backgroundColor: Colors.orange,
        ),
      ),
    );
  }

  TextEditingController _questionController = TextEditingController();
  TextEditingController _option1Controller = TextEditingController();
  TextEditingController _option2Controller = TextEditingController();
  TextEditingController _option3Controller = TextEditingController();

  bottomSheetOpener() {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Add Your Poll Here",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 20),
                    child: Row(
                      children: [
                        Text(
                          "Question",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _questionController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.orange,
                          ),
                        )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 20),
                    child: Row(
                      children: [
                        Text(
                          "Option 1",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _option1Controller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.orange,
                          ),
                        )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 20),
                    child: Row(
                      children: [
                        Text(
                          "Option 2",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _option2Controller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.orange,
                          ),
                        )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 20),
                    child: Row(
                      children: [
                        Text(
                          "Option 3",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _option3Controller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.orange,
                          ),
                        )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: GestureDetector(
                      onTap: () async {
                        if (_questionController.text.trim().isNotEmpty &&
                            _option1Controller.text.trim().isNotEmpty &&
                            _option2Controller.text.trim().isNotEmpty) {
                          try {
                            bool isOption3 = false;
                            if (_option3Controller.text.trim().isNotEmpty) {
                              isOption3 = true;
                            }
                            int date = DateTime.now().day;
                            int month = DateTime.now().month;
                            int year = DateTime.now().year;

                            Map<String, dynamic> map = {};
                            map['question'] = _questionController.text.trim();
                            map['options'] = [
                              {
                                'title': _option1Controller.text.trim(),
                                'votes': 0
                              },
                              {
                                'title': _option2Controller.text.trim(),
                                'votes': 0
                              },
                              {
                                'title': _option3Controller.text.trim(),
                                'votes': 0
                              },
                            ];

                            await FirebaseFirestore.instance
                                .collection('Poll')
                                .doc(MainApp.messName)
                                .collection('PollData')
                                .doc('${year}-${month}-${date}')
                                .set(map);

                            _questionController.clear();
                            _option1Controller.clear();
                            _option2Controller.clear();
                            _option3Controller.clear();

                            Navigator.pop(context);
                          } on FirebaseException catch (e) {
                            print(e.message);
                          }
                        }
                        setState(() {});
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.orange),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Center(
                            child: Text(
                              "Post",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}