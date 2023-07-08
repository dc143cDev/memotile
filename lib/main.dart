import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memotile/app/global/notification.dart';

import 'app/routes/app_pages.dart';

void main() async{
  await GetStorage.init();
  await NotificationHelper().setup();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      theme: ThemeData.light(
        // primaryColor: Colors.white,
        // appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        // iconTheme: IconThemeData(color: Colors.black),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      title: "Applicatin",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
