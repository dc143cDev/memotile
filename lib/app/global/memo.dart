import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class MemoHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''CREATE TABLE memo_test22(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    content TEXT,
    dateData TEXT,
    createdAt TEXT,
    yyyy INTEGER,
    mm INTEGER,
    dd INTEGER,
    isFirst INTEGER,
    isEditChecked INTEGER,
    colorValue INTEGER)
    ''');
  }

  static Future<sql.Database> db() async {
    //debug
    print('create tables');
    return sql.openDatabase('memo_test22.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createItem(String content, String createdAt, String yyyy,
      String mm, String dd, int isFirst, String date, int color) async {
    final db = await MemoHelper.db();

    final data = {
      'content': content,
      'createdAt': createdAt,
      'yyyy': yyyy,
      'mm': mm,
      'dd': dd,
      'isFirst': isFirst,
      'dateData': date,
      'colorValue': color
    };
    final id = await db.insert(
      'memo_test22',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    print('id: ${id.toString()}');

    return id;
  }

  //get all items
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await MemoHelper.db();
    return db.query('memo_test22', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await MemoHelper.db();
    return db.query('memo_test22', where: "id = ?", whereArgs: [id], limit: 1);
  }

  //get all createdAt
  static Future<List<Map<String, dynamic>>> getItemsCreatedAt() async {
    final db = await MemoHelper.db();
    return db.query('memo_test22', orderBy: "id", columns: ['id', 'createdAt']);
  }

  static Future<List<Map<String, dynamic>>> getItemsByDate(String date) async {
    final db = await MemoHelper.db();
    return db.query('memo_test22',
        orderBy: "createdAt", whereArgs: [date], where: "createdAt = $date");
  }

  static Future<List<Map<String, dynamic>>> getItemsByEditModeCheck() async {
    final db = await MemoHelper.db();
    return db.query(
      'memo_test22',
      orderBy: "isEditChecked",
      where: "isEditChecked = 1",
      // columns: ['id', 'contents', 'isEditChecked'],
    );
  }

  //날짜를 기반으로 컬러 찾기.
  static Future<List<Map<String, dynamic>>> getItemsByDateToColor(
      String date) async {
    final db = await MemoHelper.db();
    // return db.rawQuery("SELECT * FROM memo_test20 WHERE createdAt LIKE '%${date}%'");
    return db.query(
      'memo_test22',
      orderBy: "createdAt",
      whereArgs: [date],
      where: "createdAt = $date",
      columns: ['createdAt', 'colorValue'],
    );
  }

  //날짜를 기반으로 컬러 찾기.
  //firstCheck 용.
  static Future<List<Map<String, dynamic>>> getItemsByDateToFirstCheck(
      String date) async {
    final db = await MemoHelper.db();
    // return db.rawQuery("SELECT * FROM memo_test20 WHERE createdAt LIKE '%${date}%'");
    return db.query(
      'memo_test22',
      orderBy: "createdAt",
      whereArgs: [date],
      where: "createdAt = $date",
      columns: ['id', 'createdAt', 'isFirst'],
    );
  }

  static Future<List<Map<String, dynamic>>> getItemsByDateMM(int mm) async {
    final db = await MemoHelper.db();
    return db.query(
      'memo_test22',
      orderBy: "mm",
      //event 필요한 columns 들만 가져오기.
      columns: ['createdAt', 'colorValue'],
    );
  }

  static Future<List<Map<String, dynamic>>> getItemsByColor(int color) async {
    final db = await MemoHelper.db();
    return db.query('memo_test22',
        orderBy: "colorValue",
        whereArgs: [color],
        where: "colorValue = $color");
  }

  static Future<List<Map<String, dynamic>>> getItemsByContent(
      String content) async {
    final db = await MemoHelper.db();
    return db.rawQuery(
        "SELECT * FROM memo_test22 WHERE content LIKE '%${content}%'");
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
      'memo_test22',
      data,
      where: "id = ?",
      whereArgs: [id],
    );
    return result;
  }

  static Future<int> updateItemForFirstCheck(int id, int isFirst) async {
    final db = await MemoHelper.db();

    final data = {
      'isFirst': isFirst,
    };
    final result = await db.update(
      'memo_test22',
      data,
      where: "id = ?",
      whereArgs: [id],
    );
    return result;
  }

  static Future<int> updateItemForEdit(int id, int isEditChecked) async {
    final db = await MemoHelper.db();

    final data = {
      'isEditChecked': isEditChecked,
    };
    final result = await db.update(
      'memo_test22',
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
        "memo_test22",
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
