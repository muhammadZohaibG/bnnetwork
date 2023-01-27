import 'package:flutter/material.dart';

import '../utils/KColors.dart';

class KMainButton extends StatelessWidget {
  Color? color;
  bool twoButtons;
  bool forDialog;
  String text;
  VoidCallback onPressed;
  KMainButton({
    super.key,
    this.color,
    required this.text,
    required this.onPressed,
    this.forDialog = false,
    this.twoButtons = false,
  });

  @override
  Widget build(BuildContext context) {
    KColors kColors = KColors();
    return Padding(
      padding: twoButtons == true
          ? const EdgeInsets.symmetric(vertical: 20)
          : forDialog == false
              ? const EdgeInsets.only(bottom: 20, left: 30, right: 30, top: 15)
              : const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 15),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: color ?? kColors.primary,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 18,
                  color: kColors.buttonTextWhite,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
