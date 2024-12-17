import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messify/main.dart';
import 'package:messify/pages/MainDashboard.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("QR Code Attendance")),
      body: Center(
        child: IconButton(
          icon: const Icon(Icons.qr_code_scanner, size: 50),
          onPressed: () async {
            // Navigate to the QR scanner page and check for result
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QRScannerPage(username: username),
              ),
            );
            if (result != null && result == true) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Attendance marked successfully!")),
              );
            } else if (result != null && result == false) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("QR code does not match!")),
              );
            }
          },
        ),
      ),
    );
  }
}

class QRScannerPage extends StatefulWidget {
  final String username;

  const QRScannerPage({super.key, required this.username});

  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan QR Code for ${widget.username}")),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1.0,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) async {
      if (_isProcessing) return; // Ignore subsequent scans
      _isProcessing = true;

      if (scanData.code != null) {
        String formattedDate = DateFormat('yyyy-MM-dd ').format(DateTime.now());
        String usernamefinal = formattedDate + widget.username;
        print("Scanned QR Code: ${scanData.code}");
        print("Expected QR Code: $usernamefinal");

        if (scanData.code == usernamefinal) {
          controller.pauseCamera();
          int? remainingToken;

          try {
            final userDoc = await FirebaseFirestore.instance
                .collection("subscribedUsers")
                .doc(widget.username)
                .collection("allSubscribedUsers")
                .doc(MainApp.username)
                .get();

            if (userDoc.exists) {
              final token = userDoc.data()?['token'];
              if (token != null) {
                MainApp.token = token;
                remainingToken = MainApp.token - 1;
                print("Token after update: $remainingToken");

                // Update Firestore with new token
                Map<String, dynamic> updatedData = {
                  "username": MainApp.username,
                  "name": MainApp.name,
                  "token": remainingToken,
                };

                await FirebaseFirestore.instance
                    .collection("subscribedUsers")
                    .doc(widget.username)
                    .collection("allSubscribedUsers")
                    .doc(MainApp.username)
                    .set(updatedData);

                // Save attendance data
                await FirebaseFirestore.instance
                    .collection("Attendence")
                    .doc(widget.username)
                    .collection(formattedDate)
                    .doc(MainApp.username)
                    .set(updatedData);

                // Navigate to the main dashboard
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Maindashboard()),
                  (route) => false,
                );
              }
            }
          } catch (e) {
            print("Error updating token: $e");
          } finally {
            _isProcessing = false;
          }
        } else {
          print("Invalid QR code scanned!");
          controller.pauseCamera();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("QR code does not match!")),
          );
          await Future.delayed(const Duration(seconds: 2));
          controller.resumeCamera();
          _isProcessing = false;
        }
      } else {
        print("No scan data received!");
        _isProcessing = false;
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
