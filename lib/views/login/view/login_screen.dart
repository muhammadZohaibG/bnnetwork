import 'dart:developer';

import 'package:b_networks/app%20components/KMainButton.dart';
import 'package:b_networks/utils/KColors.dart';
import 'package:b_networks/utils/const.dart';
import 'package:b_networks/views/home/view/home_screen.dart';
import 'package:b_networks/views/login/components/app_info_topbar.dart';
import 'package:b_networks/views/login/components/components.dart';
import 'package:b_networks/views/login/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors().screenBG,
      body: SizedBox(
        height: height(context),
        child: SingleChildScrollView(
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: LoginTopBar(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/images/app_info.png"),
                  Text('Simplified the way of connections',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: KColors().darkGrey)),
                  const SizedBox(height: 17),
                  Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley  of type and scrambled it to make a type specimen book.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: KColors().darkGrey)),
                  const SizedBox(height: 17),
                  Consumer<LoginProvider>(
                      builder: (context, loginProvider, child) =>
                          loginProvider.isLoading
                              ? CircularProgressIndicator(color: primaryColor)
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    LoginScreenComponents()
                                        .socialButton(context, onTap: () async {
                                      // loginProvider.updateLoading(true);
                                      // await Future.delayed(
                                      //     const Duration(seconds: 3), () {
                                      //   loginProvider.updateLoading(false);
                                      // });

                                      bool? res =
                                          await loginProvider.loginWithGoogle();
                                      log(res.toString());
                                      if (res!) {
                                        if (!mounted) return;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomePage()));
                                      } else {}
                                    }),
                                    KMainButton(
                                        text: 'Continue as Guest',
                                        onPressed: () {}),
                                  ],
                                )),
                  const SizedBox(height: 17),
                  const Text('Please read our Terms & Conditions',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xff573353))),
                  const SizedBox(height: 30),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
