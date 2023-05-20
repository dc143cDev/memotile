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
        actions: [
          TextButton(
            onPressed: () {
              controller.getCurrentDate();
              controller.updateItem(
                Get.arguments['id'],
                controller.memoDetailController.text,
                controller.CurrentDate.value,
                controller.colorValue.value,
              );
            },
            child: Text(
              'update',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              //홈 화면의 메모 타일의 데이터가 상세 페이지로 옮겨지는 과정 - 5.
              //이곳에 memoDetailController 를 삽입하여 갖고있을 text 를 ui 에 최종 출력.
              controller: controller.memoDetailController,
              decoration: InputDecoration(
                hintText: 'content',
              ),
            ),
            Text('date: ${Get.arguments['date']}'),
            Text('color: ${Get.arguments['color']}'),
          ],
        ),
      ),
    );
  }
}
