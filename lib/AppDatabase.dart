import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'Shopping_listDAO.dart';
import 'SLE.dart';


part 'AppDatabase.g.dart'; // the generated code will be there

@Database(version: 1, entities: [SLE])
abstract class AppDatabase extends FloorDatabase {
  Shopping_listDAO get shopping_listDAO;
}