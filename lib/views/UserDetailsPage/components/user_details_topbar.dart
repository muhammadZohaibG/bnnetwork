import 'package:b_networks/app%20components/KCircle.dart';
import 'package:b_networks/app%20components/KLogo.dart';
import 'package:b_networks/app%20components/KTopBar.dart';
import 'package:flutter/material.dart';

import '../../../utils/KColors.dart';

class UserDetailsTopBar extends StatelessWidget {
  String userName;
  UserDetailsTopBar({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    KColors kColors = KColors();
    return KTopBar(
      leftFlex: 2,
      leftWidget: Row(
        children: [
          KLogo(
            logoRadius: 45,
            logoFontSize: 16,
          ),
          const SizedBox(
            width: 7,
          ),
          Text(
            userName,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: kColors.darkGrey,
            ),
          ),
        ],
      ),
      rightWidget: KCircle(
          logoRadius: 45,
          centerWidget: Image.asset(
            "assets/icons/help_icon.png",
            scale: 1.1,
          )),
    );
  }
}
