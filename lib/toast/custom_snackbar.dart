import 'package:flutter/material.dart';

class CustomSnackbar {
  void snackbar(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: TextStyle(color: Color(0xff282F66),fontSize: 19),
      ),
      backgroundColor: Colors.indigo,
      duration: Duration(seconds: 5),
      elevation: 10,
      behavior: SnackBarBehavior.fixed,
      action: SnackBarAction(
        label: 'Undo',
        textColor: Colors.white,
        onPressed: () {},
      ),
    ));
  }
}