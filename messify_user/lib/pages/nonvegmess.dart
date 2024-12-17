import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:messify/main.dart';
import 'package:messify/pages/ParticularMessScreen.dart';
import 'package:animate_do/animate_do.dart'; // Animation package for sliding

class Nonvegmess extends StatefulWidget {
  const Nonvegmess({super.key});

  @override
  State<Nonvegmess> createState() => _NonvegmessState();
}

class _NonvegmessState extends State<Nonvegmess> {
  final List<String> nonvegmess = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getnonvegmess();
  }

  Future<void> getnonvegmess() async {
    try {
      QuerySnapshot response =
          await FirebaseFirestore.instance.collection("Messinfo").get();

      for (var doc in response.docs) {
        if (doc['nonvegType'] == true) {
          nonvegmess.add(doc['username']);
        }
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Non Veg Mess ${MainApp.messsname}",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color.fromRGBO(255, 121, 46, 1),
      ),
      body: isLoading
          ? Center(
              child: Lottie.asset(
                'assets/foodloader.json',
                height: 400,
                width: 400,
                fit: BoxFit.contain,
              ),
            )
          : nonvegmess.isEmpty
              ? const Center(
                  child: Text(
                    "No Non-Veg Mess Available",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: nonvegmess.length,
                  itemBuilder: (context, index) {
                    // Adding a delay to create staggered animation for each item
                    return SlideInRight(
                      duration: Duration(milliseconds: 500),
                      delay: Duration(milliseconds: index * 100), // Staggered delay
                      child: FadeIn(
                        duration: const Duration(milliseconds: 500), // Fade in effect
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Particularmessscreen(
                                    username: nonvegmess[index]);
                              }));
                            },
                            child: Container(
                              height: 125,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 223, 220, 220),
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color.fromRGBO(
                                            233, 243, 249, 1),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 10,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.asset(
                                          "assets/thali.jpeg", // Replace with appropriate image
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.restaurant,
                                              color: Colors.red,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              nonvegmess[index],
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 7),
                                        Text(
                                          "Popular Dishes: CHICKEN MASALA",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        const SizedBox(height: 7),
                                        Text(
                                          "Location: Pune",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        const SizedBox(height: 7),
                                        Text(
                                          "1.3 km",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
