import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messify_owner/main.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class GenerateQRCodePage extends StatefulWidget {
  const GenerateQRCodePage({super.key});

  @override
  _GenerateQRCodePageState createState() => _GenerateQRCodePageState();
}

class _GenerateQRCodePageState extends State<GenerateQRCodePage> {
  String qrData = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Generate QR Code")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 200.0,
              ),
              GestureDetector(
                onTap: () async {
                  DateTime now = DateTime.now();
                  String formattedDate = DateFormat('yyyy-MM-dd').format(now);
                  setState(() {
                    qrData = "$formattedDate ${MainApp.messName}";
                  });
                  print(qrData);
                  Map<String, dynamic> data = {
                    "qrcode": qrData,
                  };
                  try {
                    await FirebaseFirestore.instance
                        .collection("Qr Data")
                        .doc(MainApp.messName)
                        .collection("Datewise Data")
                        .doc(formattedDate)
                        .set(data);

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Data Added Successfully")));
                  } catch (e) {
                    print("Error adding data: ${e.toString()}");
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error adding data: $e")));
                  }
                },
                child: Container(
                  height: MainApp.heightCal(50),
                  width: MainApp.widthCal(400),
                  alignment: Alignment.center,
                  color: const Color.fromARGB(255, 2, 25, 44),
                  child: const Text(
                    "Generate Qr",
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
