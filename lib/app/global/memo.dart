import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;

class MemoHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''CREATE TABLE memo_test(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    content TEXT
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)
    ''');
  }

  static Future<sql.Database> db() async {
    print('create tables');
    return sql.openDatabase('memo_test.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createItem(String content) async {
    final db = await MemoHelper.db();

    final data = {'content': content};
    final id = await db.insert(
      'memo_test',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await MemoHelper.db();
    return db.query('memo_test', orderBy: "id");
  }

  static Future<int> updateItem(int id, String content) async {
    final db = await MemoHelper.db();

    final data = {
      'content': content,
      'createdAt': DateTime.now().toString(),
    };
    final result = await db.update(
      'memo_test',
      data,
      where: "id = ?",
      whereArgs: [id],
    );
    return result;
  }

  static Future<void> deleteItem(int id) async{
    final db = await MemoHelper.db();
    try{
      await db.delete("memo_test", where: "id = ?",whereArgs: [id],);
    }catch(err){
      debugPrint(err.toString());
    }
  }
}
