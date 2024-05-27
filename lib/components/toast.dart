import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void showToastMessage({required String message}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: Color.fromARGB(255, 54, 54, 54),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
