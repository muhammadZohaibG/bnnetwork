import 'dart:developer';

import 'package:b_networks/utils/keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../utils/const.dart';

class LoginProvider extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool isLoading = false;
  updateLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<bool?> loginWithGoogle() async {
    try {
      String email = '', imageurl = '', name = '';

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      // final credential = GoogleAuthProvider.credential(
      //     accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      email = googleUser.email;
      imageurl = googleUser.photoUrl.toString();
      name = googleUser.displayName.toString();
      // await firebaseAuth.signInWithCredential(credential).then((value) {
      //   log(value.user!.email.toString());
      // }).onError((error, stackTrace) {
      //   log(error.toString());
      // });
      log('id tokenn ${googleAuth.idToken}');
      log("id========>>>>>>${googleUser.id}");
      log("email==========>>>>>>$email");
      log("name==========>>>>>>$name");
      log("token==========>>>>>>${googleAuth.idToken}");
      log("image==========>>>>>>$imageurl");
      await storeInSharedPref(Keys.email, email.toString());
      await storeInSharedPref(Keys.name, name.toString());
      await storeInSharedPref(Keys.image, imageurl.toString());
      await storeInSharedPref(Keys.token, googleAuth.idToken.toString());
      if (name.isNotEmpty || email.isNotEmpty) {
        log('name and email not empty ');
        return true;
      } else {
        log('name and email empty ');
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future signOut() async {
    try {
      await GoogleSignIn().signOut();
      await firebaseAuth.signOut();
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
