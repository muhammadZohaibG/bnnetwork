import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const all = "All";
const pending = "Pending";
const paid = "Paid";

const String dateFormat = 'yyyy-MM-dd HH:mm:ss';

showToast(String? data, {Color? backgroundColor = Colors.red}) {
  Fluttertoast.showToast(
      msg: data!, // "This is Center Short Toast",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor, //Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
