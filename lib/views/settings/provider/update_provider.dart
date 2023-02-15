// import 'dart:developer';

// import 'package:b_networks/utils/const.dart';
// import 'package:b_networks/utils/keys.dart';
// import 'package:flutter/cupertino.dart';

// class UpdateProvider extends ChangeNotifier {
//   String? fullName = '';
//   String? company = '';
//   String? email = '';
//   String? phoneNumber = '';
//   String? address = '';

//   Future getUserData() async {
//     try {
//       fullName = await getValueInSharedPref(Keys.name);
//       company = await getValueInSharedPref(Keys.companyName);
//       email = await getValueInSharedPref(Keys.email);
//       phoneNumber = await getValueInSharedPref(Keys.mobile);
//       address = await getValueInSharedPref(Keys.address);
//     } catch (e) {
//       log(e.toString());
//     }
//   }
// }
