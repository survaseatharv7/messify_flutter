import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: Lottie.asset(
                'assets/foodloader.json',
                height: 400.h,
                width: 400.w,
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
                      delay: Duration(
                          milliseconds: index * 100), // Staggered delay
                      child: FadeIn(
                        duration: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: EdgeInsets.all(10.r),
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
                                height: 180.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  color:
                                      const Color.fromARGB(255, 233, 243, 249),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 6.r,
                                      spreadRadius: 2.r,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        height: 100.h,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 2.w),
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          color: const Color.fromRGBO(
                                              233, 243, 249, 100),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          child: Image.asset(
                                            "assets/thali.jpeg", // Replace with correct image
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 15.h),
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
                                                SizedBox(width: 5.w),
                                                Text(
                                                  tiffinmess[index],
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 7.h),
                                            Text(
                                              "Popular Dishes: CHICKEN MASALA",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[600],
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 7.h),
                                            Text(
                                              "Delivery: Available 7 AM - 9 PM",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.green[600],
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 7.h),
                                            Text(
                                              "Free Delivery on Orders over ₹500",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blue[600],
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 7.h),
                                            Text(
                                              "Pune",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[600],
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 7.h),
                                            Text(
                                              "1.3 km",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14.sp,
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
