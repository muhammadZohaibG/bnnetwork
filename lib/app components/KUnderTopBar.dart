import 'package:flutter/material.dart';

import '../utils/KColors.dart';

class KUnderTopBar extends StatelessWidget {
  String leftText;
  Widget? rightWidget;
  KUnderTopBar({super.key, required this.leftText, this.rightWidget});

  @override
  Widget build(BuildContext context) {
    KColors kColors = KColors();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(
            leftText,
            style: TextStyle(
                fontSize: 18,
                color: kColors.darkGrey,
                fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          rightWidget ?? Container(),
        ],
      ),
    );
  }
}
