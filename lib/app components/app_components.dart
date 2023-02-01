import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/KColors.dart';

class AppComponents {
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
