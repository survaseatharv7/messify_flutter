import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:messify_owner/main.dart';
import 'package:messify_owner/pages/QRScreen/generateQR.dart';
import 'package:messify_owner/pages/SubscriptionScreens/Subcription.dart';
import 'package:messify_owner/pages/MenuScreens/addMenuScreen.dart';
import 'package:messify_owner/pages/ProfileScreens/profile.dart';

class Maindashboard extends StatefulWidget {
  const Maindashboard({super.key});

  @override
  State<Maindashboard> createState() => _MaindashboardState();
}

class _MaindashboardState extends State<Maindashboard> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const OwnerUI(),
    const Subcription(),
    const Messify(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 121, 46, 1),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hotel),
            label: 'Add Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions_outlined),
            label: 'Subcription',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

// Dashboard page content
class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Map<String, dynamic>> listOfReviews = [];
  int date = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;
  Map<String, dynamic> pollDetails = {};
  List options = [];
  List optionList = [];
  bool isPoll = false;
  bool isFeedback = false;
  bool isInterested = false;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    // initializeData();
  }

  // void initializeData() async {
  //   await feedback();
  // }

  Stream<int> getInterestedUserCountStream() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    return FirebaseFirestore.instance
        .collection("Notify")
        .doc(MainApp.messName)
        .collection(formattedDate)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  // Future<void> feedback() async {
  //   QuerySnapshot response =
  //       await FirebaseFirestore.instance.collection("Feedback").get();

  //   bool isFeedback = false;

  //   for (int i = 0; i < response.docs.length; i++) {
  //     if (response.docs[i].id == MainApp.messName) {
  //       isFeedback = true;
  //       this.isFeedback = true;
  //     }
  //   }
  // }

  Stream<List<Map<String, dynamic>>>? listOfReviewStream() {
    return FirebaseFirestore.instance
        .collection('Feedback')
        .doc(MainApp.messName)
        .collection('UsersFeedback')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'Name': doc['Name'],
          'date': doc['date'],
          'review': doc['review'],
          'starIndex': doc['starIndex'] + 1,
        };
      }).toList();
    });
  }

  Future<void> pollDataGetter() async {
    DocumentSnapshot _docSnap = await FirebaseFirestore.instance
        .collection('Poll')
        .doc(MainApp.messName)
        .collection('PollData')
        .doc('$year-$month-$date')
        .get();

    if (_docSnap.exists) {
      pollDetails = _docSnap.data() as Map<String, dynamic>;

      if (pollDetails.containsKey('options')) {
        options = pollDetails['options']; // Extract the options array

        // Iterate and print titles and votes
        for (int i = 0; i < pollDetails['options'].length; i++) {
          String title =
              pollDetails['options'][i]['title'] ?? 'No title available';
          int votes = pollDetails['options'][i]['votes'] ?? 0;
          optionList.add({'title ': title, 'votes': votes});
        }
        isPoll = true;
      }
    }
    setState(() {});
    print(pollDetails);
    print(options);
  }

  Future<void> listOfReviewsListGetter() async {
    QuerySnapshot response = await FirebaseFirestore.instance
        .collection('Feedback')
        .doc(MainApp.messName)
        .collection('UsersFeedback')
        .get();
    listOfReviews.clear();

    for (int i = 0; i < response.docs.length; i++) {
      DocumentSnapshot docSnap = response.docs[i];
      Map<String, dynamic> map = {};
      map['Name'] = docSnap['Name'];
      map['date'] = docSnap['date'];
      map['review'] = docSnap['review'];
      map['starIndex'] = docSnap['starIndex'] + 1;
      listOfReviews.add(map);
    }
    setState(() {});
  }

  Widget interestedUserCountCard() {
    return StreamBuilder(
        stream: getInterestedUserCountStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error : ${snapshot.error}"),
            );
          }
          return Text(
            "Interested Users: ${snapshot.data ?? 0}",
            style: TextStyle(
                fontSize: MainApp.widthCal(20), fontWeight: FontWeight.bold),
          );
        });
  }

  Widget feedbackCard() {
    return StreamBuilder<List<Map<String, dynamic>>>(
        stream: listOfReviewStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error : ${snapshot.error}"),
            );
          }
          if (!snapshot.hasData) {
            return Center(child: Text("No Feedbacks Found"));
          }
          final feedbackList = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: feedbackList.length,
            itemBuilder: (context, index) {
              dynamic review = feedbackList[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: MainApp.heightCal(8)),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      MainApp.widthCal(10),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 6.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(
                    MainApp.widthCal(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${review['Name']}",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: MainApp.widthCal(18),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: MainApp.heightCal(8)),
                      Row(
                        children: List.generate(5, (starIndex) {
                          return Icon(
                            starIndex < review['starIndex']
                                ? Icons.star
                                : Icons.star_border_outlined,
                            color: const Color.fromARGB(255, 195, 175, 0),
                          );
                        }),
                      ),
                      SizedBox(height: MainApp.heightCal(10)),
                      Text(
                        review['review'],
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: MainApp.widthCal(16),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: MainApp.heightCal(10)),
                      Text(
                        "Posted on: ${review['date']}",
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: MainApp.widthCal(14),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedTabIndex == 0) {
      isInterested = true;
      isFeedback = false;
    } else {
      isInterested = false;
      isFeedback = true;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MainApp.heightCal(50),
          ),
          Row(
            children: [
              SizedBox(
                width: MainApp.widthCal(10),
              ),
              Text(
                "${MainApp.messName}",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: MainApp.widthCal(30),
                    fontWeight: FontWeight.w700),
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GenerateQRCodePage()));
                  },
                  icon: const Icon(
                    Icons.qr_code_scanner,
                    color: Colors.white,
                  ))
            ],
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(
                MainApp.widthCal(8),
              ),
              child: Container(
                height: MainApp.heightCal(250),
                width: MainApp.widthCal(500),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    MainApp.widthCal(20),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    MainApp.widthCal(20),
                  ),
                  child: Image.asset(
                    "assets/mess1.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MainApp.heightCal(15),
          ),
          SizedBox(
            height: MainApp.heightCal(15),
          ),
          Container(
            height: MainApp.heightCal(800),
            width: MainApp.widthCal(500),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                      offset: Offset(0, -2))
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(
                  MainApp.widthCal(15),
                ))),
            child: Padding(
              padding: EdgeInsets.all(
                MainApp.widthCal(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // if (isPoll)
                  //   StreamBuilder(
                  //       stream: FirebaseFirestore.instance
                  //           .collection('Poll')
                  //           .doc(MainApp.messName)
                  //           .collection('PollData')
                  //           .doc('$year-$month-$date')
                  //           .snapshots(),
                  //       builder: (context, snapshot) {
                  //         if (snapshot.connectionState ==
                  //             ConnectionState.waiting) {
                  //           return Center(
                  //             child: CircularProgressIndicator(),
                  //           );
                  //         }
                  //         if (snapshot.hasError) {
                  //           return Center(
                  //             child: Text("Error : ${snapshot.error}"),
                  //           );
                  //         }
                  //         return Column(
                  //           children: [
                  //             Text(
                  //               "Poll Results for ${pollDetails['question']}",
                  //               style: GoogleFonts.poppins(
                  //                 fontSize: MainApp.widthCal(20),
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.black87,
                  //               ),
                  //             ),
                  //             SizedBox(height: MainApp.heightCal(20)),
                  //             SizedBox(
                  //               height: MainApp.heightCal(200),
                  //               child: BarChart(
                  //                 BarChartData(
                  //                   alignment: BarChartAlignment.spaceAround,
                  //                   maxY: MainApp.heightCal(20),
                  //                   barGroups: [
                  //                     BarChartGroupData(
                  //                       x: 0,
                  //                       barRods: [
                  //                         BarChartRodData(
                  //                           toY: (options[0]['votes'] as num)
                  //                               .toDouble(),
                  //                           color: Colors.orange,
                  //                           width: MainApp.widthCal(20),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                     BarChartGroupData(
                  //                       x: 1,
                  //                       barRods: [
                  //                         BarChartRodData(
                  //                           toY: (options[1]['votes'] as num)
                  //                               .toDouble(),
                  //                           color: Colors.blue,
                  //                           width: MainApp.widthCal(20),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                     BarChartGroupData(
                  //                       x: 2,
                  //                       barRods: [
                  //                         BarChartRodData(
                  //                           toY: (options[2]['votes'] as num)
                  //                               .toDouble(),
                  //                           color: Colors.green,
                  //                           width: MainApp.widthCal(20),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ],
                  //                   titlesData: FlTitlesData(
                  //                     leftTitles: const AxisTitles(
                  //                       sideTitles:
                  //                           SideTitles(showTitles: false),
                  //                     ),
                  //                     bottomTitles: AxisTitles(
                  //                       sideTitles: SideTitles(
                  //                         showTitles: true,
                  //                         getTitlesWidget:
                  //                             (double value, TitleMeta meta) {
                  //                           switch (value.toInt()) {
                  //                             case 0:
                  //                               return Text(
                  //                                   '${options[0]['title']}');
                  //                             case 1:
                  //                               return Text(
                  //                                   '${options[1]['title']}');
                  //                             case 2:
                  //                               return Text(
                  //                                   '${options[2]['title']}');
                  //                             default:
                  //                               return const Text('Bhendi Fry');
                  //                           }
                  //                         },
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   borderData: FlBorderData(show: false),
                  //                   barTouchData: BarTouchData(enabled: true),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         );
                  //       }),
                  // SizedBox(
                  //   height: MainApp.heightCal(20),
                  // ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isInterested = true;
                              isFeedback = false;
                              _selectedTabIndex = 0;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: _selectedTabIndex == 0
                                ? MainApp.heightCal(60)
                                : MainApp.heightCal(
                                    50), // Increase height when selected
                            width: _selectedTabIndex == 0
                                ? MainApp.widthCal(160)
                                : MainApp.widthCal(
                                    160), // Increase width when selected
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(MainApp.widthCal(25)),
                              gradient: LinearGradient(
                                colors: _selectedTabIndex == 0
                                    ? [
                                        Color.fromRGBO(255, 121, 46, 1),
                                        Color.fromRGBO(255, 181, 100, 1)
                                      ]
                                    : [
                                        Colors.grey.shade300,
                                        Colors.grey.shade400
                                      ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Today's Attendees",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: MainApp.widthCal(10)),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isInterested = false;
                              isFeedback = true;
                              _selectedTabIndex = 1;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: _selectedTabIndex == 1
                                ? MainApp.heightCal(60)
                                : MainApp.heightCal(
                                    50), // Increase height when selected
                            width: _selectedTabIndex == 1
                                ? MainApp.widthCal(160)
                                : MainApp.widthCal(
                                    160), // Increase width when selected
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(MainApp.widthCal(25)),
                              gradient: LinearGradient(
                                colors: _selectedTabIndex == 1
                                    ? [
                                        Color.fromRGBO(255, 121, 46, 1),
                                        Color.fromRGBO(255, 181, 100, 1)
                                      ]
                                    : [
                                        Colors.grey.shade300,
                                        Colors.grey.shade400
                                      ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Feedbacks",
                                style: GoogleFonts.poppins(
                                  fontSize: MainApp.widthCal(15),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: MainApp.widthCal(10)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MainApp.heightCal(20),
                  ),
                  if (isInterested) interestedUserCountCard(),

                  if (isFeedback) feedbackCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
