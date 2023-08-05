import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memotile/app/global/languages.dart';
import 'package:memotile/app/global/memo.dart';

import 'app/routes/app_pages.dart';

void main() async{
  await GetStorage.init();
  await MemoHelper.db();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      translations: Languages(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      title: "MOTOMEE",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
