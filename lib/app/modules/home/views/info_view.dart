import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';

import '../../../global/palette.dart';

class InfoView extends GetView<HomeController> {
  const InfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          controller.isDarkModeOn.value == true ? subDark : subLight,
      appBar: AppBar(
        backgroundColor:
            controller.isDarkModeOn.value == true ? subDark : subLight,
        title: Text(
          'InfoView',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: Text(
          'InfoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
