import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:b_networks/utils/api_urls.dart';
import 'package:b_networks/utils/const.dart';
import 'package:b_networks/utils/keys.dart';
import 'package:http/http.dart' as http;

Future<dynamic> updateProfileRequest(
    {required String phoneNumber,
    required String fullName,
    required String companyName,
    required String address,
    required String image}) async {
  try {
    // get token for shared preference
    String? token = await getValueInSharedPref(Keys.token);
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('POST', Uri.parse(updateProfileUrl));
    request.fields.addAll({
      'name': fullName,
      'company_name': companyName,
      'mobile': phoneNumber,
      'address': address
    });
    request.files
        .add(await http.MultipartFile.fromPath('profile_picture', image));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      // print(await response.stream.bytesToString());
      var finalResponse = await http.Response.fromStream(response);

      return jsonDecode(finalResponse.body);
    } else {
      log(response.toString());
      log(response.reasonPhrase.toString());
      return null;
    }
  } on SocketException {
    showToast("Socket exception");
  } on HttpException {
    showToast("HTTP Exception");
  } on FormatException {
    showToast("Format Exception");
  }
}
