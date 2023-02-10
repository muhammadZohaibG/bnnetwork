import 'dart:developer';

import 'package:b_networks/utils/const.dart';
import 'package:b_networks/views/city_details/components/city_details_filter.dart';
import 'package:b_networks/views/city_details/components/city_details_topbar.dart';
import 'package:b_networks/app%20components/KCalendarButton.dart';
import 'package:b_networks/app%20components/KMainButton.dart';
import 'package:b_networks/app%20components/KUnderTopBar.dart';
import 'package:b_networks/app%20components/KLongCustomCard.dart';
import 'package:b_networks/views/city_details/components/components.dart';
import 'package:b_networks/views/city_details/provider/city_detail_provider.dart';
import 'package:b_networks/views/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app components/app_components.dart';
import '../../../utils/KColors.dart';
import '../../../app components/KDialogBox.dart';
import '../../../app components/KTextField.dart';
import '../../monthly_bill/screen/monthly_bill_list_screen.dart';

class CityDetailsPage extends StatefulWidget {
  String cityName;
  int? locationId;
  CityDetailsPage(
      {super.key, required this.cityName, required this.locationId});

  @override
  State<CityDetailsPage> createState() => _CityDetailsPageState();
}

class _CityDetailsPageState extends State<CityDetailsPage> {
  bool allSelected = true;
  bool paidSelected = false;
  bool pendingSelected = false;
  KDialogBox kDialogBox = KDialogBox();
  String filter = "";
  String searchFilter = "";

  String? newUser;
  String? newAddress;

  KColors kColors = KColors();
  final formKey = GlobalKey<FormState>();
  HomeProvider? _homeProvider;

  @override
  void initState() {
    function();
    super.initState();
  }

  function() async {
    final cityDetailProvider =
        Provider.of<CityDetailProvider>(context, listen: false);
    _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await cityDetailProvider.getAllConnectionsOfLocation(
          locationId: widget.locationId);
      await cityDetailProvider.getLocationConnectionsStats(
          locationId: widget.locationId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColors.screenBG,
      body: Consumer<CityDetailProvider>(
        builder: (context, cityDetailProvider, child) => Column(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CityDetailsTopBar(cityName: widget.cityName),
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
                    const SizedBox(height: 10),
                    CityDetailsScreenComponents().totalEarnings(
                        totalEarnings:
                            cityDetailProvider.totalEarningOfLocationInMonth!),
                    const SizedBox(height: 10),
                    AppComponents().connectionsStatsRow(
                        totalConnections:
                            cityDetailProvider.locationActiveConnections!,
                        totalUnpaidConnections:
                            cityDetailProvider.locationPendingConnections!),
                    const SizedBox(height: 10),
                    KTextField(
                        controller:
                            cityDetailProvider.searchConnectionController,
                        onChanged: (value) {
                          cityDetailProvider.searchConnection();
                        },
                        color: Colors.white,
                        hintText: "Search by user name",
                        suffix: SizedBox(
                            height: 55,
                            width: 65,
                            child: Center(
                                child: GestureDetector(
                                    onTap: () {
                                      log('message');
                                    },
                                    child: Image.asset(
                                        "assets/icons/search.png"))))),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CityDetailsFilter(
                          isSelected: cityDetailProvider.selectedList == all
                              ? true
                              : false,
                          text: all,
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            cityDetailProvider.searchConnectionController
                                .clear();
                            cityDetailProvider.getAllConnectionsOfLocation(
                                locationId: widget.locationId!);
                          },
                        ),
                        CityDetailsFilter(
                          isSelected: cityDetailProvider.selectedList == paid
                              ? true
                              : false,
                          text: paid,
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            cityDetailProvider.searchConnectionController
                                .clear();
                            cityDetailProvider.getPaidConnections();
                          },
                        ),
                        CityDetailsFilter(
                          isSelected: cityDetailProvider.selectedList == pending
                              ? true
                              : false,
                          text: pending,
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            cityDetailProvider.searchConnectionController
                                .clear();
                            cityDetailProvider.getPendingConnections();
                          },
                        ),
                      ],
                    ),
                    cityDetailProvider.isLoading!
                        ? AppComponents().shimmerList(context,
                            itemCount: 5,
                            child: KLongCustomCard(
                                onPress: () {},
                                mainTitle: '',
                                description: '',
                                billStatus: ''))
                        : cityDetailProvider.connectionsList.isEmpty
                            ? CityDetailsScreenComponents()
                                .noConnectionsToShow()
                            : cityDetailProvider.searchConnectionController
                                    .value.text.isEmpty
                                ? //show all connections
                                CityDetailsScreenComponents().connectionsList(
                                    connectionsList: cityDetailProvider
                                                .selectedList ==
                                            all
                                        ? cityDetailProvider.connectionsList
                                        : cityDetailProvider
                                                    .selectedList ==
                                                paid
                                            ? cityDetailProvider
                                                .paidConnectionsList
                                            : cityDetailProvider
                                                .pendingConnectionsList,
                                    onTap:
                                        () =>
                                            cityDetailProvider
                                                .getLocationConnectionsStats(
                                                    locationId: widget
                                                        .locationId!))
                                : //show searched connections
                                cityDetailProvider
                                        .searchedConnectionsList.isEmpty
                                    ? //if no connections by search
                                    CityDetailsScreenComponents()
                                        .noConnectionsToShow()
                                    : //show search connections
                                    CityDetailsScreenComponents()
                                        .connectionsList(
                                            connectionsList:
                                                cityDetailProvider
                                                    .searchedConnectionsList,
                                            onTap: () => cityDetailProvider
                                                .getLocationConnectionsStats(
                                                    locationId:
                                                        widget.locationId!))
                  ],
                ),
              ),
            ),
          ),
          KMainButton(
              text: "Add New User",
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                // cityDetailProvider.getPaidConnections(
                //     locationId: widget.locationId);
                showAddUserDialog();
              }),
        ]),
      ),
    );
  }

  showAddUserDialog() {
    final cityDetailProvider =
        Provider.of<CityDetailProvider>(context, listen: false);
    return kDialogBox.showDialogBox(
        dialogBoxHeight: 230,
        buttonText: "Add User",
        onButtonPress: () async {
          if (formKey.currentState!.validate()) {
            FocusScope.of(context).requestFocus(FocusNode());
            //
            bool? res = await cityDetailProvider.addConnection(
                locationid: widget.locationId);
            if (res) {
              if (!mounted) return;
              Navigator.of(context).pop();
              _homeProvider!
                  .increamentLocationActiveUsers(locationId: widget.locationId);
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
                  "Add user to ${widget.cityName}",
                  style: TextStyle(
                      fontSize: 18,
                      color: kColors.statsUnderText,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                KTextField(
                  controller: cityDetailProvider.nameController,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Enter name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    newUser = value;
                  },
                  hintText: "Full Name",
                ),
                const SizedBox(height: 20),
                KTextField(
                  controller: cityDetailProvider.locationTextFieldController,
                  keyboardType: TextInputType.streetAddress,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Enter address';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    newAddress = value;
                  },
                  hintText: "House No.",
                ),
                const SizedBox(height: 20),
                KTextField(
                  controller: cityDetailProvider.mobileFieldController,
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    // if (v!.isEmpty) {
                    //   return 'Enter mobile number';
                    // }
                    return null;
                  },
                  onChanged: (value) {
                    newAddress = value;
                  },
                  hintText: "Mobile",
                )
              ],
            ),
          ),
        ]);
  }
}
