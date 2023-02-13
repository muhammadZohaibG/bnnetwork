import 'dart:developer';

import 'package:b_networks/app%20components/app_components.dart';
import 'package:b_networks/views/city_details/provider/city_detail_provider.dart';
import 'package:b_networks/views/monthly_bill/components/components.dart';
import 'package:b_networks/views/monthly_bill/components/monthly_bill_top_bar.dart';
import 'package:b_networks/app%20components/KMainButton.dart';
import 'package:b_networks/app%20components/KUnderTopBar.dart';
import 'package:b_networks/app%20components/KLongCustomCard.dart';
import 'package:b_networks/views/monthly_bill/provider/monthly_bill_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/KColors.dart';
import '../../../app components/KDialogBox.dart';
import '../../../app components/KTextField.dart';
import '../../../utils/const.dart';

class MonthlyBillListScreen extends StatefulWidget {
  String userName;
  int? locationId;
  int? connectionId;
  MonthlyBillListScreen(
      {super.key,
      required this.userName,
      required this.connectionId,
      required this.locationId});

  @override
  State<MonthlyBillListScreen> createState() => _MonthlyBillListScreenState();
}

class _MonthlyBillListScreenState extends State<MonthlyBillListScreen> {
  KDialogBox kDialogBox = KDialogBox();
  CityDetailProvider? cityDetailProvider;

  String? month;
  String? payment;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    function();
    super.initState();
  }

  function() async {
    final monthlyBillProvider =
        Provider.of<MonthlyBillProvider>(context, listen: false);
    cityDetailProvider =
        Provider.of<CityDetailProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await monthlyBillProvider.getBills(connectionId: widget.connectionId);
    });
  }

  KColors kColors = KColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kColors.screenBG,
        body: Consumer<MonthlyBillProvider>(
            builder: (context, monthlyBillProvider, child) => Column(children: [
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
                            KUnderTopBar(leftText: "Monthly Bill List"),
                            monthlyBillProvider.isLoading
                                ? AppComponents().shimmerList(context,
                                    child: KLongCustomCard(
                                        onPress: () {},
                                        id: 0,
                                        mainTitle: '',
                                        description: '',
                                        billStatus: ''))
                                : monthlyBillProvider.billsList!.isEmpty
                                    ? MonthlyBillsListScreenComponents()
                                        .noBillToShow()
                                    : MonthlyBillsListScreenComponents()
                                        .billsList(
                                            billsList:
                                                monthlyBillProvider.billsList)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(children: [
                        Expanded(
                          child: KMainButton(
                              twoButtons: true,
                              text: "Add Payment",
                              onPressed: () {
                                kDialogBox.showDialogBox(
                                    dialogBoxHeight: 230,
                                    buttonText: "Add Now",
                                    onButtonPress: () async {
                                      if (formKey.currentState!.validate()) {
                                        bool? res =
                                            await monthlyBillProvider.addBill(
                                                connectionId:
                                                    widget.connectionId,
                                                locationId: widget.locationId);
                                        if (res) {
                                          if (!mounted) return;
                                          Navigator.of(context).pop();
                                          cityDetailProvider!
                                              .getAllConnectionsOfLocation(
                                                  locationId:
                                                      widget.locationId);
                                        }
                                      }
                                    },
                                    context: context,
                                    widgets: <Widget>[
                                      Form(
                                          key: formKey,
                                          child: Column(
                                            children: [
                                              Text(
                                                "Add Payment ${widget.userName}",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color:
                                                        kColors.statsUnderText,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const SizedBox(height: 20),
                                              KTextField(
                                                  enabled: false,
                                                  onChanged: (value) {
                                                    month = value;
                                                  },
                                                  hintText:
                                                      "${monthlyBillProvider.currentMonth} ${monthlyBillProvider.currentYear}"),
                                              const SizedBox(height: 20),
                                              KTextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: monthlyBillProvider
                                                    .amountController,
                                                validator: (v) {
                                                  if (v!.isEmpty) {
                                                    return 'Enter amount';
                                                  } else if (int.parse(v) ==
                                                      0) {
                                                    return 'Enter valid amount';
                                                  }
                                                  return null;
                                                },
                                                onChanged: (value) {
                                                  payment = value;
                                                },
                                                hintText: "Payment",
                                                suffix: Container(
                                                  decoration: BoxDecoration(
                                                    color: kColors.primary
                                                        .withOpacity(.75),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  height: 55,
                                                  width: 65,
                                                  child: Center(
                                                    child: Text(
                                                      "Rs.",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: kColors
                                                              .buttonTextWhite,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ))
                                    ]);
                              }),
                        ),
                        const SizedBox(width: 24),
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
                                            onPressed: () async {
                                              bool? res =
                                                  await monthlyBillProvider
                                                      .disconnectConnection(
                                                          connectionId: widget
                                                              .connectionId);
                                              if (res!) {
                                                log('true here');

                                                if (!mounted) return;

                                                cityDetailProvider!
                                                    .removeConnectionFromList(
                                                        widget.connectionId);
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              } else {
                                                log('false here');
                                              }
                                            })
                                      ],
                                      context: context,
                                      widgets: <Widget>[
                                        Text("Disconnect user",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: kColors.statsUnderText,
                                                fontWeight: FontWeight.w500)),
                                        const SizedBox(height: 20),
                                        Text(
                                            "Are you sure you want to disconnect this user?",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: kColors.statsUnderText,
                                                fontWeight: FontWeight.w400)),
                                      ]);
                                }))
                      ]))
                ])));
  }
}
