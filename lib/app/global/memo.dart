import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';
import 'package:sqflite/sqflite.dart' as sql;

class MemoHelper {

  static Future<void> createTables(sql.Database database) async {
    await database.execute('''CREATE TABLE memo_test4(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    content TEXT,
    createdAt TEXT,
    colorValue INTEGER)
    ''');
  }

  static Future<sql.Database> db() async {
    print('create tables');
    return sql.openDatabase('memo_test4.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createItem(String content, String date, int color) async {
    final db = await MemoHelper.db();

    final data = {'content': content, 'createdAt' : date, 'colorValue' : color};
    final id = await db.insert(
      'memo_test4',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await MemoHelper.db();
    return db.query('memo_test4', orderBy: "id");
  }

  static Future<int> updateItem(int id, String content, int color) async {
    final db = await MemoHelper.db();

    final data = {
      'content': content,
      'createdAt': HomeController().CurrentDate.value.toString(),
      'colorValue' : HomeController().whiteValue,
    };
    final result = await db.update(
      'memo_test4',
      data,
      where: "id = ?",
      whereArgs: [id],
    );
    return result;
  }

  static Future<void> deleteItem(int id) async{
    final db = await MemoHelper.db();
    try{
      await db.delete("memo_test4", where: "id = ?",whereArgs: [id],);
    }catch(err){
      debugPrint(err.toString());
    }
  }
}