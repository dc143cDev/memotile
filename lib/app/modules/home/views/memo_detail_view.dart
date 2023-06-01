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
          actions: [
            TextButton(
              onPressed: () {
                controller.deleteItem(Get.arguments['id']);
                Get.back();
              },
              child: Text('delete'),
            ),
          ],
          elevation: 0,
          backgroundColor: controller.isColorChanged == false
              ? Color(Get.arguments['color'])
              : Color(controller.colorValue.value),
          title: Text(
            //에러남.
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
              SizedBox(
                height: 5,
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: 38,
                            child: MaterialButton(
                              onPressed: () {
                                controller.getRed();
                                controller.isColorChanged.value = true;
                              },
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 52,
                            child: Center(
                              child: Text(
                                'data',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 38,
                            child: MaterialButton(
                              onPressed: () {
                                controller.getTeal();
                                controller.isColorChanged.value = true;
                              },
                              color: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 52,
                            child: Center(
                              child: Text(
                                'data',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 38,
                            child: MaterialButton(
                              onPressed: () {
                                controller.getLightPink();
                                controller.isColorChanged.value = true;
                              },
                              color: Color(0xfff28b81),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 52,
                            child: Center(
                              child: Text(
                                'data',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 38,
                            child: MaterialButton(
                              onPressed: () {
                                controller.getLightGreen();
                                controller.isColorChanged.value = true;
                              },
                              color: Color(0xffcdff90),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 52,
                            child: Center(
                              child: Text(
                                'data',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 38,
                            child: MaterialButton(
                              onPressed: () {
                                controller.getTurquoise();
                                controller.isColorChanged.value = true;
                              },
                              color: Color(0xffa7feeb),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 52,
                            child: Center(
                              child: Text(
                                'data',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 38,
                            child: MaterialButton(
                              onPressed: () {
                                controller.getLightCyan();
                                controller.isColorChanged.value = true;
                              },
                              color: Color(0xffcbf0f8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 52,
                            child: Center(
                              child: Text(
                                'data',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 38,
                            child: MaterialButton(
                              onPressed: () {
                                controller.getLightBlue();
                                controller.isColorChanged.value = true;
                              },
                              color: Color(0xffafcbfa),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 52,
                            child: Center(
                              child: Text(
                                'data',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 38,
                            child: MaterialButton(
                              onPressed: () {
                                controller.getPlum();
                                controller.isColorChanged.value = true;
                              },
                              color: Color(0xffd7aefc),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 52,
                            child: Center(
                              child: Text(
                                'data',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 38,
                            child: MaterialButton(
                              onPressed: () {
                                controller.getYellow();
                                controller.isColorChanged.value = true;
                              },
                              color: Color(0xfffbf476),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 52,
                            child: Center(
                              child: Text(
                                'data',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 11),
                              ),
                            ),
                          ),
                        ],
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
                    style: TextStyle(fontWeight: FontWeight.w600),
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
