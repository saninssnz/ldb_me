import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io'; // Import for Platform.isIOS

// Common navigation function
void navigateToScreen(BuildContext context, Widget screen, {bool removeUntil = false}) {
  if (Platform.isIOS) {
    if (removeUntil) {
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (context) => screen),
            (Route<dynamic> route) => false,
      );
    } else {
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => screen),
      );
    }
  } else {
    if (removeUntil) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => screen),
            (Route<dynamic> route) => false,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
    }
  }
}
