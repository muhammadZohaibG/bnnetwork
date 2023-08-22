import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:b_networks/utils/api_urls.dart';
import 'package:b_networks/utils/const.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

Future<dynamic> authLogin({required String email, required String name}) async {
  try {
    String? token = '';
    await FirebaseMessaging.instance.getToken().then((tok) {
      log("token is : $tok");
      token = tok;
    });
    log('token save===========>>>>>>>> $token');
    var request = http.MultipartRequest('POST', Uri.parse(authUrl));
    request.fields.addAll({
      'name': name,
      'email': email,
      'password': '12345678',
      'fcm_token ': token!
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
       print(response);
      var finalResponse = await http.Response.fromStream(response);

      return jsonDecode(finalResponse.body);
    } else {
      log(response.statusCode.toString());
      log(response.reasonPhrase.toString());
      return response.reasonPhrase;
    }
  } on SocketException {
    showToast("Socket exception");
  } on HttpException {
    showToast("HTTP Exception");
  } on FormatException {
    showToast("Format Exception");
  }
}
