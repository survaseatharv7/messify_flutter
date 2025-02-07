import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:messify/main.dart';
import 'package:messify/pages/pollpage.dart';
import 'package:messify/pages/qrshow.dart';
import 'package:messify/pages/sessionData.dart';

class Particularmessscreen extends StatefulWidget {
  final String username;

  const Particularmessscreen({super.key, required this.username});

  @override
  State<Particularmessscreen> createState() => _ParticularmessscreenState();
}

class _ParticularmessscreenState extends State<Particularmessscreen> {
  int date = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;
  bool isPoll = false;
  Map profiledatascreen = {};
  String phonenumber = "";

  @override
  void initState() {
    super.initState();
    initialzeData();
  }

  void initialzeData() async {
    await getmessinfo();
    await fetchPoll();
  }

  Future<void> getmessinfo() async {
    DocumentSnapshot response = await FirebaseFirestore.instance
        .collection('Messinfo')
        .doc(widget.username)
        .get();

    phonenumber = response['Phonenumber'];
    print("hii" + phonenumber);
  }

  Future<void> fetchPoll() async {
    QuerySnapshot response = await FirebaseFirestore.instance
        .collection('Poll')
        .doc(widget.username)
        .collection('PollData')
        .get();
    for (int i = 0; i < response.docs.length; i++) {
      if ('$year-$month-$date' == response.docs[i].id) {
        print(response.docs[i].id);
        isPoll = true;
        setState(() {});
        break;
      }
    }
  }

  String selectedMenu = 'Snack';
  int count = 0;
  String buttonText = "Notify Owner";
  TextEditingController reviewController = TextEditingController();
  List<Map<String, dynamic>> menulist = [];
  String formattedDate = DateFormat('yyyy-MM-dd ').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    print(MainApp.nameMapName);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.username,
          style: GoogleFonts.poppins(
            color: const Color.fromARGB(255, 223, 202, 6),
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return HomePage(username: widget.username);
                }));
              },
              child: Icon(
                Icons.qr_code_scanner_outlined,
                size: 30.sp,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.username,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: 30.w,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (buttonText == "Notify Owner") {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            backgroundColor: Colors.orange.shade100,
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Lottie.asset(
                                    'assets/notification.json',
                                    height: 300.h,
                                    width: 300.w,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "Thank you for notifying",
                                  style: TextStyle(
                                    fontSize: 23.sp,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            actions: [
                              Center(
                                child: GestureDetector(
                                  onTap: () async {
                                    count++;
                                    print("Incremented Count: $count");

                                    Map<String, dynamic> notify = {
                                      "count": count,
                                    };

                                    try {
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(DateTime.now());
                                      await FirebaseFirestore.instance
                                          .collection("Notify")
                                          .doc(widget.username)
                                          .collection(formattedDate)
                                          .doc(Sessiondata.usernameget)
                                          .set(notify);

                                      print("Document added successfully");
                                    } catch (e) {
                                      print("Error adding document: $e");
                                    }

                                    Navigator.of(context).pop();
                                    setState(() {
                                      buttonText = "Cancel";
                                    });
                                  },
                                  child: Container(
                                    height: 40.h,
                                    width: 150.w,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 245, 136, 3),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "OK",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (buttonText == "Cancel") {
                        try {
                          count--;
                          print("Decremented Count: $count");

                          // Get the formatted date
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(DateTime.now());
                          print(
                              "Deleting document for user: ${Sessiondata.usernameget}");

                          // Reference to the document
                          DocumentReference docRef = FirebaseFirestore.instance
                              .collection("Notify")
                              .doc(widget.username)
                              .collection(formattedDate)
                              .doc(Sessiondata.usernameget);

                          // Check if the document exists before deleting
                          DocumentSnapshot docSnapshot = await docRef.get();
                          if (docSnapshot.exists) {
                            await docRef.delete(); // Delete the document
                            print("Document deleted successfully");
                          } else {
                            print(
                                "Document does not exist, nothing to delete.");
                          }

                          // Update the button text
                          setState(() {
                            buttonText = "Notify Owner";
                          });
                        } catch (e, stackTrace) {
                          print("Error deleting document: $e");
                          print("Stack Trace: $stackTrace");
                        }
                      }
                    },
                    child: Container(
                      height: 40.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 245, 136, 3),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        buttonText,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Icon(
                    Icons.restaurant_menu,
                    color: Color.fromARGB(255, 223, 202, 6),
                    size: 22.sp,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "Non Veg",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Text(
                "1.3 km",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15.h),
              Container(
                height: 250.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/mess1.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildMenuButton("Snacks Menu", 'Snack'),
                    SizedBox(width: 10.w),
                    _buildMenuButton("Lunch Menu", 'Lunch'),
                    SizedBox(width: 10.w),
                    _buildMenuButton("Dinner Menu", 'Dinner'),
                    SizedBox(width: 10.w),
                    _buildMenuButton("Nonveg Menu", 'NonVeg'),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: menulist.isNotEmpty
                    ? menulist.map((item) {
                        if (selectedMenu == 'Snack' ||
                            selectedMenu == 'NonVeg') {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.w),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 18.sp,
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Text(
                                    "${item['Snack']} - ₹${item['price']}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (selectedMenu == 'Lunch' ||
                            selectedMenu == 'Dinner') {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 18.sp,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "Sabji 1 - ${item['sabji1']}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 18.sp,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      "Sabji 2 - ${item['sabji2']}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 18.sp,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      "Dal - ${item['dal']}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "Chapati - ${item['chapati']}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 18.sp,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      "Rice - ${item['rice']}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 18.sp,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      "Sweet - ₹${item['sweet']}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: Color.fromRGBO(76, 175, 80, 1),
                                      size: 18.sp,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "Price - ₹${item['price']}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                        return const SizedBox();
                      }).toList()
                    : [
                        Text(
                          'Menu not Updated Yet',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
              ),
              SizedBox(height: 7.h),
              _buildDetailsSection(
                  "Address", "Matrix Parking near SCOE behind new bus stand."),
              _buildDetailsSection("Morning Time", "7.00 AM TO 11.00 AM"),
              _buildDetailsSection("Evening Time", "7.00 PM TO 11.00 PM"),
              _buildDetailsSection("Contact Number", phonenumber),
              SizedBox(height: 10.h),
              if (isPoll) CustomPollPage(messName: widget.username),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 30.h, right: 15.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => reviewBottomSheet(),
              child: Container(
                height: 36.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  color: Colors.orange,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 6.w),
                        child: Icon(
                          Icons.edit,
                          size: 20.sp,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Write a review",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future reviewBottomSheet() {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        int selectedStarIndex = -1;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(25.r),
                ),
                color: Color.fromRGBO(249, 249, 249, 1),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 15.w,
                  right: 15.r,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Container(
                        height: 6.h,
                        width: 60.w,
                        color: const Color.fromRGBO(155, 155, 155, 1),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Text(
                        "What is your rate?",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return GestureDetector(
                            onTap: () {
                              selectedStarIndex = index;
                              setModalState(() {});
                            },
                            child: Icon(
                              selectedStarIndex >= index
                                  ? Icons.star
                                  : Icons.star_border_outlined,
                              color: const Color.fromARGB(255, 195, 175, 0),
                            ),
                          );
                        }),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Text(
                        "Please share your opinion",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Container(
                        color: Colors.white,
                        height: 150.h,
                        child: TextField(
                          controller: reviewController,
                          maxLines: null,
                          expands: true,
                          decoration: const InputDecoration(
                            hintText: "Your Review",
                            border: OutlineInputBorder(),
                            alignLabelWithHint: true,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.w),
                      child: GestureDetector(
                        onTap: () async {
                          if (selectedStarIndex >= 0 &&
                              reviewController.text.isNotEmpty) {
                            int date = DateTime.now().day;
                            int month = DateTime.now().month;
                            int year = DateTime.now().year;
                            String todayDate = " $year/$month/$date";
                            bool oldUser = false;

                            Map<String, dynamic> map = {};
                            map['starIndex'] = selectedStarIndex;
                            map['review'] = reviewController.text.trim();
                            map['date'] = todayDate;
                            map['Name'] = Sessiondata.usernameget;

                            QuerySnapshot _querySnapshot =
                                await FirebaseFirestore.instance
                                    .collection('Feedback')
                                    .doc(widget.username)
                                    .collection('UsersFeedback')
                                    .get();

                            for (int i = 0;
                                i < _querySnapshot.docs.length;
                                i++) {
                              if (_querySnapshot.docs[i]['Name'] ==
                                  Sessiondata.usernameget) {
                                oldUser = true;
                                break;
                              }
                            }
                            if (!oldUser) {
                              await FirebaseFirestore.instance
                                  .collection('Feedback')
                                  .doc(widget.username)
                                  .collection('UsersFeedback')
                                  .doc(Sessiondata.usernameget)
                                  .set(map);

                              DocumentSnapshot _docSnap =
                                  await FirebaseFirestore.instance
                                      .collection('Messinfo')
                                      .doc(widget.username)
                                      .get();

                              Map<String, dynamic> messMap =
                                  _docSnap.data() as Map<String, dynamic>;
                              messMap['totalRating'] += selectedStarIndex + 1;
                              messMap['noOfRaters']++;

                              await FirebaseFirestore.instance
                                  .collection('Messinfo')
                                  .doc(widget.username)
                                  .set(messMap);
                            }

                            reviewController.clear();
                            Navigator.of(context).pop();
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: Colors.orange,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15.w),
                            child: Center(
                              child: Text(
                                "SEND REVIEW",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  ElevatedButton _buildMenuButton(String text, String menuType) {
    return ElevatedButton(
      onPressed: () {
        getmenu(menuType);
        setState(() {
          selectedMenu = menuType;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 223, 202, 6),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Future<void> getmenu(String menuType) async {
    menulist.clear();
    try {
      QuerySnapshot response = await FirebaseFirestore.instance
          .collection("Menu")
          .doc(widget.username)
          .collection(menuType)
          .get();
      setState(() {
        for (var doc in response.docs) {
          if (menuType == "Snack" || menuType == "NonVeg") {
            menulist.add({
              'Snack': doc['item'],
              'price': doc['price'],
            });
          } else if (menuType == "Lunch" || menuType == "Dinner") {
            menulist.add({
              'sabji1': doc['sabji1'],
              'sabji2': doc['sabji2'],
              'dal': doc['dal'],
              'chapati': doc['chapati'],
              'price': doc['price'],
              'rice': doc['rice'],
              'sweet': doc['sweet'],
            });
            print(menulist);
          }
        }
      });
    } catch (e) {
      print("Error fetching menu: $e");
    }
  }

  Widget _buildDetailsSection(String title, String content) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 7.h),
          Text(content),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
