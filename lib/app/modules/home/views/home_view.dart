import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../global/memo_tile.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              controller.getRed();
            },
            child: Text('get Red'),
          ),
        ],
        leadingWidth: 100,
        //appBar 왼쪽 상단의 리딩 버튼, 처음부터 되돌아가기 모양, 월 정보 표시.
        leading: InkWell(
          onTap: () {
            Get.toNamed(
              '/tile',
              arguments: {
                'TileMonth': controller.CurrentMonth.value,
                'TileDay': controller.CurrentDay.value,
              },
            );
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
                      controller.CurrentMonth.value,
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
        backgroundColor: Colors.white,
        elevation: 0,
        title: Obx(
          () => Text(
            controller.CurrentDay.value,
            style: TextStyle(color: Colors.black),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.memo.length,
                  itemBuilder: (context, index) {
                    return MemoTile(
                      //memo_tile ui 에 들어갈 각 객체를 index 와 column 값을 넣어 구성.
                      text: controller.memo[index]['content'],
                      date: controller.memo[index]['createdAt'],
                      colorValue: controller.memo[index]['colorValue'],
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: TextFormField(
                          controller: controller.memoController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusColor: Colors.black,
                              hintText: ' Insert here'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0, top: 5, right: 14, bottom: 5),
                      child: IconButton(
                        //+ 버튼
                        //눌렀을 때 addItem 메소드 실행
                        //->TextField 의 Text, 현재 시간, colorValue 의 값을 db 에 insert
                        onPressed: () async {
                          await controller.getCurrentDate();
                          controller.addItem();
                          //TextField 초기화.
                          controller.memoController.clear();
                          //debug.
                          print(controller.colorValue.value.toString());
                        },
                        icon: Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
