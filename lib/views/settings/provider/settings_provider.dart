import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../utils/const.dart';
import '../../../utils/keys.dart';

class SettingsProvider extends ChangeNotifier {
  bool isLoading = false;
  String? email = '';
  String? profileImage;
  String? name = '';
  bool? notificationsSwitch = false;

  updateLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  updateNotificationSwitch(bool? value) {
    notificationsSwitch = value;
    notifyListeners();
  }

  Future userDetails() async {
    try {
      updateLoading(true);
      email = await getValueInSharedPref(Keys.email);
      profileImage = await getValueInSharedPref(Keys.image);
      log(profileImage!);

      name = await getValueInSharedPref(Keys.name);
      notifyListeners();
      updateLoading(false);
    } catch (e) {
      log(e.toString());
      updateLoading(false);
    }
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
