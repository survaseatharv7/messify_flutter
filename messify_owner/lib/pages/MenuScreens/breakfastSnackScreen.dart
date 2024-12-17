import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messify_owner/main.dart';
import 'package:messify_owner/models/breakfastModel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Breakfastmenu extends StatefulWidget {
  Breakfastmenu({super.key, required this.isSnackSelected});
  bool isSnackSelected;

  @override
  State<Breakfastmenu> createState() => _BreakfastmenuState();
}

class _BreakfastmenuState extends State<Breakfastmenu> {
  List snackList = [];
  List nonvegList = [];

  void snackListGetter() async {
    QuerySnapshot response = await FirebaseFirestore.instance
        .collection('Menu')
        .doc('${MainApp.messName}')
        .collection('Snack')
        .get();
    snackList.clear();
    for (int i = 0; i < response.docs.length; i++) {
      DocumentSnapshot documentSnapshot = response.docs[i];
      Map map = {};
      map['item'] = documentSnapshot['item'];
      map['price'] = documentSnapshot['price'];
      /* map['item'] = response.docs[i].['item'];
      map['price'] = response.docs[i].get('price');*/
      snackList.add(map);
      setState(() {});
    }
  }

  void itemRemover(int index) async {
    await FirebaseFirestore.instance
        .collection('Menu')
        .doc("${MainApp.messName}")
        .collection(widget.isSnackSelected ? 'Snack' : 'NonVeg')
        .doc(widget.isSnackSelected
            ? '${snackList[index]['item']}'
            : "${nonvegList[index]['item']}")
        .delete();
    snackListGetter();
    nonvegListGetter();
  }

  void nonvegListGetter() async {
    QuerySnapshot response = await FirebaseFirestore.instance
        .collection('Menu')
        .doc('${MainApp.messName}')
        .collection('NonVeg')
        .get();
    nonvegList.clear();
    for (int i = 0; i < response.docs.length; i++) {
      DocumentSnapshot documentSnapshot = response.docs[i];
      Map map = {};
      map['item'] = documentSnapshot['item'];
      map['price'] = documentSnapshot['price'];
      /*map['item'] = response.docs[i].get('item');
      map['price'] = response.docs[i].get('price');*/
      nonvegList.add(map);
      setState(() {});
    }
  }

  TextEditingController itemController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  // bool isedit=false;
  String displayPrice = '';
  bool isEdit = false;
  int buildContextCounter = 0;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.isSnackSelected) {
      snackListGetter();
    } else {
      nonvegListGetter();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              child: const Icon(Icons.arrow_back_ios),
            ),
          ),
          title: Text(
            widget.isSnackSelected
                ? "Add or Edit Snacks"
                : "Add or Edit Non-Veg Menus",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount:
                widget.isSnackSelected ? snackList.length : nonvegList.length,
            itemBuilder: (context, index) {
              return Slidable(
                endActionPane: ActionPane(
                  motion: BehindMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) async {
                        if (widget.isSnackSelected) {
                          itemRemover(index);
                          snackListGetter();
                        } else {
                          itemRemover(index);
                          nonvegListGetter();
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
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            widget.isSnackSelected
                                ? "${index + 1}. ${snackList[index]['item']}"
                                : "${index + 1}.${nonvegList[index]['item']}",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            widget.isSnackSelected
                                ? "₹${snackList[index]['price']}"
                                : "${nonvegList[index]['price']}",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: const Icon(
            Icons.add,
            size: 50,
            color: Colors.white,
          ),
          onPressed: () {
            bottomSheet();
          },
        ),
      ),
    );
  }

  Widget template(int index, String) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.orange,
        child: Row(
          children: [
            Text(
              "",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Text(
              "",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  void submit({bool isedit = false}) async {
    if (!isedit) {
      if (itemController.text.isNotEmpty &&
          priceController.text.trim().isNotEmpty) {
        if (widget.isSnackSelected) {
          Map<String, dynamic> map = {};
          map['item'] = itemController.text.trim();
          map['price'] = priceController.text.trim();

          await FirebaseFirestore.instance
              .collection('Menu')
              .doc(MainApp.messName)
              .collection('Snack')
              .doc('${itemController.text.trim()}')
              .set(map);

          /*snackList.add(breakFastModel(
              item: itemController.text.trim(),
              price: double.tryParse(priceController.text.trim()) ?? 0.0));*/
          itemController.clear();
          priceController.clear();
        } else {
          Map<String, dynamic> map = {};
          map['item'] = itemController.text.trim();
          map['price'] = priceController.text.trim();

          await FirebaseFirestore.instance
              .collection('Menu')
              .doc(MainApp.messName)
              .collection('NonVeg')
              .doc('${itemController.text.trim()}')
              .set(map);
          itemController.clear();
          priceController.clear();
        }
      }
    } else {
      if (itemController.text.trim().isNotEmpty &&
          priceController.text.trim().isNotEmpty) {}
    }
    setState(() {});
    Navigator.of(context).pop();
  }

  Future bottomSheet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
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
                      "Add New Menu Here",
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
                          "Item Name",
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
                        controller: itemController,
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
                    padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
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
                        if (!isEdit)
                          submit(isedit: false);
                        else
                          submit(isedit: true);
                        count++;

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
          );
        });
  }
}
