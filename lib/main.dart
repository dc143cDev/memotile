import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:memotile/app/global/memo.dart';
import 'package:memotile/app/global/old_memo.dart';

import 'app/routes/app_pages.dart';

void main() {
  // await MemoModel().initDB();
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.white,
        focusColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      title: "Applicatin",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
