import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messify_owner/main.dart';
import 'package:messify_owner/models/breadModel.dart';

import 'package:messify_owner/models/lunchDinnerModel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:messify_owner/models/mainCourseModel.dart';
//import 'maincourseModel.dart';

class LunchDinner extends StatefulWidget {
  bool isLunchSelected;
  LunchDinner({super.key, required this.isLunchSelected});

  @override
  State<LunchDinner> createState() => __LunchDinnerState();
}

class __LunchDinnerState extends State<LunchDinner> {
  TextEditingController itemController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController sabji1Controller = TextEditingController();
  TextEditingController sabji2Controller = TextEditingController();
  TextEditingController chapatiBhakriController = TextEditingController();
  TextEditingController chapatiBhakriCountController = TextEditingController();
  TextEditingController riceController = TextEditingController();
  TextEditingController dalController = TextEditingController();

  TextEditingController mainController = TextEditingController();

  TextEditingController breadController = TextEditingController();

  List lunchList = [];
  bool isMain = false;

  List dinnerList = [];

  List listOfImages = [Image.asset("assets/thali.png")];

  TextEditingController sweetController = TextEditingController();

  Widget lunchOrDinnerStreamBuilder({bool isLunch = false}) {
    return StreamBuilder<List<Map<String, dynamic>>>(
        stream: isLunch ? lunchListStream() : dinnerListStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error ${snapshot.error}"),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text("No Menu Added Yet"),
            );
          }

          final outerList = snapshot.data!;

          final list = outerList[0];
          return Slidable(
              endActionPane: ActionPane(
                motion: const BehindMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      if (isLunch) {
                        deleteLunch();
                      } else {
                        deleteDinner();
                      }

                      setState(() {});
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    //label: 'Delete',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      bottomSheetThali(isEdit: true);
                    },
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    // label: 'Edit',
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(MainApp.widthCal(8)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(MainApp.widthCal(15)),
                    color: Colors.orange,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Section
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(MainApp.widthCal(10)),
                            ),
                            child: Image.asset(
                              "assets/thali.png",
                              fit: BoxFit.cover,
                            ),
                            height: MainApp.heightCal(100),
                            width: MainApp.widthCal(100),
                          ),
                          SizedBox(height: MainApp.heightCal(10)),
                          Text("Price : ${list['price']}")
                        ],
                      ),

                      // Content Section
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: MainApp.widthCal(10),
                              vertical: MainApp.heightCal(5)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Item Name
                              Center(
                                child: Text(
                                  isLunch ? "Lunch" : "Dinner",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: MainApp.widthCal(16),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              Divider(
                                color: Colors.white54,
                                thickness: 0.5,
                                height: MainApp.heightCal(10),
                              ),

                              // Sabji 1 and Sabji 2
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "1: ${list['sabji1']}",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: MainApp.widthCal(12),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "2: ${list['sabji2']}",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: MainApp.widthCal(12),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: MainApp.heightCal(5)),

                              // Sweet and Chapati
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "Sweet: ${list['sweet']}",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: MainApp.widthCal(12),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "${list['chapati']}: ${list['count']}",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: MainApp.widthCal(12),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: MainApp.heightCal(5)),

                              // Rice and Dal
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "Rice: ${list['rice']}",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: MainApp.widthCal(12),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Dal: ${list['dal']}",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: MainApp.widthCal(12),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(child: Icon(Icons.arrow_back_ios_new))),
          title: Text(
            "Today's Menu",
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: MainApp.widthCal(20),
                fontWeight: FontWeight.w500),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(MainApp.widthCal(20)),
              child: Row(
                children: [
                  Text(
                    "Thali",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: MainApp.widthCal(20),
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      bottomSheetThali(isEdit: false);
                    },
                    child: Container(
                      height: MainApp.heightCal(40),
                      width: MainApp.widthCal(40),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.orange),
                      child: Icon(
                        Icons.add,
                        size: MainApp.widthCal(30),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            lunchOrDinnerStreamBuilder(isLunch: widget.isLunchSelected)
          ],
        ),
      ),
    );
  }

  void editLunch() {
    dynamic map = lunchList[0];
    sabji1Controller.text = map['sabji1'];
    sabji2Controller.text = map['sabji2'];
    sweetController.text = map['sweet'];
    chapatiBhakriController.text = map['chapati'];
    chapatiBhakriCountController.text = map['count'];
    riceController.text = map['rice'];
    dalController.text = map['dal'];
    priceController.text = map['price'];
  }

  void editDinner() {
    dynamic map = dinnerList[0];
    sabji1Controller.text = map['sabji1'];
    sabji2Controller.text = map['sabji2'];
    sweetController.text = map['sweet'];
    chapatiBhakriController.text = map['chapati'];
    chapatiBhakriCountController.text = map['count'];
    riceController.text = map['rice'];
    dalController.text = map['dal'];
    priceController.text = map['price'];
  }

  void deleteLunch() async {
    await FirebaseFirestore.instance
        .collection('Menu')
        .doc('${MainApp.messName}')
        .collection('Lunch')
        .doc('LunchMenu')
        .delete();
  }

  void deleteDinner() async {
    await FirebaseFirestore.instance
        .collection('Menu')
        .doc('${MainApp.messName}')
        .collection('Dinner')
        .doc('DinnerMenu')
        .delete();
  }

  dynamic nullChecker(dynamic value) {
    return value ?? "Not updated";
  }

  Stream<List<Map<String, dynamic>>> lunchListStream() {
    return FirebaseFirestore.instance
        .collection('Menu')
        .doc('${MainApp.messName}')
        .collection('Lunch')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'sabji1': doc['sabji1'],
          'sabji2': doc['sabji2'],
          'sweet': doc['sweet'],
          'chapati': doc['chapati'],
          'count': doc['count'],
          'rice': doc['rice'],
          'dal': doc['dal'],
          'price': doc['price'],
        };
      }).toList();
    });
  }

  Stream<List<Map<String, dynamic>>> dinnerListStream() {
    return FirebaseFirestore.instance
        .collection('Menu')
        .doc('${MainApp.messName}')
        .collection('Dinner')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'sabji1': doc['sabji1'],
          'sabji2': doc['sabji2'],
          'sweet': doc['sweet'],
          'chapati': doc['chapati'],
          'count': doc['count'],
          'rice': doc['rice'],
          'dal': doc['dal'],
          'price': doc['price'],
        };
      }).toList();
    });
  }

  void lunchListGetter() async {
    DocumentSnapshot response = await FirebaseFirestore.instance
        .collection('Menu')
        .doc('${MainApp.messName}')
        .collection('Lunch')
        .doc('LunchMenu')
        .get();
    lunchList.clear();

    Map<String, dynamic> map = {};
    map['sabji1'] = nullChecker(
      response['sabji1'],
    );
    map['sabji2'] = nullChecker(response['sabji2']);
    map['sweet'] = nullChecker(response['sweet']);
    map['chapati'] = nullChecker(response['chapati']);
    map['count'] = nullChecker(
      response['count'],
    );
    map['rice'] = nullChecker(
      response['rice'],
    );
    map['dal'] = nullChecker(
      response['dal'],
    );
    map['price'] = nullChecker(
      response['price'],
    );

    lunchList.add(map);
    print(lunchList);
    setState(() {});
  }

  void dinnerListGetter() async {
    DocumentSnapshot response = await FirebaseFirestore.instance
        .collection('Menu')
        .doc('${MainApp.messName}')
        .collection('Dinner')
        .doc('DinnerMenu')
        .get();
    dinnerList.clear();

    Map map = {};
    map['sabj1'] = nullChecker(
      response['sabji1'],
    );
    map['sabj2'] = nullChecker(
      response['sabji2'],
    );
    map['sweet'] = nullChecker(response['sweet']);
    map['chapati'] = nullChecker(response['chapati']);
    map['count'] = nullChecker(
      response['count'],
    );
    map['rice'] = nullChecker(
      response['rice'],
    );
    map['dal'] = nullChecker(
      response['dal'],
    );
    map['price'] = nullChecker(
      response['price'],
    );

    dinnerList.add(map);
    print(dinnerList);
    setState(() {});
  }

  void submit({bool isedit = false}) async {
    bool isSabji2 = sabji2Controller.text.trim().isNotEmpty;
    bool isSweet = sweetController.text.trim().isNotEmpty;
    bool isChapati = chapatiBhakriController.text.trim().isNotEmpty;
    bool isCount = chapatiBhakriCountController.text.trim().isNotEmpty;
    bool isRice = riceController.text.trim().isNotEmpty;
    bool isDal = dalController.text.trim().isNotEmpty;

    if (sabji1Controller.text.trim().isNotEmpty &&
        priceController.text.trim().isNotEmpty) {
      if (widget.isLunchSelected) {
        Map<String, dynamic> map = {};
        map['sabji1'] = sabji1Controller.text.trim();
        map['sabji2'] = isSabji2 ? sabji2Controller.text.trim() : null;
        map['sweet'] = isSweet ? sweetController.text.trim() : null;
        map['chapati'] = isChapati ? chapatiBhakriController.text.trim() : null;
        map['count'] =
            isCount ? chapatiBhakriCountController.text.trim() : null;
        map['rice'] = isRice ? riceController.text.trim() : null;
        map['dal'] = isDal ? dalController.text.trim() : null;
        map['price'] = priceController.text.trim();

        await FirebaseFirestore.instance
            .collection('Menu')
            .doc(MainApp.messName)
            .collection('Lunch')
            .doc('LunchMenu')
            .set(map);
      } else {
        Map<String, dynamic> map = {};
        map['sabji1'] = sabji1Controller.text.trim();
        map['sabji2'] = isSabji2 ? sabji2Controller.text.trim() : null;
        map['sweet'] = isSweet ? sweetController.text.trim() : null;
        map['chapati'] = isChapati ? chapatiBhakriController.text.trim() : null;
        map['count'] =
            isCount ? chapatiBhakriCountController.text.trim() : null;
        map['rice'] = isRice ? riceController.text.trim() : null;
        map['dal'] = isDal ? dalController.text.trim() : null;
        map['price'] = priceController.text.trim();

        await FirebaseFirestore.instance
            .collection('Menu')
            .doc(MainApp.messName)
            .collection('Dinner')
            .doc('DinnerMenu')
            .set(map);
      }
      sabji1Controller.clear();
      sabji2Controller.clear();
      sweetController.clear();
      chapatiBhakriController.clear();
      chapatiBhakriCountController.clear();
      riceController.clear();
      dalController.clear();
      priceController.clear();
    }
    setState(() {});
    Navigator.of(context).pop();
  }

  Future bottomSheetThali({
    bool isEdit = false,
  }) {
    sabji1Controller.clear();
    sabji2Controller.clear();
    sweetController.clear();
    chapatiBhakriController.clear();
    chapatiBhakriCountController.clear();
    riceController.clear();
    dalController.clear();
    priceController.clear();
    if (isEdit) {
      editLunch();
    }
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(MainApp.widthCal(8)),
                      child: Text(
                        "Add Thali Menu Here",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: MainApp.widthCal(20),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MainApp.heightCal(10),
                          left: MainApp.widthCal(20)),
                      child: Row(
                        children: [
                          Text(
                            "Sabji One Name",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: MainApp.widthCal(16),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MainApp.heightCal(5),
                          left: MainApp.widthCal(20),
                          right: MainApp.widthCal(20)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: sabji1Controller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(MainApp.widthCal(15)),
                            borderSide: const BorderSide(
                              color: Colors.orange,
                            ),
                          )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MainApp.heightCal(10),
                          left: MainApp.widthCal(20)),
                      child: Row(
                        children: [
                          Text(
                            "Sabji Two Name",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: MainApp.widthCal(16),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MainApp.heightCal(5),
                          left: MainApp.widthCal(20),
                          right: MainApp.widthCal(20)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: sabji2Controller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(MainApp.widthCal(15)),
                            borderSide: const BorderSide(
                              color: Colors.orange,
                            ),
                          )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MainApp.heightCal(10),
                          left: MainApp.widthCal(20)),
                      child: Row(
                        children: [
                          Text(
                            "Sweet Name",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: MainApp.widthCal(16),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MainApp.heightCal(5),
                          left: MainApp.widthCal(20),
                          right: MainApp.widthCal(20)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: sweetController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(MainApp.widthCal(15)),
                            borderSide: const BorderSide(
                              color: Colors.orange,
                            ),
                          )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MainApp.heightCal(10),
                          left: MainApp.widthCal(20)),
                      child: Row(
                        children: [
                          Text(
                            "Chapati/Bhakri",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: MainApp.widthCal(16),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MainApp.heightCal(5),
                          left: MainApp.widthCal(20),
                          right: MainApp.widthCal(20)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: chapatiBhakriController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(MainApp.widthCal(15)),
                            borderSide: const BorderSide(
                              color: Colors.orange,
                            ),
                          )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MainApp.heightCal(15),
                          left: MainApp.widthCal(20)),
                      child: Row(
                        children: [
                          Text(
                            "Chapati/Bhakari Count",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: MainApp.widthCal(16),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MainApp.heightCal(5),
                          left: MainApp.widthCal(20),
                          right: MainApp.widthCal(20)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: chapatiBhakriCountController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(MainApp.widthCal(15)),
                            borderSide: const BorderSide(
                              color: Colors.orange,
                            ),
                          )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MainApp.heightCal(10),
                          left: MainApp.widthCal(20)),
                      child: Row(
                        children: [
                          Text(
                            "Rice",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: MainApp.widthCal(16),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MainApp.heightCal(5),
                          left: MainApp.widthCal(20),
                          right: MainApp.widthCal(20)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: riceController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(MainApp.widthCal(15)),
                            borderSide: const BorderSide(
                              color: Colors.orange,
                            ),
                          )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MainApp.heightCal(10),
                          left: MainApp.widthCal(20)),
                      child: Row(
                        children: [
                          Text(
                            "Dal",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: MainApp.widthCal(16),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MainApp.heightCal(5),
                          left: MainApp.widthCal(20),
                          right: MainApp.widthCal(20)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: dalController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(MainApp.widthCal(15)),
                            borderSide: const BorderSide(
                              color: Colors.orange,
                            ),
                          )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MainApp.heightCal(15),
                          left: MainApp.widthCal(20)),
                      child: Row(
                        children: [
                          Text(
                            "Price",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: MainApp.widthCal(16),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MainApp.heightCal(5),
                          left: MainApp.widthCal(20),
                          right: MainApp.widthCal(20)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: priceController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(MainApp.widthCal(15)),
                            borderSide: const BorderSide(
                              color: Colors.orange,
                            ),
                          )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(MainApp.widthCal(40)),
                      child: GestureDetector(
                        onTap: () {
                          submit(isedit: isEdit);
                          if (widget.isLunchSelected) {
                            lunchListGetter();
                          } else {
                            dinnerListGetter();
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(MainApp.widthCal(20)),
                              color: Colors.orange),
                          child: Padding(
                            padding: EdgeInsets.all(MainApp.widthCal(15)),
                            child: Center(
                              child: Text(
                                "Submit",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: MainApp.widthCal(16),
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
            ),
          );
        });
  }
}
