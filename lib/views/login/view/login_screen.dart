import 'dart:developer';

import 'package:b_networks/utils/KColors.dart';
import 'package:b_networks/utils/const.dart';
import 'package:b_networks/views/home/view/home_screen.dart';
import 'package:b_networks/views/login/components/app_info_topbar.dart';
import 'package:b_networks/views/login/components/components.dart';
import 'package:b_networks/views/login/provider/login_provider.dart';
import 'package:flutter/gestures.dart';
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
        child: Column(children: [
          const Padding(
              padding: EdgeInsets.only(bottom: 10), child: LoginTopBar()),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset("assets/images/app_info.png"),
                    Text('Simplified the way of connections',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: KColors().darkGrey)),
                    const SizedBox(height: 17),
                    Text(
                        '''Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.''',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: KColors().darkGrey)),
                    const SizedBox(height: 50),
                    Consumer<LoginProvider>(
                        builder: (context, loginProvider, child) =>
                            loginProvider.isLoading
                                ? CircularProgressIndicator(color: primaryColor)
                                : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      LoginScreenComponents().socialButton(
                                          context, onTap: () async {
                                        bool? checkInternet =
                                            await isNetworkAvailable();
                                        if (checkInternet) {
                                          bool? res = await loginProvider
                                              .loginWithGoogle();
                                          log(res.toString());
                                          if (res!) {
                                            if (!mounted) return;
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomePage()));
                                          }
                                        } else {
                                          showToast(noInternetConnection);
                                        }
                                      }),
                                      // LoginScreenComponents()
                                      //     .socialButton(context, onTap: () {
                                      //   FirebaseMessaging.instance
                                      //       .getToken()
                                      //       .then((token) {
                                      //     log("token is : $token");
                                      //   });
                                      // })
                                    ],
                                  )),
                  ],
                ),
              ),
            ),
          ),
          RichText(
              text: TextSpan(
            text: 'Please read our ',
            children: [
              TextSpan(
                  text: 'Terms & Conditions',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: primaryColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launchUrlCustomTab(termsAndConditionsUrl);
                    }),
            ],
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xff573353)),
          )),
          // const Text('Please read our Terms & Conditions',
          //     style: TextStyle(
          //         fontWeight: FontWeight.w400,
          //         fontSize: 14,
          //         color: Color(0xff573353))),
          const SizedBox(height: 30),
        ]),
      ),
    );
  }
}
