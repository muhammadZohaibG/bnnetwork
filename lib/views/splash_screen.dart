import 'dart:async';
import 'dart:developer';

import 'package:b_networks/utils/KColors.dart';
import 'package:b_networks/app%20components/KLogo.dart';
import 'package:b_networks/views/home/view/home_screen.dart';
import 'package:b_networks/views/login/view/login_screen.dart';
import 'package:flutter/material.dart';

import '../utils/const.dart';
import '../utils/keys.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () async {
      String? spEmail = await getValueInSharedPref(Keys.email);
      String? spName = await getValueInSharedPref(Keys.name);
      String? spToken = await getValueInSharedPref(Keys.token);

      log('sp credentials name = $spName, email = $spEmail');
      if (spEmail == null ||
          spEmail == '' ||
          spName == null ||
          spName == '' ||
          spToken == null ||
          spToken == '') {
        if (!mounted) return;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) => const LoginScreen()));
      } else {
        log(' name in sp = $spName, email = $spEmail');
        if (!mounted) return;

        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute<void>(
        //         builder: (BuildContext context) => const HomePage()),
        //     (route) => false);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) => const HomePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    KColors kColors = KColors();
    return Scaffold(
        backgroundColor: kColors.screenBG,
        body: Center(child: KLogo(logoFontSize: 40, logoRadius: 105)));
  }
}
