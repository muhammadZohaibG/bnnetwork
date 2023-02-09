import 'package:b_networks/app%20components/KTopBar.dart';
import 'package:flutter/material.dart';

import '../../../app components/KCircle.dart';
import '../../../utils/KColors.dart';

class SettingsTopBar extends StatelessWidget {
  SettingsTopBar({super.key});
  KColors kColors = KColors();

  @override
  Widget build(BuildContext context) {
    return KTopBar(
      leftFlex: 1,
      backArrow: true,
      midWidget: const Text(
        'Settings',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: Color(0xff573353),
        ),
      ),
      rightWidget: KCircle(
          logoRadius: 30,
          centerWidget: Image.asset(
            "assets/icons/pen.png",
            scale: 1.1,
          )),
    );
  }
}
