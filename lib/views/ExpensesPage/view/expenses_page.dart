import 'package:b_networks/app%20components/KCalendarButton.dart';
import 'package:b_networks/app%20components/KExpenseLongCard.dart';
import 'package:b_networks/app%20components/KMainButton.dart';
import 'package:b_networks/app%20components/KUnderTopBar.dart';
import 'package:b_networks/views/ExpensesPage/components/expenses_topbar.dart';
import 'package:flutter/material.dart';

import '../../../utils/KColors.dart';
import '../../../app components/KDialogBox.dart';
import '../../../app components/KTextField.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  KDialogBox kDialogBox = KDialogBox();
  String searchFilter = "";
  List<String> expenseTitle = [
    "Petrol in bike",
    "Cash spent on disloyal friends"
  ];

  List<String> expenseAmount = ["650", "100,000"];

  List<String> expenseDate = ["25 Dec 2022", "17 Jan 2023"];

  @override
  Widget build(BuildContext context) {
    String? newExpense;
    String? newAmount;
    final textFieldController = TextEditingController();
    final locationTextFieldController = TextEditingController();
    KColors kColors = KColors();
    return Scaffold(
      backgroundColor: kColors.screenBG,
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: ExpensesTopBar(),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KUnderTopBar(
                    leftText: "Expenses List",
                    rightWidget: const KCalendarButton(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  KTextField(
                    onChanged: (value) {
                      searchFilter = value;
                      setState(() {});
                    },
                    color: Colors.white,
                    hintText: "Search by Expense",
                    suffix: SizedBox(
                      height: 55,
                      width: 65,
                      child:
                          Center(child: Image.asset("assets/icons/search.png")),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: expenseTitle.length,
                    itemBuilder: (context, i) {
                      return Builder(builder: (context) {
                        if (searchFilter == "") {
                          return Column(
                            children: [
                              KExpenseLongCard(
                                  onPress: () {},
                                  mainTitle: expenseTitle[i],
                                  description: expenseAmount[i],
                                  date: expenseDate[i]),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          );
                        } else if (searchFilter != "" &&
                            (expenseTitle[i].toLowerCase())
                                .contains(searchFilter.toLowerCase())) {
                          return Column(
                            children: [
                              KExpenseLongCard(
                                  onPress: () {},
                                  mainTitle: expenseTitle[i],
                                  description: expenseAmount[i],
                                  date: expenseDate[i]),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          );
                        } else {
                          return Container();
                        }
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        KMainButton(
            text: "Add Expense",
            onPressed: () {
              kDialogBox.showDialogBox(
                  dialogBoxHeight: 270,
                  buttonText: "Add Expense",
                  onButtonPress: () {
                    if (newExpense != null &&
                        newAmount != null &&
                        !expenseTitle.contains(newExpense)) {
                      expenseTitle.add(newExpense!);
                      expenseAmount.add(newAmount!);
                      expenseDate.add("12 Dec 2012");
                      Navigator.pop(context);
                      setState(() {});
                    }
                  },
                  context: context,
                  widgets: <Widget>[
                    Text(
                      "Add Expense",
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
                        newExpense = value;
                      },
                      hintText: "Petrol in Bike",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    KTextField(
                      onChanged: (value) {
                        newAmount = value;
                      },
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
                      // Image.asset(
                      //   "assets/icons/help_icon.png",
                      //   scale: 1.8,
                      // ),
                      hintText: "250",
                    )
                  ]);
            }),
      ]),
    );
  }
}
