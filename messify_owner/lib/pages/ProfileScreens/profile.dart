import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:messify_owner/main.dart';
import 'package:messify_owner/pages/CredentialPages/Loginscreen.dart';
import 'package:messify_owner/pages/ProfileScreens/editProfileScreen.dart';
import 'package:messify_owner/pages/CredentialPages/Registrationscreen.dart';
import 'package:messify_owner/pages/SubscriptionScreens/subscribedMembers.dart';

void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Messify(),
    );
  }
}

class Messify extends StatefulWidget {
  const Messify({super.key});

  @override
  State<Messify> createState() => _MessifyState();
}

class _MessifyState extends State<Messify> {
  void showNotificationBottomSheet(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Create Notification",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                onPressed: () {
                  DateTime now = DateTime.now();
                  String formattedDate = DateFormat('yyyy-MM-dd').format(now);
                  String title = titleController.text;
                  String description = descriptionController.text;
                  if (title.isNotEmpty && description.isNotEmpty) {
                    Map<String, dynamic> Notifiydata = {
                      "Title": title,
                      "Description": description,
                      "Messname": MainApp.messName
                    };

                    try {
                      FirebaseFirestore.instance
                          .collection("Notification")
                          .doc(MainApp.messName)
                          .collection("Noticationdata")
                          .doc(formattedDate)
                          .set(Notifiydata);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Icon(
                                Icons.notifications_active,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "Notification \"$title\" submitted successfully!",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    } catch (e) {}
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please fill in all fields")),
                    );
                  }
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return profilePage();
  }

  Widget profilePage() {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showNotificationBottomSheet(context);
        },
        child: const Icon(
          Icons.notification_add_outlined,
          size: 30,
        ),
        backgroundColor: Colors.orange,
      ),
      /*appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 141, 118, 1),
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),*/
      body: Container(
        //color: Colors.white,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
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
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
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
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 122,
                        width: 122,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 5),
                            color: Colors.blue),
                        child: Image.asset(
                          "assets/avtar.jpeg",
                          fit: BoxFit.cover,
                        ),
                        clipBehavior: Clip.antiAlias,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const Myapp1();
                    }));
                  },
                  child: Container(
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black),
                    child: Center(
                        child: Text(
                      "Edit Profile",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        color: Color.fromRGBO(246, 246, 246, 1),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 26),
                          child: Text(
                            "Profile",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Subscribedmembers()));
                  },
                  child: Row(
                    children: [
                      Container(
                        //width: MediaQuery.of(context).size.width,
                        //color: Color.fromRGBO(246, 246, 246, 1),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 26),
                          child: Text(
                            "Subscribed Users",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      //width: MediaQuery.of(context).size.width,
                      //color: Color.fromRGBO(246, 246, 246, 1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 26),
                        child: Text(
                          "About Us",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
              /* Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      //width: MediaQuery.of(context).size.width,
                      //color: Color.fromRGBO(246, 246, 246, 1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 26),
                        child: Text(
                          "About Us",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        color: Color.fromRGBO(246, 246, 246, 1),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 26),
                          child: Text(
                            "Content",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      //width: MediaQuery.of(context).size.width,
                      //color: Color.fromRGBO(246, 246, 246, 1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 26),
                        child: Text(
                          "Downloads",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      //width: MediaQuery.of(context).size.width,
                      //color: Color.fromRGBO(246, 246, 246, 1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 26),
                        child: Text(
                          "Favourite",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        color: Color.fromRGBO(246, 246, 246, 1),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 26),
                          child: Text(
                            "Preferences",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      //width: MediaQuery.of(context).size.width,
                      //color: Color.fromRGBO(246, 246, 246, 1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 26),
                        child: Text(
                          "Language",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      //width: MediaQuery.of(context).size.width,
                      //color: Color.fromRGBO(246, 246, 246, 1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 26),
                        child: Text(
                          "Dark Mode",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              )*/

              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Add your logout functionality here
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Logout Confirmation'),
                          content: Text('Are you sure you want to log out?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                                // Perform logout
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => Loginscreen()),
                                    (route) => false);
                              },
                              child: Text('Logout'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.logout, color: Colors.white),
                  label: Text(
                    'Logout',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
