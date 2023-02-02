import 'package:flutter/material.dart';

import '../../../utils/KColors.dart';

class CityDetailsFilter extends StatelessWidget {
  VoidCallback onTap;
  String text;
  bool? isSelected = false;
  CityDetailsFilter(
      {super.key, required this.text, required this.onTap, this.isSelected});

  @override
  Widget build(BuildContext context) {
    KColors kColors = KColors();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: isSelected == true ? kColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            height: 30,
            width: 100,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 12,
                    color: isSelected == true
                        ? Colors.white
                        : const Color(0xff796D61),
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
