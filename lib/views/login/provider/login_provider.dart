import 'dart:developer';

import 'package:b_networks/api_requests/auth_request.dart';
import 'package:b_networks/utils/keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

import '../../../utils/const.dart';

class LoginProvider extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String currentMonth = DateFormat('MMMM').format(DateTime.now());
  String currentYear = DateFormat('y').format(DateTime.now());
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
      // log("googleAuth.idToken==========>>>>>>${googleAuth.idToken}");
      // log("image==========>>>>>>$imageurl");

      updateLoading(true);
      if (name.isNotEmpty || email.isNotEmpty) {
        log('name and email not empty ');
        // call login api
        Map<String, dynamic> user = await authLogin(email: email, name: name);
        log(user.toString());
        log('message ${user['data']['address']}');
        if (user['status'] != null && user['status'] == 200) {
          log(user['message']);
          await storeInSharedPref(Keys.email, email.toString());
          await storeInSharedPref(Keys.name, name.toString());
          await storeInSharedPref(Keys.image, user['data']['profile_picture']);
          await storeInSharedPref(Keys.token, user['data']['token']);
          await storeInSharedPref(Keys.address, user['data']['address']);
          await storeInSharedPref(Keys.mobile, user['data']['mobile']);
          await storeInSharedPref(
              Keys.companyName, user['data']['company_name']);
          await storeInSharedPref(Keys.currentMonth, currentMonth);
          updateLoading(false);
          return true;
        } else {
          showToast('Login Failed!');
          updateLoading(false);
          return false;
        }
      } else {
        updateLoading(false);
        log('name and email empty after gooogle sign in');
        return false;
      }
    } catch (e) {
      updateLoading(false);
      log(e.toString());
      showToast('Login Failed!');
      return false;
    }
  }

  Future signOut() async {
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
