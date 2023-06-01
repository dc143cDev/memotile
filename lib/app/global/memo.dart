import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class MemoHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''CREATE TABLE memo_test8(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    content TEXT,
    dateData TEXT,
    createdAt TEXT,
    colorValue INTEGER,
    bool isColorChanged)
    ''');
  }

  static Future<sql.Database> db() async {
    //debug
    print('create tables');
    return sql.openDatabase('memo_test8.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createItem(
      String content, String createdAt, String date, int color) async {
    final db = await MemoHelper.db();

    final data = {
      'content': content,
      'createdAt': createdAt,
      'dateData': date,
      'colorValue': color
    };
    final id = await db.insert(
      'memo_test8',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    print('id: ${id.toString()}');

    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await MemoHelper.db();
    return db.query('memo_test8', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await MemoHelper.db();
    return db.query('memo_test8', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getItemsByDate(String date) async{
    final db = await MemoHelper.db();
    print(date);
    return db.query('memo_test8', orderBy: "createdAt", whereArgs: [date], where: "createdAt = $date");

  }

  static Future<List<Map<String, dynamic>>> getItemsByColor(int color) async{
    final db = await MemoHelper.db();
    return db.query('memo_test8', orderBy: "colorValue", whereArgs: [color], where: "colorValue = $color");
  }

  static Future<int> updateItem(
      int id, String content, String date, int color) async {
    final db = await MemoHelper.db();

    final data = {
      'content': content,
      'dateData': date,
      'colorValue': color,
    };
    final result = await db.update(
      'memo_test8',
      data,
      where: "id = ?",
      whereArgs: [id],
    );
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await MemoHelper.db();
    try {
      await db.delete(
        "memo_test8",
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
