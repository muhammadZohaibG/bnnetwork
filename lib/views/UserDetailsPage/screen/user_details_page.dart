import 'package:b_networks/views/UserDetailsPage/components/user_details_topbar.dart';
import 'package:b_networks/app%20components/KMainButton.dart';
import 'package:b_networks/app%20components/KUnderTopBar.dart';
import 'package:b_networks/app%20components/KLongCustomCard.dart';
import 'package:flutter/material.dart';

import '../../../utils/KColors.dart';
import '../../../app components/KDialogBox.dart';
import '../../../app components/KTextField.dart';

class UserDetailsPage extends StatefulWidget {
  String userName;
  UserDetailsPage({super.key, required this.userName});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  KDialogBox kDialogBox = KDialogBox();
  List<String> months = ["January", "February"];

  List<String> billAmount = ["2500", "7000"];

  List<String> userPaidStatus = ["paid", "pending"];

  @override
  Widget build(BuildContext context) {
    String? month;
    String? payment;
    final textFieldController = TextEditingController();
    final locationTextFieldController = TextEditingController();
    KColors kColors = KColors();
    return Scaffold(
      backgroundColor: kColors.screenBG,
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: UserDetailsTopBar(userName: widget.userName),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KUnderTopBar(
                    leftText: "Monthly Bill List",
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: months.length,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          KLongCustomCard(
                              onPress: () {},
                              mainTitle: months[i],
                              description: billAmount[i],
                              billStatus: userPaidStatus[i]),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              Expanded(
                child: KMainButton(
                    twoButtons: true,
                    text: "Add Payment",
                    onPressed: () {
                      kDialogBox.showDialogBox(
                          dialogBoxHeight: 230,
                          buttonText: "Add Now",
                          onButtonPress: () {
                            if (month != null &&
                                payment != null &&
                                !months.contains(month)) {
                              months.add(month!);
                              billAmount.add(payment!);
                              userPaidStatus.add("paid");
                              Navigator.pop(context);
                              setState(() {});
                            }
                          },
                          context: context,
                          widgets: <Widget>[
                            Text(
                              "Add Payment ${widget.userName}",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: kColors.statsUnderText,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            KTextField(
                              onChanged: (value) {
                                month = value;
                              },
                              hintText: "January 2023",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            KTextField(
                              onChanged: (value) {
                                payment = value;
                              },
                              hintText: "Payment",
                              suffix: Container(
                                decoration: BoxDecoration(
                                  color: kColors.primary.withOpacity(.75),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                height: 55,
                                width: 65,
                                child: Center(
                                  child: Text(
                                    "Rs.",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: kColors.buttonTextWhite,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            )
                          ]);
                    }),
              ),
              const SizedBox(
                width: 24,
              ),
              Expanded(
                child: KMainButton(
                    color: kColors.decline,
                    twoButtons: true,
                    text: "Disconnect User",
                    onPressed: () {
                      kDialogBox.showDialogBox(
                          moreButtons: true,
                          dialogBoxHeight: 140,
                          buttonWidgets: <Widget>[
                            KMainButton(
                              color: const Color(0xff828282),
                              forDialog: true,
                              text: "Cancel",
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            KMainButton(
                              color: kColors.decline,
                              forDialog: true,
                              text: "Disconnect",
                              onPressed: () {},
                            ),
                          ],
                          context: context,
                          widgets: <Widget>[
                            Text(
                              "Disconect user",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: kColors.statsUnderText,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Are you sure you want to disconnect this user?",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: kColors.statsUnderText,
                                  fontWeight: FontWeight.w400),
                            ),
                          ]);
                    }),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
