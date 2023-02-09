import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../utils/const.dart';
import '../../../utils/keys.dart';

class SettingsProvider extends ChangeNotifier {
  bool isLoading = false;

  updateLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future logOut() async {
    try {
      await GoogleSignIn().signOut();
      // await firebaseAuth.signOut();
      await clearInSharedPref(Keys.email);
      await clearInSharedPref(Keys.name);
      await clearInSharedPref(Keys.image);
      await clearInSharedPref(Keys.token);
      String? name = await getValueInSharedPref(Keys.name);
      log(name!);
    } catch (e) {
      log(e.toString());
    }
  }
}
