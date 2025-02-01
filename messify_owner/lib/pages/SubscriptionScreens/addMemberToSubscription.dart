import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:messify_owner/main.dart';
import 'package:messify_owner/pages/SessionMananger/session_data.dart';
import 'package:messify_owner/widgets/custom_snackbar.dart';

class AddMember extends StatefulWidget {
  final VoidCallback onUpdate;
  final Map userMap;

  AddMember({super.key, required this.userMap, required this.onUpdate});

  @override
  State<AddMember> createState() => _AddMemberState(userMap: userMap);
}

class _AddMemberState extends State<AddMember> {
  Map userMap;
  _AddMemberState({required this.userMap});

  TextEditingController _dateController = TextEditingController();
  TextEditingController _numberOfMonthsController = TextEditingController();
  TextEditingController _tokenController = TextEditingController();

  DateTime? _selectedDate;
  bool monthType = false;
  bool tokenType = false;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Member to Mess"),
        backgroundColor: const Color.fromRGBO(255, 121, 46, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // User Information Card
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEBE8E7),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          "assets/avtar.jpeg",
                          width: MainApp.widthCal(80),
                          height: MainApp.heightCal(80),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${userMap['name']}",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${userMap['username']}",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Options Container
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 121, 46, 1),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Type Selection
                    Row(
                      children: [
                        const Text(
                          "Month Type",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              monthType = true;
                              tokenType = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black),
                              color:
                                  monthType ? Colors.white : Colors.transparent,
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          "Token Type",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              tokenType = true;
                              monthType = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black),
                              color:
                                  tokenType ? Colors.white : Colors.transparent,
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Conditional Inputs
                    if (monthType) ...[
                      // Date Input
                      TextField(
                        controller: _dateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Enter Starting Date",
                          suffixIcon: GestureDetector(
                            onTap: () => _selectDate(context),
                            child: const Icon(
                              Icons.calendar_month,
                              color: Colors.black,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Number of Months Input
                      TextField(
                        controller: _numberOfMonthsController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Enter Number of Months",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                    if (tokenType) ...[
                      TextField(
                        controller: _tokenController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Enter Tokens",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],

                    // Submit Button
                    if (monthType || tokenType) const SizedBox(height: 20),
                    if (monthType || tokenType)
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            try {
                              if (_tokenController.text.trim().isNotEmpty) {
                                Map<String, dynamic> data = {
                                  'username': userMap['username'],
                                  'name': userMap['name'],
                                  'token':
                                      int.parse(_tokenController.text.trim()),
                                };
                                await FirebaseFirestore.instance
                                    .collection('subscribedUsers')
                                    .doc('${SessionData.messName}')
                                    .collection('allSubscribedUsers')
                                    .doc('${data['username']}')
                                    .set(data);
                                widget.onUpdate();
                                CustomSnackBar.customSnackBar(
                                    context: context,
                                    text:
                                        "${userMap['username']} successfully added to Subscribed Members",
                                    color: Colors.blue);
                                Navigator.pop(context);
                              }
                            } catch (e) {
                              CustomSnackBar.customSnackBar(
                                  context: context,
                                  text: "Error occured try again",
                                  color: Colors.red);
                            }
                          },
                          child: Container(
                            width: MainApp.widthCal(250),
                            height: MainApp.heightCal(50),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "Submit",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
