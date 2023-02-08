import 'package:b_networks/app%20components/KTopBar.dart';
import 'package:flutter/material.dart';

import '../../../app components/KCircle.dart';
import '../../../app components/KLogo.dart';
import '../../../utils/KColors.dart';

class LoginTopBar extends StatelessWidget {
  const LoginTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    KColors kColors = KColors();
    return KTopBar(
      leftFlex: 2,
      leftWidget: Row(
        children: [
          KLogo(logoRadius: 45, logoFontSize: 16),
          const SizedBox(width: 7),
          Text('B Networks',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: kColors.darkGrey))
        ],
      ),
      rightWidget: KCircle(
          logoRadius: 45,
          centerWidget: Image.asset("assets/icons/help_icon.png", scale: 1.1)),
    );
  }
}
