import 'dart:developer';

import 'package:b_networks/DBHelpers/connections.dart';
import 'package:b_networks/models/connection_model.dart';
import 'package:flutter/cupertino.dart';

class CityDetailProvider extends ChangeNotifier {
  bool? isLoading = false;
  var connectionsDb = Connections();
  List<ConnectionModel> connectionsList = [];

  updateLoader(bool value) {
    isLoading = value;
    notifyListeners();
  }

  addInConnectionsList(ConnectionModel newC) {
    connectionsList.add(newC);
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

  Future getConnections() async {
    try {
      emptyConnectionList();
      updateLoader(true);
      await Future.delayed(const Duration(seconds: 2));
      List<Map<String, dynamic>> maps = await connectionsDb.getConnections();
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
}
