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
  TextEditingController price1Controller = TextEditingController();

  TextEditingController breadController = TextEditingController();
  TextEditingController price2Controller = TextEditingController();

  List lunchList = [];
  bool isMain = false;

  List dinnerList = [];

  List listOfImages = [Image.asset("assets/thali.png")];

  TextEditingController sweetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.isLunchSelected) {
      lunchListGetter();
    } else {
      dinnerListGetter();
    }

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
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    "Thali",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      bottomSheetThali();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.orange),
                      child: Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: widget.isLunchSelected
                    ? lunchList.length
                    : dinnerList.length,
                itemBuilder: (context, index) {
                  return Slidable(
                      endActionPane: ActionPane(
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              // Handle delete action
                              setState(() {});
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            //label: 'Delete',
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              // Handle edit action
                              // Add logic for editing if required
                            },
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            // label: 'Edit',
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
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
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.asset(
                                      "assets/thali.png",
                                      fit: BoxFit.cover,
                                    ),
                                    height: 100,
                                    width: 100,
                                  ),
                                  SizedBox(height: MainApp.heightCal(10)),
                                  Text(widget.isLunchSelected
                                      ? "Price : ${lunchList[index]['price']}"
                                      : "Price : ${dinnerList[index]['price']}")
                                ],
                              ),

                              // Content Section
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Item Name
                                      Center(
                                        child: Text(
                                          widget.isLunchSelected
                                              ? "Lunch"
                                              : "Dinner",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),

                                      const Divider(
                                        color: Colors.white54,
                                        thickness: 0.5,
                                        height: 10,
                                      ),

                                      // Sabji 1 and Sabji 2
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              widget.isLunchSelected
                                                  ? "1: ${lunchList[index]['sabji1']}"
                                                  : "1: ${dinnerList[index]['sabji1']}",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              widget.isLunchSelected
                                                  ? "2: ${lunchList[index]['sabji2']}"
                                                  : "2. ${dinnerList[index]['sabji2']}",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 5),

                                      // Sweet and Chapati
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              widget.isLunchSelected
                                                  ? "Sweet: ${lunchList[index]['sweet']}"
                                                  : "Sweet: ${dinnerList[index]['sweet']}",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              widget.isLunchSelected
                                                  ? "${lunchList[index]['chapati']}: ${lunchList[index]['count']}"
                                                  : "${dinnerList[index]['chapati']}: ${dinnerList[index]['count']}",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 5),

                                      // Rice and Dal
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              widget.isLunchSelected
                                                  ? "Rice: ${lunchList[index]['rice']}"
                                                  : "Rice: ${dinnerList[index]['rice']}",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              widget.isLunchSelected
                                                  ? "Dal: ${lunchList[index]['dal']}"
                                                  : "Dal: ${dinnerList[index]['dal']}",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 12,
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
                }),
          ],
        ),
      ),
    );
  }

  dynamic nullChecker(dynamic value) {
    return value ?? "Not updated";
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

  Future bottomSheetThali() {
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
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Add Thali Menu Here",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20),
                      child: Row(
                        children: [
                          Text(
                            "Sabji One Name",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 20, right: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: sabji1Controller,
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
                      padding: const EdgeInsets.only(top: 10, left: 20),
                      child: Row(
                        children: [
                          Text(
                            "Sabji Two Name",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 20, right: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: sabji2Controller,
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
                      padding: const EdgeInsets.only(top: 10, left: 20),
                      child: Row(
                        children: [
                          Text(
                            "Sweet Name",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 20, right: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: sweetController,
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
                      padding: const EdgeInsets.only(top: 10, left: 20),
                      child: Row(
                        children: [
                          Text(
                            "Chapati/Bhakri",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 20, right: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: chapatiBhakriController,
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
                            "Chapati/Bhakari Count",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 20, right: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: chapatiBhakriCountController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
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
                      padding: const EdgeInsets.only(top: 10, left: 20),
                      child: Row(
                        children: [
                          Text(
                            "Rice",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 20, right: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: riceController,
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
                      padding: const EdgeInsets.only(top: 10, left: 20),
                      child: Row(
                        children: [
                          Text(
                            "Dal",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 20, right: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: dalController,
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
                            "Price",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 20, right: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: priceController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
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
                        onTap: () {
                          submit(isedit: false);
                          if (widget.isLunchSelected) {
                            lunchListGetter();
                          } else {
                            dinnerListGetter();
                          }
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
                                "Submit",
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
            ),
          );
        });
  }
}
