import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';

class ThemeView extends GetView<HomeController> {
  const ThemeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ThemeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                Get.changeTheme(ThemeData.dark());
                controller.isDarkModeOn.value = true;
              },
              child: Text('get dark'),
            ),
            TextButton(
              onPressed: () async {
                controller.isDarkModeOn.value = false;
                Get.changeTheme(
                  ThemeData(
                    useMaterial3: true,
                    primaryColor: Colors.black,
                    // textTheme: TextTheme(
                    //   bodyText1: TextStyle(color: Colors.black),
                    // ),
                    // backgroundColor: Colors.white,
                    // appBarTheme: AppBarTheme(
                    //   backgroundColor: Colors.grey[100],
                    //   titleTextStyle: TextStyle(color: Colors.black),
                    // ),
                    iconButtonTheme: IconButtonThemeData(),
                    primaryIconTheme: IconThemeData(color: Colors.black),
                    iconTheme: IconThemeData(color: Colors.black),
                  ),
                );
              },
              child: Text('get right'),
            ),
          ],
        ),
      ),
    );
  }
}
