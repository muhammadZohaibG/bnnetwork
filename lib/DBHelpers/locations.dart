// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:b_networks/DBHelpers/b_network_db.dart';
import 'package:b_networks/models/location_model.dart';
import 'package:sqflite/sqflite.dart';

class Locations {
  static Database? _db;
  static const String TABLE = 'Locations';
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String CREATEDAT = 'created_at';
  static const String UPDATEDAT = 'updated_at';

  Future getLocations() async {
    var dbClient = await DBHelper().db;
    var table = await dbClient!.query(
      TABLE,
      columns: [ID, NAME, CREATEDAT, UPDATEDAT],
      //where: "$CREATEDAT< '2023-01-30'"
    );
    if (table.isEmpty) {
      log('Location Not Found');
      return [];
    } else {
      return table;
    }
  }

  Future addLocation() async {
    var dbClient = await DBHelper().db;
    int? id = await dbClient!.transaction((txn) async {
      log('inserting');

      return await txn
          .rawInsert('''INSERT INTO $TABLE ($NAME, $CREATEDAT, $UPDATEDAT) 
          VALUES("Islamabad", "2023-01-31 11:30:13.426658","2023-01-31 11:30:13.426658")''');
    });
    log('Location saved');
    log('id is $id');
  }
}
