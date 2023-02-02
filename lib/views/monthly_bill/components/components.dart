import 'package:b_networks/models/bill_model.dart';
import 'package:flutter/material.dart';

import '../../../app components/KLongCustomCard.dart';
import '../../../utils/KColors.dart';

class MonthlyBillsListScreenComponents {
  Widget billsList({required List<BillModel>? billsList}) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
      itemCount: billsList!.length,
      itemBuilder: (context, i) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: KLongCustomCard(
                onPress: () {},
                mainTitle: billsList[i].month!,
                description: billsList[i].amount!.toString(),
                billStatus: billsList[i].status!));
      },
    );
  }

  Widget noBillToShow() {
    return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('No Bills To Show',
              style: TextStyle(
                  fontSize: 20,
                  color: KColors().darkGrey,
                  fontWeight: FontWeight.w500))
        ]));
  }
}
