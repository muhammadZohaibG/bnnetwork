import 'dart:developer';

import 'package:b_networks/DBHelpers/connections.dart';
import 'package:b_networks/models/connection_model.dart';
import 'package:b_networks/utils/KColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/const.dart';

class CityDetailProvider extends ChangeNotifier {
  bool? isLoading = false;
  var connectionsDb = Connections();
  List<ConnectionModel> connectionsList = [];
  List<ConnectionModel> paidConnectionsList = [];
  List<ConnectionModel> pendingConnectionsList = [];
  List<ConnectionModel> searchedConnectionsList = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController locationTextFieldController = TextEditingController();
  TextEditingController mobileFieldController = TextEditingController();
  TextEditingController searchConnectionController = TextEditingController();
  String currentMonth = DateFormat('MMMM').format(DateTime.now());
  String currentYear = DateFormat('y').format(DateTime.now());

  updateLoader(bool value) {
    isLoading = value;
    notifyListeners();
  }

  addInConnectionsList(ConnectionModel newC) {
    connectionsList.add(newC);
    notifyListeners();
  }

  addInPaidConnectionsList(ConnectionModel newC) {
    paidConnectionsList.add(newC);
    notifyListeners();
  }

  addInSearchConnectionsList(ConnectionModel newC) {
    searchedConnectionsList.add(newC);
    notifyListeners();
  }

  insertAtConnectionsList(ConnectionModel newC) {
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

  Future getAllConnections({required int? locationId}) async {
    try {
      emptyConnectionList();
      updateLoader(true);
      await Future.delayed(const Duration(seconds: 1));
      List<Map<String, dynamic>> maps = await connectionsDb.getConnections(
              locationId: locationId, month: currentMonth, year: currentYear) ??
          [];
      if (maps.isNotEmpty) {
        for (int i = 0; i < maps.length; i++) {
          addInConnectionsList(ConnectionModel.fromJson(maps[i]));
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
          addInConnectionsList(ConnectionModel.fromJson(maps[i]));
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
      int? id = await connectionsDb.addConnection(connection);
      if (id == 0) {
        showToast('Failed!');
        return false;
      } else {
        showToast('Added', backgroundColor: primaryColor);
        mobileFieldController.clear();
        locationTextFieldController.clear();
        nameController.clear();
        getAllConnections(locationId: locationid);

        return true;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
