import 'dart:developer';

import 'package:b_networks/DBHelpers/b_network_db.dart';
import 'package:b_networks/DBHelpers/bills.dart';
import 'package:b_networks/DBHelpers/connections.dart';
import 'package:b_networks/DBHelpers/expenses.dart';
import 'package:b_networks/DBHelpers/locations.dart';
import 'package:b_networks/views/home/components/components.dart';
import 'package:b_networks/views/home/components/home_page_topbar.dart';
import 'package:b_networks/app%20components/KCalendarButton.dart';
import 'package:b_networks/app%20components/KDialogBox.dart';
import 'package:b_networks/app%20components/KMainButton.dart';
import 'package:b_networks/app%20components/KStatsCards.dart';
import 'package:b_networks/app%20components/KTextField.dart';
import 'package:b_networks/app%20components/KUnderTopBar.dart';
import 'package:b_networks/views/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/KColors.dart';
import '../../../app components/kCityLongCard.dart';
import '../../city_details/screen/city_details_screen.dart';
import '../../expense/view/expenses_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textFieldController = TextEditingController();
  var dbHelper = DBHelper();
  var locations = Locations();
  var expenses = Expenses();
  var connections = Connections();
  var bill = Bills();
  List<String> cityNames = [
    "Lahore",
    "Islamabad",
    "Multan",
    "Peshawar",
    "Mian Wali",
    "Kiranchi",
    "Gujranwala",
    "Sialkot",
  ];

  List<int> cityActiveUsers = [30, 20, 14, 67, 87, 45, 98, 31];

  List<String> cityDescription = [
    "Lahore description",
    "Islamabad description",
    "Multan description",
    "Peshawar description",
    "Mian Wali description",
    "Kiranchi description",
    "Gujranwala description",
    "Sialkot description",
  ];

  String? newCity;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    function();
  }

  function() async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    await Future.delayed(const Duration(seconds: 2));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // homeProvider.totalExpenseStream = homeProvider.calculateExpenses();
      // await homeProvider.calculateExpenses();
      await homeProvider.getLocations();
      // await homeProvider.calculateTotalEarnings();
      // await homeProvider.getConnectionsStats();
      await getOverallStats();
    });

    //await locations.getLocations();
  }

  getOverallStats() async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // homeProvider.totalExpenseStream = homeProvider.calculateExpenses();
      await homeProvider.calculateExpenses();

      await homeProvider.calculateTotalEarnings();
      await homeProvider.getConnectionsStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: KColors().screenBG,
        body: Consumer<HomeProvider>(builder: (context, homeProvider, child) {
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: HomePageTopBar(),
              ),
              Expanded(
                  child: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                KUnderTopBar(
                                  leftText: "Overall Statistics",
                                  rightWidget: KCalendarButton(),
                                ),
                                const SizedBox(height: 20),
                                KStatsCards(
                                    totalEarning:
                                        homeProvider.totalEarnings!, //75000,
                                    totalExpense: homeProvider.totalExpenses!,
                                    earningOnTap: () {
                                      Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ExpensesPage()))
                                          .then((value) => getOverallStats());
                                    }),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    getOverallStats();
                                  },
                                  child: Text("Connections",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: KColors().darkGrey,
                                          fontWeight: FontWeight.w500)),
                                ),
                                const SizedBox(height: 10),
                                HomeScreenComponents().connectionsStatsRow(
                                    totalConnections:
                                        homeProvider.totalActiveConnections!,
                                    totalUnpaidConnections: homeProvider
                                        .totalPendingPaymentConnections!),
                                const SizedBox(height: 20),
                                InkWell(
                                  onTap: () {
                                    getOverallStats();
                                  },
                                  child: Text(
                                    "Service Locations",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: KColors().darkGrey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                homeProvider.isLoading!
                                    ? HomeScreenComponents()
                                        .shimmerList(context)
                                    : homeProvider.locations!.isEmpty
                                        ? Center(
                                            child: Text(
                                              'No Locations To Show',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: KColors().darkGrey,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.all(0),
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount:
                                                homeProvider.locations!.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => CityDetailsPage(
                                                                cityName: homeProvider
                                                                    .locations![
                                                                        index]
                                                                    .name!
                                                                    .toString(),
                                                                locationId: homeProvider
                                                                    .locations![
                                                                        index]
                                                                    .id))).then(
                                                        (value) =>
                                                            getOverallStats());
                                                  },
                                                  child: KCityLongCard(
                                                      activeUsers: homeProvider
                                                          .locations![index]
                                                          .activeConnections!, //cityActiveUsers[i],
                                                      cityName: homeProvider
                                                          .locations![index]
                                                          .name!
                                                          .toString(),
                                                      locationId: homeProvider
                                                          .locations![index]
                                                          .id),
                                                ),
                                              );
                                            })
                              ])))),
              KMainButton(
                  text: "Add Service Area",
                  onPressed: () async {
                    // homeProvider.getLocations();
                    KDialogBox().showDialogBox(
                        dialogBoxHeight: 154,
                        buttonText: "Add new",
                        onButtonPress: () async {
                          if (formKey.currentState!.validate()) {
                            bool res = await homeProvider.addLocationInDB();
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
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Enter location name to add",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: KColors().statsUnderText,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(height: 20),
                                KTextField(
                                    controller:
                                        homeProvider.locationNameController,
                                    onChanged: (value) {
                                      newCity = value;
                                    },
                                    validator: (v) {
                                      if (v!.isEmpty) {
                                        return 'The field is required';
                                      }
                                      return null;
                                    },
                                    hintText: "Location Name")
                              ],
                            ),
                          ),
                        ]);
                  }),
            ],
          );
        }));
  }
}
