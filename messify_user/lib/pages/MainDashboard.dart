import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:messify/main.dart';
import 'package:messify/pages/Favouritemess.dart';
import 'package:messify/pages/NotificationsScreen.dart';
import 'package:messify/pages/profilepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/mess_model.dart';
import 'ParticularMessScreen.dart';
import 'sessionData.dart';
import 'vegmess.dart';
import 'nonvegmess.dart';
import 'tiffinmess.dart';

class Maindashboard extends StatefulWidget {
  const Maindashboard({super.key});

  @override
  State<Maindashboard> createState() => _MaindashboardState();
}

class _MaindashboardState extends State<Maindashboard> {
  List<MessModel> messList = [];
  List favouriteMessList = [];

  List<MessModel> filteredList = [];
  bool isLoading = true; // Splash screen is visible initially
  bool showMessList = false; // Determines when to show the mess list
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeData();
    _searchController.addListener(() {
      filterSearchResults(_searchController.text.trim());
    });
  }

  // Initialize data fetching
  Future<void> _initializeData() async {
    await Sessiondata.getSessionData();
    await fetchFavouriteMessList();
    await fetchMessList();
  }

  Future<void> fetchFavouriteMessList() async {
    QuerySnapshot response = await FirebaseFirestore.instance
        .collection('FavouriteMess')
        .doc(Sessiondata.usernameget)
        .collection('FavouriteMess')
        .get();

    favouriteMessList.clear();

    for (int i = 0; i < response.docs.length; i++) {
      Map<String, dynamic> map =
          response.docs[i].data() as Map<String, dynamic>;
      favouriteMessList.add(map);
    }
    print("Favourite Mess $favouriteMessList");
  }

  // Fetch mess list from Firestore
  Future<void> fetchMessList() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    QuerySnapshot response =
        await FirebaseFirestore.instance.collection("Messinfo").get();

    for (int i = 0; i < response.docs.length; i++) {
      Map<String, dynamic> map =
          response.docs[i].data() as Map<String, dynamic>;
      bool isFavourite = false;
      int totalRating =
          map['totalRating'] ?? 0; // Default to 0 if not available
      int noOfRaters = map['noOfRaters'] ?? 0; // Default to 0 if not available
      double avgRating = noOfRaters > 0 ? totalRating / noOfRaters : 0.0;

      for (int j = 0; j < favouriteMessList.length; j++) {
        if (favouriteMessList[j]['username'] == map['username']) {
          isFavourite = true;
          break;
        }
      }
      messList.add(MessModel(
          messname: map['username'],
          totalRating: totalRating,
          noOfRaters: noOfRaters,
          avgRating: avgRating,
          isFavourite: isFavourite,
          map: map));
    }

    setState(() {
      filteredList = List.from(messList);
      isLoading = false; // Splash screen disappears here
    });

    // Show the mess list after a delay to simulate loading
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        showMessList = true; // Trigger animation for the mess list
      });
    });
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredList = List.from(messList);
      });
      return;
    }
    setState(() {
      filteredList = messList
          .where((mess) =>
              mess.messname.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 245, 255, 1),
      body: isLoading
          ? Center(
              child: Lottie.asset(
                'assets/login.json',
                height: 400,
                width: 400,
                fit: BoxFit.contain,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Top Section
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Hii,",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    print(MainApp.messsname);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            NotificationsScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            shape: BoxShape.circle),
                                        child: const Icon(
                                          Icons.notification_important_outlined,
                                          size: 25,
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Myapp(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            shape: BoxShape.circle),
                                        child: const Icon(
                                          Icons.person,
                                          size: 25,
                                          color: Colors.white,
                                        )),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "${Sessiondata.usernameget}",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              )
                            ],
                          ),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              hintText: "Search Mess or Menu",
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Categories Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Categories",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            categoryButton(
                                "VEG", Icons.restaurant, const Vegmess()),
                            categoryButton("NON VEG", Icons.restaurant_menu,
                                const Nonvegmess()),
                            categoryButton("Tiffin", Icons.lunch_dining,
                                const Tiffinmess()),
                            categoryButton("Favourite Mess",
                                Icons.favorite_outline, const Favouritemess()),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Mess List
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Top Mess",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Apply animations only after the splash screen
                  AnimatedOpacity(
                    opacity:
                        showMessList ? 1 : 0, // Fade-in effect after Lottie
                    duration: const Duration(milliseconds: 500),
                    child: AnimatedSlide(
                      duration: const Duration(milliseconds: 500),
                      offset: showMessList
                          ? const Offset(0, 0) // Slide effect after Lottie
                          : const Offset(0, 0.1),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          return messCard(filteredList[index]);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget categoryButton(String title, IconData icon, Widget? page) {
    return GestureDetector(
      onTap: () {
        print(filteredList);
        if (page != null) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        }
      },
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromRGBO(255, 121, 46, 0.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Icon(icon,
                size: 30, color: const Color.fromRGBO(255, 121, 46, 1)),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget messCard(MessModel mess) {
    return GestureDetector(
      onTap: () async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("Messname", mess.messname);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => Particularmessscreen(username: mess.messname),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromRGBO(233, 243, 249, 1),
              ),
              child: Image.asset(
                "assets/thali.jpeg",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mess.messname,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "DRY GOBI | RAJMA",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Pune - 1.3 km",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () async {
                      mess.isFavourite = !mess.isFavourite;
                      if (mess.isFavourite) {
                        await FirebaseFirestore.instance
                            .collection('FavouriteMess')
                            .doc(Sessiondata.usernameget)
                            .collection('FavouriteMess')
                            .doc(mess.messname)
                            .set(mess.map);
                      } else {
                        await FirebaseFirestore.instance
                            .collection('FavouriteMess')
                            .doc(Sessiondata.usernameget)
                            .collection('FavouriteMess')
                            .doc(mess.messname)
                            .delete();
                      }
                      setState(() {});
                    },
                    icon: mess.isFavourite
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(Icons.favorite_border_outlined)),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 25,
                      color: Color(0xFFFFD700),
                    ),
                    Text(
                      mess.avgRating.toStringAsFixed(1),
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Color(0xFFFFD700),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
