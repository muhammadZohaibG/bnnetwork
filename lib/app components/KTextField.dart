import 'package:flutter/material.dart';

import '../utils/KColors.dart';

class KTextField extends StatelessWidget {
  Widget? suffix;
  KColors kColors = KColors();
  Color? color;
  String? hintText;
  void Function(String)? onChanged;
  TextEditingController? controller;
  KTextField(
      {super.key,
      this.suffix,
      required this.onChanged,
      this.controller,
      this.hintText,
      this.color});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: suffix,
        hintText: hintText,
        filled: true,
        fillColor: color ?? kColors.primary.withOpacity(0.1),
        //labelText: "17 Chak North",
        labelStyle: TextStyle(
            color: kColors.darkGrey, fontSize: 16, fontWeight: FontWeight.w400),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(
            color: kColors.primary.withOpacity(0.1),
          ),
        ),
      ),
    );
  }
}
