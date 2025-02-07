import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:messify_owner/main.dart';

class CustomSnackBar {
  static customSnackBar({
    required BuildContext context,
    required String text,
    required Color color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.startToEnd,
        hitTestBehavior: HitTestBehavior.translucent,
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.rubik(
            fontSize: MainApp.widthCal(18),
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        backgroundColor: color,
      ),
    );
  }
}
