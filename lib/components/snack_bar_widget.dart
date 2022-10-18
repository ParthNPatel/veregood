import 'package:flutter/material.dart';

class CommonSnackBar {
  static getSnackBar(
      {required BuildContext context,
      required String message,
      Color color = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        duration: Duration(seconds: 3),
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
