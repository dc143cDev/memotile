import 'dart:core';
import 'dart:ui';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String tableMemo = 'memo';
final String columnId = '_id';
final String columnContent = 'content';
final String columnColor = 'color';

class MemoProvider {
  static Database? db;

  Future<Database?> get database async {
    if (db == null) {
      db = await initDB();
    }
    return db;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'memo.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
      create table $tableMemo ($columnId integer primary key autoincrement, $columnContent text not null, $columnColor integer not null)
      ''');
      },
    );
  }

  Future<Memo> insert(Memo memo) async {
    final db = await database;
    print(memo.toMap());
    memo.id = (await db?.insert(tableMemo, memo.toMap()))!;
    return memo;
  }
}

class Memo {
  int? id;
  String? content;
  // DateTime date_created;
  // DateTime date_last_edited;
  Color? color;
  // int is_archived = 0;

  Memo({
    this.id,
    this.content,
    // this.date_created,
    // this.date_last_edited,
    this.color,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      //id 는 auto increment 로 입력.
      columnContent: content,
      // 'date_created': epochFromDate(date_created),
      // 'date_last_edited': epochFromDate(date_last_edited),
      columnColor: color?.value,
      // 'is_archived': is_archived
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Memo.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    content = map[columnContent];
    color = map[columnColor];
  }

  int epochFromDate(DateTime dt) {
    return dt.microsecondsSinceEpoch ~/ 1000;
  }
}
