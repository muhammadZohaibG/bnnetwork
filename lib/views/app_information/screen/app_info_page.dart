import 'package:b_networks/views/app_information/components/app_info_topbar.dart';
import 'package:flutter/material.dart';

import '../../../utils/KColors.dart';

class AppInfoPage extends StatefulWidget {
  const AppInfoPage({super.key});

  @override
  State<AppInfoPage> createState() => _AppInfoPageState();
}

class _AppInfoPageState extends State<AppInfoPage> {
  @override
  Widget build(BuildContext context) {
    KColors kColors = KColors();

    return Scaffold(
        backgroundColor: kColors.screenBG,
        body: Column(children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: AppInfoTopBar(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/images/app_info.png"),
                  Text(
                    'Simplified the way of connections',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: kColors.darkGrey,
                    ),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley  of type and scrambled it to make a type specimen book.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: kColors.darkGrey,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Please read our Terms & Conditions',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xff573353),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          )
        ]));
  }
}
