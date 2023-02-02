// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:b_networks/models/connection_model.dart';
import 'package:sqflite/sqflite.dart';

import 'b_network_db.dart';

class Connections {
  static Database? _db;
  static const String TABLE = 'Connections';
  static const String ID = 'id';
  static const String FULLNAME = 'full_name';
  static const String LOCATIONID = 'location_id';
  static const String ADDRESS = 'address';
  static const String ISACTIVE = 'is_active';
  static const String MOBILE = 'mobile';
  static const String CREATEDAT = 'created_at';
  static const String UPDATEDAT = 'updated_at';

  Future getConnections({required int? locationId}) async {
    var dbClient = await DBHelper().db;
    // var tempTable = await dbClient!.rawQuery(''' Select  ''');
    var table = await dbClient!
        .rawQuery('''select * from $TABLE ORDER BY ($CREATEDAT) DESC''');
    // var table = await dbClient!.query(
    //   TABLE,
    //   columns: [
    //     ID,
    //     LOCATIONID,
    //     FULLNAME,
    //     ADDRESS,
    //     ISACTIVE,
    //     MOBILE,
    //     CREATEDAT,
    //     UPDATEDAT
    //   ],
    //   orderBy: CREATEDAT,
    //   where: "$ISACTIVE == 1 and $LOCATIONID == $locationId ",
    // );
    List<Map<String, dynamic>>? maps;
    if (table.isEmpty) {
      log('Connection Not Found');
      return maps;
    }

    return table;
  }

  Future addConnection(ConnectionModel connection) async {
    var dbClient = await DBHelper().db;
    int? id = await dbClient!.transaction((txn) async {
      log('inserting');

      return await txn.rawInsert(
          '''INSERT INTO $TABLE ($FULLNAME,$LOCATIONID, $ADDRESS, $MOBILE,  $CREATEDAT, $UPDATEDAT) 
          VALUES("${connection.fullName}",
          ${connection.locationId}, 
          "${connection.address}", "${connection.mobile}",
          "${connection.createdAt}","${connection.updatedAt}")''');
    });
    if (id != 0) {
      log('Connection saved');
      log('new connection id is $id');
    }
    return id;
  }
}
