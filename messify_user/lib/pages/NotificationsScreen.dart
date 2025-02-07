import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<String> messNames = [];
  List<Map<String, dynamic>> notifications = [];
  String formatteddate = "";

  @override
  void initState() {
    super.initState();
    getmessdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: notifications.isEmpty
          ? const Center(
              child: CircularProgressIndicator()) // Loading indicator
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                final messName = notification['messName']; // Retrieve mess name
                final title = notification['Title'] ??
                    'No Title'; // Get notification title
                final description = notification['Description'] ??
                    'No Description'; // Get notification description

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        16.r), // Rounded corners for a smoother look
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.orange.shade400,
                          const Color.fromARGB(255, 208, 127, 5)
                        ], // Gradient background
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(
                          16.r), // Rounded corners for container
                    ),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.all(16.w), // Padding around the content
                      leading: Icon(
                        Icons.notifications_active,
                        color: Colors.white,
                        size: 30.sp, // Icon size
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$messName ($formatteddate)", // Display mess name with formatted date
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future<void> getmessdata() async {
    DateTime now = DateTime.now();
    formatteddate = DateFormat('yyyy-MM-dd').format(now);
    try {
      QuerySnapshot messCollection =
          await FirebaseFirestore.instance.collection("Messinfo").get();

      for (var doc in messCollection.docs) {
        messNames.add(doc['username']);
      }

      List<Map<String, dynamic>> fetchedNotifications = [];

      for (var messName in messNames) {
        QuerySnapshot notificationDataSnapshot = await FirebaseFirestore
            .instance
            .collection('Notification')
            .doc(messName)
            .collection("Noticationdata")
            .get();

        for (var doc in notificationDataSnapshot.docs) {
          fetchedNotifications.add({
            'messName': messName,
            ...doc.data() as Map<String, dynamic>,
          });
        }
      }

      setState(() {
        notifications = fetchedNotifications;
      });

      print("Fetched Notifications: $notifications");
    } catch (e) {
      print("Error fetching notifications: $e");
    }
  }
}
