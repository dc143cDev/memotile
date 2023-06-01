import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  // await MemoModel().initDB();
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        focusColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      title: "Applicatin",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
