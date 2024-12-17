import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:messify/pages/ParticularMessScreen.dart';
import 'package:animate_do/animate_do.dart'; // Import animation package

class Tiffinmess extends StatefulWidget {
  const Tiffinmess({super.key});

  @override
  State<Tiffinmess> createState() => _TiffinmessState();
}

class _TiffinmessState extends State<Tiffinmess> {
  final List<String> tiffinmess = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    gettiffinmess();
  }

  Future<void> gettiffinmess() async {
    try {
      QuerySnapshot response =
          await FirebaseFirestore.instance.collection("Messinfo").get();

      for (var doc in response.docs) {
        if (doc['tiffinType'] == true) {
          tiffinmess.add(doc['username']);
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
          "Tiffin Mess - Home Delivery",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
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
          : tiffinmess.isEmpty
              ? const Center(
                  child: Text("No Tiffin Mess Available"),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: tiffinmess.length,
                  itemBuilder: (context, index) {
                    // Staggered delay animation for each card
                    return SlideInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: Duration(milliseconds: index * 100), // Staggered delay
                      child: FadeIn(
                        duration: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Particularmessscreen(
                                    username: tiffinmess[index]);
                              }));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color.fromARGB(255, 233, 243, 249),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 6,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 2),
                                          borderRadius: BorderRadius.circular(15),
                                          color: const Color.fromRGBO(
                                              233, 243, 249, 100),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: Image.asset(
                                            "assets/thali.jpeg", // Replace with correct image
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.delivery_dining,
                                                  color: Colors.orange,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  tiffinmess[index],
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
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 7),
                                            Text(
                                              "Delivery: Available 7 AM - 9 PM",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.green[600],
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 7),
                                            Text(
                                              "Free Delivery on Orders over ₹500",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blue[600],
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 7),
                                            Text(
                                              "Pune",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[600],
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 7),
                                            Text(
                                              "1.3 km",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[600],
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
