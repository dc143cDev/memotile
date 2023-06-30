import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';

import '../controllers/theme_controller.dart';

class ThemeView extends GetView<ThemeController> {
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

                await HomeController().darkModeOn();
              },
              child: Text('get dark'),
            ),
            TextButton(
              onPressed: () {
                Get.changeTheme(ThemeData());
              },
              child: Text('get right'),
            ),
          ],
        ),
      ),
    );
  }
}
