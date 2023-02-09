import 'dart:developer';

import 'package:b_networks/DBHelpers/bills.dart';
import 'package:b_networks/DBHelpers/connections.dart';
import 'package:b_networks/models/connection_model.dart';
import 'package:b_networks/models/location_connections_with_payment_model.dart';
import 'package:b_networks/utils/KColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/const.dart';

class CityDetailProvider extends ChangeNotifier {
  bool? isLoading = false;
  var connectionsDb = Connections();
  var billsDb = Bills();
  List<LocationConnectionsWithPaymentModel> connectionsList = [];
  List<LocationConnectionsWithPaymentModel> paidConnectionsList = [];
  List<LocationConnectionsWithPaymentModel> pendingConnectionsList = [];
  List<LocationConnectionsWithPaymentModel> searchedConnectionsList = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController locationTextFieldController = TextEditingController();
  TextEditingController mobileFieldController = TextEditingController();
  TextEditingController searchConnectionController = TextEditingController();
  String currentMonth = DateFormat('MMMM').format(DateTime.now());
  String currentYear = DateFormat('y').format(DateTime.now());

  int? locationActiveConnections = 0;
  int? locationPendingConnections = 0;
  int? totalEarningOfLocationInMonth = 0;

  updateLoader(bool value) {
    isLoading = value;
    notifyListeners();
  }

  updateTotalEarningOfLocation(int value) {
    totalEarningOfLocationInMonth = value;
    notifyListeners();
  }

  updateLocationActiveConnections(int? value) {
    locationActiveConnections = value;
    notifyListeners();
  }

  updateLocationPendingConnections(int? value) {
    locationPendingConnections = value;
    notifyListeners();
  }

  addInConnectionsList(LocationConnectionsWithPaymentModel newC) {
    connectionsList.add(newC);
    notifyListeners();
  }

  addInPaidConnectionsList(LocationConnectionsWithPaymentModel newC) {
    paidConnectionsList.add(newC);
    notifyListeners();
  }

  addInSearchConnectionsList(LocationConnectionsWithPaymentModel newC) {
    searchedConnectionsList.add(newC);
    notifyListeners();
  }

  insertAtConnectionsList(LocationConnectionsWithPaymentModel newC) {
    connectionsList.insert(0, newC);
    notifyListeners();
  }

  emptyConnectionList() {
    connectionsList = [];
    notifyListeners();
  }

  emptyPaidConnectionList() {
    paidConnectionsList = [];
    notifyListeners();
  }

  emptySearchConnectionList() {
    searchedConnectionsList = [];
    notifyListeners();
  }

  searchConnection() {
    emptySearchConnectionList();
    for (var e in connectionsList) {
      if (e.fullName!.toLowerCase().startsWith(
          searchConnectionController.value.text.trim().toLowerCase())) {
        addInSearchConnectionsList(e);
      }
    }
  }

  Future getAllConnectionsOfLocation({required int? locationId}) async {
    try {
      emptyConnectionList();
      updateLoader(true);
      await Future.delayed(const Duration(seconds: 1));
      List<Map<String, dynamic>> maps = await connectionsDb.getConnections(
              locationId: locationId, month: currentMonth, year: currentYear) ??
          [];
      if (maps.isNotEmpty) {
        for (int i = 0; i < maps.length; i++) {
          addInConnectionsList(
              LocationConnectionsWithPaymentModel.fromJson(maps[i]));
        }
      }
      updateLoader(false);
    } catch (e) {
      log(e.toString());
    }
  }

  Future getPaidConnections({required int? locationId}) async {
    try {
      emptyPaidConnectionList();
      updateLoader(true);
      await Future.delayed(const Duration(seconds: 1));
      List<Map<String, dynamic>> maps = await connectionsDb.getConnections(
              locationId: locationId, month: currentMonth, year: currentYear) ??
          [];
      if (maps.isNotEmpty) {
        for (int i = 0; i < maps.length; i++) {
          addInConnectionsList(
              LocationConnectionsWithPaymentModel.fromJson(maps[i]));
        }
      }
      updateLoader(false);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool> addConnection({required int? locationid}) async {
    try {
      ConnectionModel connection = ConnectionModel()
        ..locationId = locationid
        ..fullName = nameController.value.text.trim()
        ..address = locationTextFieldController.text.isEmpty
            ? ''
            : locationTextFieldController.value.text.trim()
        ..mobile = mobileFieldController.text.isEmpty
            ? ''
            : mobileFieldController.value.text.trim()
        ..createdAt =
            DateTime.parse(DateFormat(dateFormat).format(DateTime.now()))
        ..updatedAt =
            DateTime.parse(DateFormat(dateFormat).format(DateTime.now()));
      int? id = await connectionsDb.addConnection(connection: connection);
      if (id == 0) {
        showToast('Failed!');
        return false;
      } else {
        showToast('Added', backgroundColor: primaryColor);
        mobileFieldController.clear();
        locationTextFieldController.clear();
        nameController.clear();
        getAllConnectionsOfLocation(locationId: locationid);
        getLocationConnectionsStats(locationId: locationid!);

        return true;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future getLocationConnectionsStats({required int locationId}) async {
    try {
      log(locationId.toString());
      int? totalEarning = await billsDb.totalLocationEarningOfMonth(
          month: currentMonth, year: currentYear, locationId: locationId);
      log('total Earning of LocationID $locationId this month is = $totalEarning');
      updateTotalEarningOfLocation(totalEarning!);
      int? totalActive = await connectionsDb.countActiveConnectionsOfLocation(
          locationId: locationId);
      log('total location active connections $totalActive');
      updateLocationActiveConnections(totalActive);
      int? totalPaidConnections = await billsDb.totalPaidConnectionsOfLocation(
          month: currentMonth, year: currentYear, locationId: locationId);
      int? totalPending = totalActive! - totalPaidConnections!;
      log('total pending location active connections $totalPending');
      updateLocationPendingConnections(totalPending);
    } catch (e) {
      log(e.toString());
    }
  }
}
