import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';

class MemoDetailView extends GetView<HomeController> {
  const MemoDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          Get.arguments['date'],
          style: TextStyle(color: Colors.black),
        ),
        leading: InkWell(
          onTap: () async {
            await controller.getCurrentDate();
            await controller.updateItem(
              //get arguments 로 받아온 id 를 MemoHelper 의 update 기능으로 넘기기.
              Get.arguments['id'],
              controller.memoDetailController.text,
              controller.CurrentDate.value,
              controller.colorValue.value,
            );
            Get.back();
          },
          child: Container(
            child: Row(
              children: [
                Expanded(
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => Text(
                      controller.CurrentDay.value,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 9),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextField(
                  //홈 화면의 메모 타일의 데이터가 상세 페이지로 옮겨지는 과정 - 5.
                  //이곳에 memoDetailController 를 삽입하여 갖고있을 text 를 ui 에 최종 출력.
                  controller: controller.memoDetailController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    hintText: 'content',
                  ),
                ),
              ),
            ),
            Text('color: ${Get.arguments['color']}'),
          ],
        ),
      ),
    );
  }
}
