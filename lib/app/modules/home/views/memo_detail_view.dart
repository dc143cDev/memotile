import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';

class MemoDetailView extends GetView<HomeController> {
  const MemoDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MemoDetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(children: [
          Text('content: ${Get.arguments['content']}'),
          Text('date: ${Get.arguments['date']}'),
          Text('color: ${Get.arguments['color']}'),
        ],),
      ),
    );
  }
}
