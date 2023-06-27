import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:memotile/app/global/notification.dart';

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
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              notification().getNotification();
              // Get.changeTheme(ThemeData.dark());
            },
            icon: Icon(
              Icons.menu_rounded,
              color: Colors.red,
            ),
          ),
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
          //모드에 따라 바뀌는 ui.
          //서치 모드일 경우 아이콘이, 태그 모드일 경우 색상 팔레트가 출력.
          () => controller.searchModeOn == true || controller.tagModeOn == true
              ? MaterialButton(
                  onPressed: () {
                    controller.goToDown();
                    controller.searchModeOn.value = false;
                    controller.tagModeOn.value = false;
                    controller.refreshMemo();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.close,
                      ),
                      //서치모드.
                      Expanded(
                        child: controller.searchModeOn.value == true
                            ? Icon(
                                Icons.search_rounded,
                                color: Colors.black,
                              )
                            //태그모드.
                            : Container(
                                height: 20,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Color(controller.colorValue.value),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                      ),
                    ],
                  ),
                )
              //디폴트 모드 or 날짜모드.
              : MaterialButton(
                  onPressed: () async {
                    //모드 초기화를 위해 메모 리프레쉬.
                    await controller.refreshMemo();
                    //Tile View 로 넘어가기 전에 memoForEvent 에 월별로 가져온 데이터 넣기.
                    await controller.getTiles();
                    await controller.goToDown();
                    // await controller.eventsValueInit();
                    controller.dateModeOn.value == true
                        ? controller.defaultModeOn()
                        : Get.toNamed(
                            '/tile',
                            arguments: {
                              'TileMonth': controller.CurrentMonthMMM.value,
                              'TileDay': controller.CurrentDay.value,
                            },
                          );
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: controller.dateModeOn.value == true
                              ? Icon(
                                  Icons.close,
                                )
                              : Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.black,
                                ),
                        ),
                        Expanded(
                          child: Obx(
                            () => controller.dateModeOn.value == true
                                ? Icon(Icons.calendar_month)
                                : Text(
                                    controller.CurrentMonthMMM.value,
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

        //타이틀도 leading 과 같이 모드 가변형 ui.
        title: Obx(
          () => controller.tagModeOn == true || controller.searchModeOn == true
              ? Column(
                  children: [
                    Text(
                      //일
                      controller.CurrentDay.value,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    controller.searchModeOn.value == true
                        ? Text(
                            //서치모드
                            controller.searchBarController.text,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        : Text(
                            //태그모드
                            controller.tag.read(controller.nowTag.value),
                            style: TextStyle(
                              color: Color(controller.colorValue.value),
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ],
                )
              //디폴트 모드 or 날짜모드.
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
                    controller.dateModeOn.value == true
                        ? Text(
                            //요일
                            controller.selectedDay.value,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        : Text(
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
      ),
      body: Obx(
        () => SafeArea(
          child: controller.memo.toString() == '[]'
              ? Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Text(
                          'empty',
                          style: TextStyle(color: Colors.grey, fontSize: 40),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: SizedBox(),
                    ),
                    //textField. empty 상태일때 굳이 필요 없다고 판단.
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
                                await controller.getDefaultColor();
                                await controller.getCurrentDay();
                                await controller.getCurrentDayDetail();
                                await controller.getCurrentDate();
                                await controller.firstCheckByDate();
                                controller.addItem();
                                //스크롤 아래로 내리기.
                                controller.goToDown();
                                //TextField 초기화.
                                controller.memoController.clear();
                                //defaultModeOn
                                controller.defaultModeOn();
                                //debug.
                                print(controller.colorValue.value.toString());
                                print(controller.CurrentDayDetail.value
                                    .toString());
                              },
                              icon: Icon(Icons.send_rounded),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
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
                              createdAt: controller.memo[index]['createdAt'],
                              date: controller.memo[index]['dateData'],
                              isFirst: controller.memo[index]['isFirst'],
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
                                await controller.getDefaultColor();
                                await controller.getCurrentDay();
                                await controller.getCurrentMonthMM();
                                await controller.getCurrentYear();
                                await controller.getCurrentDayDetail();
                                await controller.getCurrentDate();
                                await controller.firstCheckByDate();
                                controller.addItem();
                                //스크롤 아래로 내리기.
                                controller.goToDown();
                                //TextField 초기화.
                                controller.memoController.clear();
                                //defaultModeOn
                                controller.defaultModeOn();
                                //debug.
                                print(controller.colorValue.value.toString());
                                print(controller.CurrentDayDetail.value
                                    .toString());
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
      ),
    );
  }

  //바텀시트.
  //위에서 아래 순서대로 태그 선택 기능 및 태그 커스터마이징 뷰 넘어가는 버튼/ 서칭/ 설정/ 아직 미정.
  openBottomSheet() async {
    //검색버튼을 누르는 순간에 클리어를 두면 앱바 ui에 반영되지 않기에 바텀시트를 불러올때 클리어를 둠.
    controller.searchBarController.clear();
    if (controller.tagModeOn.value == true) {
      controller.refreshMemoByColor(controller.colorValue.value);
    }
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
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 12, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tags',
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/tags');
                  },
                  child: Text(
                    'Customizing',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(13, 3, 13, 13),
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
                          onPressed: () async {
                            await controller.getRed();
                            controller.nowTag.value = 'red';
                            controller.tagButtonClicked();
                            controller.refreshMemoByColor(
                                controller.colorValue.value);
                            Get.back();
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
                      Text(controller.tag.read('red')),
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
                          onPressed: () async {
                            await controller.getTeal();
                            controller.nowTag.value = 'teal';
                            controller.tagButtonClicked();
                            controller.refreshMemoByColor(
                                controller.colorValue.value);
                            Get.back();
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
                      Text(controller.tag.read('teal')),
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
                            controller.nowTag.value = 'lightPink';
                            controller.tagButtonClicked();
                            controller.refreshMemoByColor(
                              Color(0xfff28b81).value,
                            );
                            Get.back();
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
                      Text(controller.tag.read('lightPink')),
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
                            controller.nowTag.value = 'yellow';
                            controller.tagButtonClicked();
                            controller.refreshMemoByColor(
                              Color(0xfffbf476).value,
                            );
                            Get.back();
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
                      Text(controller.tag.read('yellow')),
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
                            controller.nowTag.value = 'lightGreen';
                            controller.tagButtonClicked();
                            controller.refreshMemoByColor(
                              Color(0xffcdff90).value,
                            );
                            Get.back();
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
                      Text(controller.tag.read('lightGreen')),
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
                            controller.nowTag.value = 'turquoise';
                            controller.tagButtonClicked();
                            controller.refreshMemoByColor(
                              Color(0xffa7feeb).value,
                            );
                            Get.back();
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
                      Text(controller.tag.read('turquoise')),
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
                            controller.nowTag.value = 'lightCyan';
                            controller.tagButtonClicked();
                            controller.refreshMemoByColor(
                              Color(0xffcbf0f8).value,
                            );
                            Get.back();
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
                      Text(controller.tag.read('lightCyan')),
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
                            controller.nowTag.value = 'lightBlue';
                            controller.tagButtonClicked();
                            controller.refreshMemoByColor(
                              Color(0xffafcbfa).value,
                            );
                            Get.back();
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
                      Text(controller.tag.read('lightBlue')),
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
                            controller.nowTag.value = 'plum';
                            controller.tagButtonClicked();
                            controller.refreshMemoByColor(
                              Color(0xffd7aefc).value,
                            );
                            Get.back();
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
                      Text(controller.tag.read('plum')),
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
                              //여기에 클리어를 두면 앱바 ui 수정에 반영되지 않음.
                              // controller.searchBarController.clear();
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
                          //콘텐츠 검색기능 사용시 태그 검색모드 해제
                          controller.tagModeOn.value = false;
                          controller.searchModeOn.value = false;
                          controller.refreshMemoByContent(text);
                        },
                        onTapOutside: (P) {
                          // 태그 검색모드 활성화된 상태라면 바깥 쪽을 터치해도 태그 검색모드가 해제되지 않도록 함.
                          if (controller.tagModeOn.value == false) {
                            controller.refreshMemo();
                          }
                          controller.searchBarController.clear();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          HorizontalLine(),
          InkWell(
            onTap: (){},
            child: Container(
              width: double.infinity,
              height: 70,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.settings,
                      color: Colors.grey[700],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Setting',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          HorizontalLine(),
          InkWell(
            onTap: (){},
            child: Container(
              width: double.infinity,
              height: 70,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.grey[700],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Infomation',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          HorizontalLine(),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
