import 'dart:convert';

import 'package:sqflite/sqflite.dart';

class MoodDB {
  static final MoodDB _instance = MoodDB._internal();
  factory MoodDB() => _instance;
  MoodDB._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDB();
    return _db!;
  }

  initDB() async {
    return await openDatabase('mood.db', version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE mood (
        id INTEGER PRIMARY KEY,
        date TEXT,
        record TEXT
      )
    ''');
  }

  Future<int> insertMood(List<Map<String, dynamic>> row, String date) async {
    Database dbClient = await db;
    return await dbClient.insert('mood', {'date': date, 'record': json.encode(row)});
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database dbClient = await db;
    return await dbClient.query('mood');
  }

  Future<int?> queryRowCount() async {
    Database dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM mood'));
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database dbClient = await db;
    int id = row['id'];
    return await dbClient.update('mood', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database dbClient = await db;
    return await dbClient.delete('mood', where: 'id = ?', whereArgs: [id]);
  }
}
