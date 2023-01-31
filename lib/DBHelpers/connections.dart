// ignore_for_file: constant_identifier_names

import 'dart:developer';

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

  Future getConnections() async {
    var dbClient = await DBHelper().db;
    var table = await dbClient!.query(TABLE,
        columns: [
          ID,
          LOCATIONID,
          FULLNAME,
          ADDRESS,
          ISACTIVE,
          MOBILE,
          CREATEDAT,
          UPDATEDAT
        ],
        where: "$ISACTIVE == 1");
    if (table.isEmpty) {
      log('Connection Not Found');
    } else {
      List<Map<String, dynamic>> maps = table;
      log(maps.toString());
    }
  }

  Future addConnection() async {
    var dbClient = await DBHelper().db;
    int? id = await dbClient!.transaction((txn) async {
      log('inserting');

      return await txn.rawInsert(
          '''INSERT INTO $TABLE ($FULLNAME,$LOCATIONID, $ADDRESS, $MOBILE,  $CREATEDAT, $UPDATEDAT) 
          VALUES("Talha",1 , "House # 111, st# 3, Islamabad", "03211234567","2023-01-31 11:30:13.426658","2023-01-31 11:30:13.426658")''');
    });
    log('Connection saved');
    log('new connection id is $id');
  }
}
