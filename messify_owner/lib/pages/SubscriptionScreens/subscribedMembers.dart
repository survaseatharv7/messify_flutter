import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messify_owner/main.dart';
import 'package:intl/intl.dart';
import 'package:messify_owner/pages/SessionMananger/session_data.dart';
import 'package:messify_owner/pages/SubscriptionScreens/addMemberToSubscription.dart';

class Subscribedmembers extends StatefulWidget {
  const Subscribedmembers({super.key});
  static void listAdder() {}

  @override
  State<Subscribedmembers> createState() => _SubscribedmembersState();
}

class _SubscribedmembersState extends State<Subscribedmembers> {
  int supplyingIndex = 0;
  TextEditingController _searchController = TextEditingController();
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  static List subscribedUserlist = [];
  List searchedUserList = [];
  List allUserList = [];

  void allUsersListGetter() async {
    QuerySnapshot response =
        await _firebaseFirestore.collection("Userinfo").get();
    allUserList.clear();
    for (int i = 0; i < response.docs.length; i++) {
      Map map = {};
      map['username'] = response.docs[i].get('username');
      map['name'] = response.docs[i].get('name');
      allUserList.add(map);
    }
    setState(() {});
  }

  void subscribedUserListGetter() async {
    QuerySnapshot response = await _firebaseFirestore
        .collection('subscribedUsers')
        .doc('${SessionData.messName}')
        .collection('allSubscribedUsers')
        .get();
    subscribedUserlist.clear();
    for (int i = 0; i < response.docs.length; i++) {
      Map map = {};
      map['username'] = response.docs[i].get('username');
      map['name'] = response.docs[i].get('name');
      map['token'] = response.docs[i].get('token').toString();
      subscribedUserlist.add(map);
      setState(() {});
    }
  }

  void memberRemover(int index) async {
    await _firebaseFirestore
        .collection('subscribedUsers')
        .doc("${SessionData.messName}")
        .collection('allSubscribedUsers')
        .doc('${subscribedUserlist[index]['username']}')
        .delete();
  }

  Widget usersCardBuilder(int index, List list) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Colors.orange.shade300, Colors.orange.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 80,
                  height: 80,
                  color: Colors.blue,
                  child: Image.asset("assets/avtar.jpeg", fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${list[index]['name']}",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "${list[index]['username']}",
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    if (list == subscribedUserlist) ...[
                      SizedBox(height: 8),
                      Text(
                        "Token left: ${list[index]['token']}",
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (list == subscribedUserlist)
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    _searchController.clear();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddMember(
                                  userMap: subscribedUserlist[index],
                                  onUpdate: subscribedUserListGetter,
                                )));
                  },
                ),
              if (list == subscribedUserlist)
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () {
                    memberRemover(index);
                  },
                ),
              if (list == searchedUserList)
                IconButton(
                  icon: Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    _searchController.clear();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddMember(
                                  userMap: searchedUserList[index],
                                  onUpdate: subscribedUserListGetter,
                                )));
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    subscribedUserListGetter();

    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade600,
        title: Text(
          "Subscribed Members",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                onTap: () {
                  allUsersListGetter();
                },
                controller: _searchController,
                onChanged: (value) {
                  searchedUserList.clear();
                  for (int i = 0; i < allUserList.length; i++) {
                    bool newUser = true;
                    if (_searchController.text.trim().isNotEmpty) {
                      if (allUserList[i]['username']
                          .toString()
                          .toLowerCase()
                          .contains(value.toLowerCase())) {
                        for (int j = 0; j < subscribedUserlist.length; j++) {
                          if (allUserList[i]['username'] ==
                              subscribedUserlist[j]['username']) {
                            newUser = false;
                            break;
                          }
                        }
                        if (newUser) searchedUserList.add(allUserList[i]);
                        print("Searched User List :$searchedUserList");
                        print("All User List : $allUserList");
                      }
                    } else {
                      searchedUserList.clear();
                    }
                  }
                  if (_searchController.text.isEmpty) {
                    searchedUserList.clear();
                  }
                  setState(() {});
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  hintText: "Search Users",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            if (_searchController.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Search Results for '${_searchController.text.trim()}'",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ),
              ),
            if (_searchController.text.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: searchedUserList.length,
                itemBuilder: (context, index) =>
                    usersCardBuilder(index, searchedUserList),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Subscribed Users",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: subscribedUserlist.length,
              itemBuilder: (context, index) =>
                  usersCardBuilder(index, subscribedUserlist),
            ),
          ],
        ),
      ),
    );
  }
}
