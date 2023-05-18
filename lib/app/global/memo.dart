import 'package:flutter/cupertino.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';
import 'package:sqflite/sqflite.dart' as sql;

class MemoHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''CREATE TABLE memo_test3(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    content TEXT,
    createdAt TEXT)
    ''');
  }

  static Future<sql.Database> db() async {
    print('create tables');
    return sql.openDatabase('memo_test3.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createItem(String content, String date) async {
    final db = await MemoHelper.db();

    final data = {'content': content, 'createdAt' : date};
    final id = await db.insert(
      'memo_test3',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await MemoHelper.db();
    return db.query('memo_test3', orderBy: "id");
  }

  static Future<int> updateItem(int id, String content) async {
    final db = await MemoHelper.db();

    final data = {
      'content': content,
      'createdAt': HomeController().CurrentDate.value.toString(),
    };
    final result = await db.update(
      'memo_test3',
      data,
      where: "id = ?",
      whereArgs: [id],
    );
    return result;
  }

  static Future<void> deleteItem(int id) async{
    final db = await MemoHelper.db();
    try{
      await db.delete("memo_test3", where: "id = ?",whereArgs: [id],);
    }catch(err){
      debugPrint(err.toString());
    }
  }
}
