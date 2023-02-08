import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/KColors.dart';

class AppComponents {
  Widget connectionsStatsRow(
      {required int totalConnections, required int totalUnpaidConnections}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(
        flex: 2,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(
                    fontSize: 16,
                    color: kdarkGrey,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '$totalConnections  ',
                style: TextStyle(
                    fontSize: 16,
                    color: kdarkGrey,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(width: 5),
      Expanded(
          flex: 2,
          child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pending:',
                      style: TextStyle(
                          fontSize: 16,
                          color: kdarkGrey,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '$totalUnpaidConnections  ',
                      style: TextStyle(
                          fontSize: 16,
                          color: kdarkGrey,
                          fontWeight: FontWeight.w600),
                    )
                  ])))
    ]);
  }

  Widget shimmerList(BuildContext context,
      {int? itemCount = 4, required Widget? child}) {
    return Shimmer.fromColors(
        enabled: true,
        baseColor: Colors.grey.shade300,
        highlightColor: primaryColor.withOpacity(0.5), //Colors.grey.shade100,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: itemCount,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: child,
          ),
        ));
  }
}
