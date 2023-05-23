import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';

class MemoDetailView extends GetView<HomeController> {
  const MemoDetailView(
      {Key? key, this.id, this.text, this.date, this.colorValue})
      : super(key: key);

  final int? id;
  final String? text;
  final String? date;
  final int? colorValue;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: controller.isColorChanged == false
              ? Color(Get.arguments['color'])
              : Color(controller.colorValue.value),
          title: Text(
            '',
            // Get.arguments['date'],
            style: TextStyle(color: Colors.black),
          ),
          leadingWidth: 80,
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
              controller.getDefaultColor();
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
                  SizedBox(
                    width: 0,
                  ),
                  Expanded(
                    child: Obx(
                      () => Text(
                        controller.CurrentDay.value,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15),
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
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        child: InkWell(
                          onTap: () {
                            controller.getRed();
                            controller.isColorChanged.value = true;
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                      Container(
                        child: InkWell(
                          onTap: () {
                            controller.getTeal();
                            controller.isColorChanged.value = true;
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.teal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 9,
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
                      border: InputBorder.none,
                      hintText: 'content',
                    ),
                  ),
                ),
              ),
              // Text('color: ${Get.arguments['color']}'),
            ],
          ),
        ),
      ),
    );
  }
}
