import 'dart:async';

import 'package:b_networks/utils/KColors.dart';
import 'package:b_networks/app%20components/KLogo.dart';
import 'package:b_networks/views/home/view/home_screen.dart';
import 'package:b_networks/views/login/view/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) => const LoginScreen()));
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
