
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/KColors.dart';

class KCalendarButton extends StatelessWidget {
  KCalendarButton({super.key});
  String currentMonth = DateFormat('MMMM').format(DateTime.now());
  String currentYear = DateFormat('y').format(DateTime.now());

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
          " $currentMonth $currentYear ",
          maxLines: 1,
          style: TextStyle(
              fontSize: 12,
              color: kColors.buttonTextWhite,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
