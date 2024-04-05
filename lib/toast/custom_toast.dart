import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class CustomToast {
    void Toastt(String? msg){
        Fluttertoast.showToast(
            msg: msg.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 4,
            backgroundColor: const Color(0xff5B6EFB),
            textColor: const Color(0xff282F66),
            fontSize: 16.0
        );
    }

  }