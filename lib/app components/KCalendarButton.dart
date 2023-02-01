import 'dart:developer';

import 'package:flutter/material.dart';

import '../utils/KColors.dart';

class KCalendarButton extends StatelessWidget {
  const KCalendarButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    KColors kColors = KColors();
    return Container(
      height: 40,
      width: 125,
      decoration: BoxDecoration(
        color: kColors.primary,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          "Feb 2023",
          maxLines: 1,
          style: TextStyle(
              fontSize: 18,
              color: kColors.buttonTextWhite,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
