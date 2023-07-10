import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';

class MemoDetailView extends GetView<HomeController> {
  const MemoDetailView(
      {Key? key,
      this.id,
      this.text,
      this.createdAt,
      this.date,
      this.colorValue})
      : super(key: key);

  final int? id;
  final String? text;
  final String? createdAt;
  final String? date;
  final int? colorValue;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                controller.itemToTrash(Get.arguments['id']);
                Get.back();
              },
              icon: Icon(
                Icons.delete,
                color: Colors.black,
              ),
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
              controller.tagModeOn.value = false;
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
                                controller.getRedRed();
                                controller.isColorChanged.value = true;
                              },
                              color: Color(controller.redredValue),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 60,
                            child: Center(
                              child: Text(
                                controller.tag.read('red'),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 38,
                            child: MaterialButton(
                              onPressed: () {
                                controller.getBlue();
                                controller.isColorChanged.value = true;
                              },
                              color: Color(controller.blueValue),
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
                                controller.tag.read('blue'),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 38,
                            child: MaterialButton(
                              onPressed: () {
                                controller.getAqua();
                                controller.isColorChanged.value = true;
                              },
                              color: Color(controller.aquaValue),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 60,
                            child: Center(
                              child: Text(
                                controller.tag.read('aqua'),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 38,
                            child: MaterialButton(
                              onPressed: () {
                                controller.getGreen();
                                controller.isColorChanged.value = true;
                              },
                              color: Color(controller.greenValue),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 60,
                            child: Center(
                              child: Text(
                                controller.tag.read('green'),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 38,
                            child: MaterialButton(
                              onPressed: () {
                                controller.getPink();
                                controller.isColorChanged.value = true;
                              },
                              color: Color(controller.pinkValue),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 60,
                            child: Center(
                              child: Text(
                                controller.tag.read('pink'),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 38,
                            child: MaterialButton(
                              onPressed: () {
                                controller.getOrange();
                                controller.isColorChanged.value = true;
                              },
                              color: Color(controller.orangeValue),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 60,
                            child: Center(
                              child: Text(
                                controller.tag.read('orange'),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 38,
                            child: MaterialButton(
                              onPressed: () {
                                controller.getPurple();
                                controller.isColorChanged.value = true;
                              },
                              color: Color(controller.purpleValue),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 60,
                            child: Center(
                              child: Text(
                                controller.tag.read('purple'),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 38,
                            child: MaterialButton(
                              onPressed: () {
                                controller.getMustard();
                                controller.isColorChanged.value = true;
                              },
                              color: Color(controller.mustardValue),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 60,
                            child: Center(
                              child: Text(
                                controller.tag.read('mustard'),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
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
