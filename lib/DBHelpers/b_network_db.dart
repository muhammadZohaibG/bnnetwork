// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:developer';
import 'dart:io' as io;
import 'package:b_networks/DBHelpers/bills.dart';
import 'package:b_networks/DBHelpers/connections.dart';
import 'package:b_networks/DBHelpers/locations.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:b_networks/DBHelpers/expenses.dart';

class DBHelper {
  static Database? _db;
  static const String DB_NAME = 'b_networks.db';
  static const _databaseVersion = 1;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(
      path,
      version: _databaseVersion, onCreate: _onCreate, // onUpgrade: _onUpgrade
    );
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE ${Locations.TABLE} 
        (${Locations.ID} INTEGER PRIMARY KEY NOT NULL, 
        ${Locations.NAME} TEXT NOT NULL, 
        ${Locations.CREATEDAT} TEXT NOT NULL, 
        ${Locations.UPDATEDAT} TEXT NOT NULL)''');

    await db.execute('''CREATE TABLE ${Expenses.TABLE} 
        (${Expenses.ID} INTEGER PRIMARY KEY NOT NULL, 
        ${Expenses.TITLE} TEXT NOT NULL, 
        ${Expenses.AMOUNT} INTEGER NOT NULL, 
        ${Expenses.MONTH} TEXT NOT NULL, 
        ${Expenses.YEAR} TEXT NOT NULL, 
        ${Expenses.CREATEDAT} TEXT NOT NULL, 
        ${Expenses.UPDATEDAT} TEXT NOT NULL)''');

    await db.execute('''CREATE TABLE ${Connections.TABLE} 
        (${Connections.ID} INTEGER PRIMARY KEY NOT NULL, 
        ${Connections.LOCATIONID} INTEGER NOT NULL, 
        ${Connections.FULLNAME} TEXT NOT NULL, 
        ${Connections.ADDRESS} TEXT NOT NULL, 
        ${Connections.MOBILE} TEXT NOT NULL, 
        ${Connections.ISACTIVE} INTEGER DEFAULT 1, 
        ${Connections.CREATEDAT} TEXT NOT NULL, 
        ${Connections.UPDATEDAT} TEXT NOT NULL,
        FOREIGN KEY (${Connections.LOCATIONID}) REFERENCES ${Locations.TABLE} (id) ON DELETE NO ACTION ON UPDATE NO ACTION)''');

    await db.execute('''CREATE TABLE ${Bills.TABLE}
        (${Bills.ID} INTEGER PRIMARY KEY NOT NULL, 
         ${Bills.LOCATIONID} INTEGER NOT NULL, 
         ${Bills.CONNECTIONID} INTEGER NOT NULL, 
         ${Bills.AMOUNT} INTEGER NOT NULL, 
         ${Bills.MONTH} TEXT NOT NULL, 
         ${Bills.YEAR} TEXT NOT NULL, 
         ${Bills.STATUS} TEXT DEFAULT Pending, 
         ${Bills.CREATEDAT} TEXT NOT NULL, 
         ${Bills.UPDATEDAT} TEXT NOT NULL, 
         FOREIGN KEY (${Bills.LOCATIONID}) REFERENCES ${Locations.TABLE}(id) ON DELETE NO ACTION ON UPDATE NO ACTION, 
         FOREIGN KEY (${Bills.CONNECTIONID}) REFERENCES ${Connections.TABLE} (id) ON DELETE NO ACTION ON UPDATE NO ACTION)''');

    log('DB Created');
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute(
          'CREATE TABLE ${Connections.TABLE} (${Connections.ID} INTEGER PRIMARY KEY NOT NULL, ${Connections.LOCATIONID} INTEGER NOT NULL, ${Connections.FULLNAME} TEXT NOT NULL, ${Connections.ADDRESS} TEXT NOT NULL, ${Connections.MOBILE} TEXT NOT NULL, ${Connections.ISACTIVE} INTEGER DEFAULT 1, ${Connections.CREATEDAT} TEXT NOT NULL, ${Connections.UPDATEDAT} TEXT NOT NULL FOREIGN KEY (${Connections.LOCATIONID}) REFERENCES ${Locations.TABLE} (id))');
    }
    log('Connection Table created');
  }
}
