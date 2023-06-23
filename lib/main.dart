import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memotile/app/global/notification.dart';

import 'app/routes/app_pages.dart';

void main() async{
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await notification().setup();
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      title: "Applicatin",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
