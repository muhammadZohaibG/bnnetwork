import 'package:b_networks/utils/const.dart';
import 'package:flutter/material.dart';

import '../utils/KColors.dart';

class KLongCustomCard extends StatelessWidget {
  VoidCallback? onPress;
  int? id;
  String? descriptionImgPath;
  String mainTitle;
  String description;
  String billStatus;
  KLongCustomCard(
      {super.key,
      this.onPress,
      required this.id,
      required this.mainTitle,
      required this.description,
      required this.billStatus,
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
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          billStatus == paid ? kColors.accept : kColors.decline,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 22,
                    width: 65,
                    child: Center(
                      child: Text(
                        billStatus,
                        style: TextStyle(
                            fontSize: 12,
                            color: kColors.buttonTextWhite,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
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
