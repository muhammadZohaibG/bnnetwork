import 'dart:developer';

import 'package:b_networks/utils/keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../utils/const.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;
  updateLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<bool?> loginWithGoogle() async {
    try {
      String email, imageurl, name;

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      email = googleUser.email;
      imageurl = googleUser.photoUrl.toString();
      name = googleUser.displayName.toString();
      log('id tokenn ${credential.idToken}');
      log("id========>>>>>>${googleUser.id}");
      log("email==========>>>>>>${googleUser.email}");
      log("name==========>>>>>>${googleUser.displayName}");
      log("token==========>>>>>>${googleAuth.idToken}");
      await storeInSharedPref(Keys.email, email.toString());
      await storeInSharedPref(Keys.name, name.toString());
      await storeInSharedPref(Keys.image, imageurl.toString());
      await storeInSharedPref(Keys.token, googleAuth.idToken.toString());
      if (name.isNotEmpty && email.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
