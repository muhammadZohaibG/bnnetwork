import 'package:b_networks/views/expense/view/expenses_screen.dart';
import 'package:flutter/material.dart';

import '../utils/KColors.dart';

class KStatsCards extends StatelessWidget {
  int totalExpense;
  int totalEarning;
  bool showTotalExpense;
  bool showTotalEarning;
  Function()? earningOnTap;
  KStatsCards(
      {super.key,
      this.totalEarning = 0,
      this.totalExpense = 0,
      required this.earningOnTap,
      this.showTotalExpense = true,
      this.showTotalEarning = true});

  @override
  Widget build(BuildContext context) {
    KColors kColors = KColors();
    return SizedBox(
      height: 90,
      child: Row(
        children: [
          showTotalEarning == true
              ? Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "$totalEarning",
                          style: const TextStyle(
                              fontSize: 26,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Total Fees",
                          style: TextStyle(
                              fontSize: 12,
                              color: kColors.statsUnderText,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
          if (showTotalExpense == true && showTotalEarning == true)
            const SizedBox(width: 24),
          showTotalExpense == true
              ? Expanded(
                  child: InkWell(
                    onTap: earningOnTap,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "$totalExpense",
                            style: const TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Total Expenses",
                            style: TextStyle(
                                fontSize: 12,
                                color: kColors.statsUnderText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
