import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messify/pages/ParticularMessScreen.dart';
import 'package:animate_do/animate_do.dart'; // Import animation package
import 'package:lottie/lottie.dart';
import 'package:messify/pages/sessionData.dart';

class Favouritemess extends StatefulWidget {
  const Favouritemess({super.key});

  @override
  State<Favouritemess> createState() => _FavouritemessState();
}

class _FavouritemessState extends State<Favouritemess> {
  final List<String> favouriteMessList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getfavouritemess();
  }

  Future<void> getfavouritemess() async {
    try {
      QuerySnapshot response = await FirebaseFirestore.instance
          .collection("FavouriteMess")
          .doc(Sessiondata.usernameget)
          .collection('FavouriteMess')
          .get();

      for (int i = 0; i < response.docs.length; i++) {
        Map<String, dynamic> map =
            response.docs[i].data() as Map<String, dynamic>;
        favouriteMessList.add(map['username']);
      }
      setState(() {});
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favourite Mess",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color.fromRGBO(255, 121, 46, 1),
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
          : favouriteMessList.isEmpty
              ? Center(
                  child: Text(
                    "No Favourite Mess uploaded",
                    style: TextStyle(fontSize: 18.sp, color: Colors.black),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: favouriteMessList.length,
                  itemBuilder: (context, index) {
                    // Staggered delay animation for each card
                    return SlideInRight(
                      duration: const Duration(milliseconds: 500),
                      delay: Duration(
                          milliseconds: index * 100), // Staggered delay
                      child: FadeIn(
                        duration: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Particularmessscreen(
                                    username: favouriteMessList[index]);
                              }));
                            },
                            child: Container(
                              height: 125,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 223, 220, 220),
                                borderRadius: BorderRadius.circular(15.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10.r,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 100.h,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color.fromRGBO(
                                            233, 243, 249, 1),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 10.r,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        child: Image.asset(
                                          "assets/thali.jpeg", // Replace with the correct image
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15.w),
                                  Padding(
                                    padding: EdgeInsets.only(top: 15.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.restaurant,
                                              color: Colors.green,
                                            ),
                                            SizedBox(width: 5.w),
                                            Text(
                                              favouriteMessList[index],
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
                                          "Popular Dishes: DRY GOBI | RAJMA",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        SizedBox(height: 7.h),
                                        Text(
                                          "Location: Pune",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        SizedBox(height: 7.h),
                                        Text(
                                          "1.3 km",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14.sp,
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
