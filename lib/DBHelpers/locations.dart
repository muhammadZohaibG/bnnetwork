// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:b_networks/DBHelpers/b_network_db.dart';
import 'package:b_networks/DBHelpers/connections.dart';
import 'package:b_networks/models/location_model.dart';
import 'package:sqflite/sqflite.dart';

class Locations {
  static Database? _db;
  static const String TABLE = 'Locations';
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String ISSYNCHRONIZED = 'is_synchronized';
  static const String CREATEDAT = 'created_at';
  static const String UPDATEDAT = 'updated_at';

  Future getLocations() async {
    var dbClient = await DBHelper().db;
    var table = await dbClient!.query(
      TABLE,
      columns: [ID, NAME, ISSYNCHRONIZED, CREATEDAT, UPDATEDAT],
      //where: "$CREATEDAT< '2023-01-30'"
    );

    List<Map<String, dynamic>> map = [];

    if (table.isEmpty) {
      log('Location Not Found');
    }
    //map = table;
    if (table.isNotEmpty) {
      for (int i = 0; i < table.length; i++) {
        var count = await dbClient.rawQuery(
            ''' Select Count (*) as active_connections from ${Connections.TABLE} where 
            ${Connections.LOCATIONID} == ${table[i][ID]} and ${Connections.ISACTIVE} == 1
            ''');

        List<Map<String, dynamic>>? mapItem = [];
        mapItem.add({
          ID: table[i][ID],
          NAME: table[i][NAME],
          'active_connections': count[0]["active_connections"],
          CREATEDAT: table[i][CREATEDAT],
          UPDATEDAT: table[i][UPDATEDAT],
        });

        map.add(mapItem[0]);
      }
    }
    log(map.toList().toString());

    return map;
  }

  Future addLocation(LocationModel location) async {
    var dbClient = await DBHelper().db;
    int? id = await dbClient!.transaction((txn) async {
      log('inserting');

      return await txn
          .rawInsert('''INSERT INTO $TABLE ($NAME, $CREATEDAT, $UPDATEDAT) 
          VALUES("${location.name}", "${location.createdAt}","${location.updatedAt}")''');
    });
    if (id != 0) {
      log('Location saved');
      log('id is $id');
      return id;
    }
    return id;
  }

  Future getUnSynchronized() async {
    var dbClient = await DBHelper().db;
    var table = await dbClient!
        .rawQuery('Select * from $TABLE where $ISSYNCHRONIZED = 0');
    if (table.isEmpty) {
      log('Locations Not Found');
    }

    return table;
  }

  Future<int> delete(int? id) async {
    var dbClient = await DBHelper().db;
    return await dbClient!.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }
}
