import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../global/horizontal_line.dart';
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
          IconButton(
            onPressed: () {
              openBottomSheet();
            },
            icon: Icon(
              Icons.menu_rounded,
              color: Colors.black,
            ),
          ),
        ],
        leadingWidth: 100,
        //appBar 왼쪽 상단의 리딩 버튼, 처음부터 되돌아가기 모양, 월 정보 표시.
        leading: Obx(
          () => controller.searchModeOn == true
              ? MaterialButton(
                  onPressed: () {
                    controller.searchModeOn.value = false;
                    controller.refreshMemo();
                  },
                  child: Icon(
                    Icons.close,
                  ),
                )
              : MaterialButton(
                  onPressed: () {
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
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Obx(
          () => controller.searchModeOn == true
              ? Column(
                children: [
                  Text(
                      controller.searchBarController.text,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                  Text(
                    //요일
                    'Searching',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
              : Column(
                  children: [
                    Text(
                      //일
                      controller.CurrentDay.value,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      //요일
                      controller.CurrentDayOf.value,
                      style: TextStyle(
                        color: Color(controller.ssDayColorValue.value),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
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
                  controller: controller.scrollController.value,
                  itemCount: controller.memo.length,
                  itemBuilder: (context, index) {
                    return MemoTile(
                      //memo_tile ui 에 들어갈 각 객체를 index 와 column 값을 넣어 구성.
                      id: controller.memo[index]['id'],
                      text: controller.memo[index]['content'],
                      date: controller.memo[index]['dateData'],
                      createdAt: controller.memo[index]['createdAt'],
                      colorValue: controller.memo[index]['colorValue'],
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
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
                          hintText: ' Insert here',
                        ),
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
                        //dateTime 데이터는 원래 '' 이므로 해당 값을 가져와주는 메소드를 먼저 실행.
                        controller.getDefaultColor();
                        controller.getCurrentDay();
                        controller.getCurrentDayDetail();
                        controller.getCurrentDate();
                        controller.addItem();
                        //스크롤 아래로 내리기.
                        controller.goToDown();
                        //TextField 초기화.
                        controller.memoController.clear();
                        //debug.
                        print(controller.colorValue.value.toString());
                        print(controller.CurrentDayDetail.value.toString());
                      },
                      icon: Icon(Icons.send_rounded),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  openBottomSheet() {
    Get.bottomSheet(
      Column(
        children: [
          SizedBox(
            height: 13,
          ),
          Center(
            child: SizedBox(
              width: 50,
              height: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 16,
              ),
              Text(
                'Tags',
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: SizedBox(
              height: 78,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 48,
                        width: 48,
                        child: MaterialButton(
                          onPressed: () {
                            controller.refreshMemo();
                            controller.getDefaultColor();
                          },
                          color: Colors.grey[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('red'),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 48,
                        width: 48,
                        child: MaterialButton(
                          onPressed: () {
                            controller.getRed();
                            controller.refreshMemoByColor(
                                controller.colorValue.value);
                            controller.getDefaultColor();
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
                      Text('red'),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 48,
                        width: 48,
                        child: MaterialButton(
                          onPressed: () {
                            controller.getTeal();
                            controller.refreshMemoByColor(
                                controller.colorValue.value);
                            controller.getDefaultColor();
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
                      Text('teal'),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 48,
                        width: 48,
                        child: MaterialButton(
                          onPressed: () {
                            controller.getLightPink();
                            controller.refreshMemoByColor(
                              Color(0xfff28b81).value,
                            );
                            controller.getDefaultColor();
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
                      Text('data'),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 48,
                        width: 48,
                        child: MaterialButton(
                          onPressed: () {
                            controller.getYellow();
                            controller.refreshMemoByColor(
                              Color(0xfffbf476).value,
                            );
                            controller.getDefaultColor();
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
                      Text('data'),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 48,
                        width: 48,
                        child: MaterialButton(
                          onPressed: () {
                            controller.getLightGreen();
                            controller.refreshMemoByColor(
                              Color(0xffcdff90).value,
                            );
                            controller.getDefaultColor();
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
                      Text('data'),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 48,
                        width: 48,
                        child: MaterialButton(
                          onPressed: () {
                            controller.getTurquoise();
                            controller.refreshMemoByColor(
                              Color(0xffa7feeb).value,
                            );
                            controller.getDefaultColor();
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
                      Text('data'),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 48,
                        width: 48,
                        child: MaterialButton(
                          onPressed: () {
                            controller.getLightCyan();
                            controller.refreshMemoByColor(
                              Color(0xffcbf0f8).value,
                            );
                            controller.getDefaultColor();
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
                      Text('data'),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 48,
                        width: 48,
                        child: MaterialButton(
                          onPressed: () {
                            controller.getLightBlue();
                            controller.refreshMemoByColor(
                              Color(0xffafcbfa).value,
                            );
                            controller.getDefaultColor();
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
                      Text('data'),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 48,
                        width: 48,
                        child: MaterialButton(
                          onPressed: () {
                            controller.getPlum();
                            controller.refreshMemoByColor(
                              Color(0xffd7aefc).value,
                            );
                            controller.getDefaultColor();
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
                      Text('data'),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          HorizontalLine(),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 16,
              ),
              Text(
                'Searching',
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: controller.searchBarController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () async {
                              await controller.searchButtonClicked();
                              await controller.refreshMemoByContent(
                                controller.searchBarController.text,
                              );
                              Get.back();
                            },
                            icon: Icon(Icons.search_rounded),
                          ),
                          hintText: ' Insert here',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Colors.grey[400],
                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: (String text) async {
                          controller.refreshMemoByContent(text);
                        },
                        onTapOutside: (P) {
                          // controller.focusOuted();
                          controller.refreshMemoByContent(
                            controller.searchBarController.text,
                          );
                          controller.searchBarController.text = '';
                        },
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     controller.refreshMemoByContent(
                    //       controller.searchBarController.text,
                    //     );
                    //   },
                    //   icon: Icon(Icons.search_rounded),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
