import 'dart:developer';

import 'package:b_networks/app%20components/KCalendarButton.dart';
import 'package:b_networks/app%20components/KExpenseLongCard.dart';
import 'package:b_networks/app%20components/KMainButton.dart';
import 'package:b_networks/app%20components/KUnderTopBar.dart';
import 'package:b_networks/app%20components/app_components.dart';
import 'package:b_networks/views/ExpensesPage/components/expenses_topbar.dart';
import 'package:b_networks/views/ExpensesPage/provider/expenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/KColors.dart';
import '../../../app components/KDialogBox.dart';
import '../../../app components/KTextField.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  @override
  void initState() {
    function();
    super.initState();
  }

  function() async {
    final expenseProvider =
        Provider.of<ExpensesProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await expenseProvider.getExpenses();
    });
  }

  KDialogBox kDialogBox = KDialogBox();
  String searchFilter = "";
  List<String> expenseTitle = [
    "Petrol in bike",
    "Cash spent on disloyal friends"
  ];

  List<String> expenseAmount = ["650", "100,000"];

  List<String> expenseDate = ["25 Dec 2022", "17 Jan 2023"];

  String? newExpense;
  String? newAmount;

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    KColors kColors = KColors();
    return Scaffold(
      backgroundColor: kColors.screenBG,
      body: Consumer<ExpensesProvider>(
        builder: (context, expenseProvider, child) => Column(children: [
          const Padding(
              padding: EdgeInsets.only(bottom: 10), child: ExpensesTopBar()),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KUnderTopBar(
                        leftText: "Expenses List",
                        rightWidget: const KCalendarButton()),
                    const SizedBox(height: 10),
                    KTextField(
                        controller: expenseProvider.expenseSearchController,
                        onChanged: (value) {
                          searchFilter = value;
                          setState(() {});
                          expenseProvider.searchExpense();
                        },
                        color: Colors.white,
                        hintText: "Search by Expense",
                        suffix: SizedBox(
                            height: 55,
                            width: 65,
                            child: Center(
                                child:
                                    Image.asset("assets/icons/search.png")))),
                    expenseProvider.isLoading
                        ? AppComponents().shimmerList(context,
                            itemCount: 5,
                            child: KExpenseLongCard(
                                onPress: () {},
                                mainTitle: '',
                                description: '',
                                date: ''))
                        : expenseProvider.expensesList!.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('No Expenses To Show',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: KColors().darkGrey,
                                              fontWeight: FontWeight.w500))
                                    ]))
                            : expenseProvider
                                    .expenseSearchController.value.text.isEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(top: 10),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        expenseProvider.expensesList!.length,
                                    itemBuilder: (context, i) {
                                      return Builder(builder: (context) {
                                        return Column(children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0),
                                              child: KExpenseLongCard(
                                                  onPress: () {},
                                                  mainTitle: expenseProvider
                                                      .expensesList![i].title!
                                                      .toString(),
                                                  description: expenseProvider
                                                      .expensesList![i].amount!
                                                      .toString(),
                                                  date: DateFormat('d MMMM y')
                                                      .format(expenseProvider
                                                          .expensesList![i]
                                                          .createdAt!
                                                          .toLocal())))
                                        ]);
                                      });
                                    },
                                  )
                                : expenseProvider.searchExpenseList!.isEmpty
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('Not Found!',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: KColors().darkGrey,
                                                      fontWeight:
                                                          FontWeight.w500))
                                            ]))
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.only(top: 10),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: expenseProvider
                                            .searchExpenseList!.length,
                                        itemBuilder: (context, i) {
                                          return Builder(builder: (context) {
                                            return Column(children: [
                                              Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10.0),
                                                  child: KExpenseLongCard(
                                                      onPress: () {},
                                                      mainTitle: expenseProvider
                                                          .searchExpenseList![i]
                                                          .title!,
                                                      description: expenseProvider
                                                          .searchExpenseList![i]
                                                          .amount!
                                                          .toString(),
                                                      date: DateFormat(
                                                              'd MMMM y')
                                                          .format(expenseProvider
                                                              .searchExpenseList![
                                                                  i]
                                                              .createdAt!
                                                              .toLocal())))
                                            ]);
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
            onPressed: () async {
              kDialogBox.showDialogBox(
                  dialogBoxHeight: 270,
                  buttonText: "Add Expense",
                  onButtonPress: () async {
                    if (formKey.currentState!.validate()) {
                      log(DateFormat('y').format(DateTime.now()));
                      bool? res = await expenseProvider.addExpenseInDb();
                      if (res) {
                        if (!mounted) return;
                        Navigator.of(context).pop();
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
                            controller: expenseProvider.expenseTitleController,
                            onChanged: (value) {
                              newExpense = value;
                            },
                            validator: (v) {
                              if (v!.isEmpty) {
                                return 'Enter title';
                              }
                              return null;
                            },
                            hintText: "Title",
                          ),
                          const SizedBox(height: 20),
                          KTextField(
                            controller: expenseProvider.expenseAmountController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              newAmount = value;
                            },
                            validator: (v) {
                              if (v!.isEmpty) {
                                return 'Enter Amount';
                              } else if ( //(int.parse(v) % 1) != 0 ||
                                  int.parse(v) == 0) {
                                return 'Enter valid amount';
                              }
                              return null;
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
                        ],
                      ),
                    )
                  ]);
            },
          ),
        ]),
      ),
    );
  }
}
