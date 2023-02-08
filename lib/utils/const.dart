import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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

Future<bool> isNetworkAvailable() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

//store in shared preferences

Future storeInSharedPref(String keyName, String value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(keyName, value);
}

//getting value from share pref providing [key name]
Future<String?> getValueInSharedPref(String keyName) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(keyName);
}

/// Clear object in Shared Pref
Future clearInSharedPref(String keyName) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(keyName);
}
