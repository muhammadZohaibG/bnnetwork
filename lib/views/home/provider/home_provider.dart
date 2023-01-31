import 'dart:developer';

import 'package:b_networks/models/location_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../DBHelpers/locations.dart';

class HomeProvider extends ChangeNotifier {
  var locationDb = Locations();
  bool? isLoading = false;
  List<LocationModel>? locations = [];

  updateLoader(bool value) {
    isLoading = value;
    notifyListeners();
  }

  addLocation(LocationModel? location) {
    locations!.add(location!);
    notifyListeners();
  }

  Future getLocations() async {
    try {
      updateLoader(true);
      List<Map<String, dynamic>> maps = await locationDb.getLocations();

      if (maps.isNotEmpty) {
        for (int i = 0; i < maps.length; i++) {
          addLocation(LocationModel.fromJson(maps[i]));
        }
      }
      updateLoader(false);
    } catch (e) {
      log(e.toString());
    }
  }
}
