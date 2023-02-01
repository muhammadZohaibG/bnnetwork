import 'package:flutter/material.dart';

import '../utils/KColors.dart';

class KExpenseLongCard extends StatelessWidget {
  VoidCallback? onPress;
  String? descriptionImgPath;
  String mainTitle;
  String description;
  String date;
  KExpenseLongCard(
      {super.key,
      this.onPress,
      required this.mainTitle,
      required this.description,
      required this.date,
      this.descriptionImgPath});

  @override
  Widget build(BuildContext context) {
    KColors kColors = KColors();
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 30, top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      mainTitle,
                      style: TextStyle(
                          fontSize: 16,
                          color: kColors.darkGrey,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                          fontSize: 12,
                          color: kColors.statsUnderText,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xff828282),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
