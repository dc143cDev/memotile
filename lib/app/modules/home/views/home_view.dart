import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../global/horizontal_line.dart';
import '../../../global/marker_tile.dart';
import '../../../global/memo_tile.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //어느 화면이나 눌렀을때 텍스트 필드를 내리기 위해 Gesture Detector 감싸주기.
        controller.textFocus.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          actions: [
            // 타일 탭 오픈.
            Obx(
              () => controller.dateModeOn.value == true
                  ? Container()
                  : IconButton(
                      onPressed: () {
                        openTileSheet();
                      },
                      icon: Icon(
                        Icons.calendar_month_sharp,
                        color: Colors.black,
                      ),
                    ),
            ),
            //앱바 검색모드로 변경.
            IconButton(
              onPressed: () {
                openSearchSheet();
              },
              icon: Icon(
                Icons.search_rounded,
                color: Colors.black,
              ),
            ),
            //메뉴 탭 오픈.
            IconButton(
              onPressed: () {
                openMenuSheet();
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
            () => controller.searchModeOn == true ||
                    controller.tagModeOn == true
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
                : Container(
                    child: controller.dateModeOn.value == true
                        //dateMode.
                        ? MaterialButton(
                            onPressed: () {
                              controller.defaultModeOn();
                              controller.refreshMemo();
                              controller.goToDown();
                            },
                            child: Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          )
                        //디폴트 모드.
                        : Container(),
                  ),
          ),

          //타이틀도 leading 과 같이 모드 가변형 ui.
          title: Obx(
            () => controller.tagModeOn == true ||
                    controller.searchModeOn == true
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
                                colorValue: controller.memo[index]
                                    ['colorValue'],
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
                                  focusNode: controller.textFocus,
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
      ),
    );
  }

  //타일뷰 바텀시트.
  openTileSheet() async {
    //모드 초기화를 위해 메모 리프레쉬.
    await controller.refreshMemo();
    await controller.defaultModeOn();
    //Tile View 로 넘어가기 전에 memoForEvent 에 월별로 가져온 데이터 넣기.
    await controller.getTiles();
    await controller.goToDown();
    //CurrentMonthForTile 의 초기 값은 '' 이므로 평소에는 타이틀에 아무 값도 나오지 않음.
    controller.CurrentMonthForTile.value = controller.CurrentMonthMMM.value;
    Get.bottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      elevation: 0,
      SafeArea(
        child: SizedBox(
          height: 440,
          width: double.infinity,
          child: Column(
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
              Expanded(
                flex: 1,
                child: Obx(
                  () => Text(
                    controller.CurrentMonthForTile.value,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: TableCalendar(
                  calendarBuilders: CalendarBuilders(
                      //마커 타일 빌더.
                      //context 와 날짜(년월일시분초까지 다 표시되는 버전), event(List)를 넘겨줄수 있음.
                      markerBuilder: (context, day, events) {
                    //events 의 원형은 [ 단일객체 ] (length == 1) 이기때문에 두번 걸러 리스트화 해야함.
                    //to String,
                    String eventToString = events.toString();
                    //jsonDecode from String to List.
                    List stringEventToList = jsonDecode(eventToString);
                    if (events.isNotEmpty == true) {
                      return Center(
                        child: MarKerTile(
                          date: '',
                          event: DateFormat('dd').format(day),
                          //그렇게 리스트화된 colorValue 객체 중 하나를 ui에 넣어주기.
                          colorList: stringEventToList,
                          color: stringEventToList.last,
                        ),
                      );
                    }
                    return null;
                  }),
                  calendarStyle: CalendarStyle(
                    markerDecoration: BoxDecoration(
                      color: Colors.red,
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    titleTextStyle: TextStyle(color: Colors.white),
                    titleCentered: true,
                    leftChevronVisible: false,
                    rightChevronVisible: false,
                    formatButtonVisible: false,
                  ),
                  eventLoader: (day) {
                    return controller.getEvents(day);
                  },
                  focusedDay: DateTime.now(),
                  firstDay: DateTime(2010, 5, 1),
                  lastDay: DateTime(2033, 12, 31),
                  onDaySelected:
                      (DateTime selectedDay, DateTime focusedDay) async {
                    //DB 검색 용이성을 위해 미리 지정된 포맷으로 selectedDay 반환.
                    await controller.goToTop();
                    controller.selectedDay.value =
                        DateFormat("yyyyMMdd").format(selectedDay);
                    print('$selectedDay is selected');
                    print('$focusedDay is focused');
                    print(controller.selectedDay);
                    controller.refreshMemoByDateTile(controller.selectedDay);
                    controller.dateButtonClicked();
                    controller.goToDown();
                    Get.back();
                  },
                  onPageChanged: (day) {
                    //페이지 전환할때마다 값을 지금이 몇월인지 값 넘겨주기.
                    controller.CurrentMonthForTile.value =
                        DateFormat('MMM').format(day);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //서치 탭 바텀시트.
  openSearchSheet() async {
    //검색버튼을 누르는 순간에 클리어를 두면 앱바 ui에 반영되지 않기에 바텀시트를 불러올때 클리어를 둠.
    controller.searchBarController.clear();
    if (controller.tagModeOn.value == true) {
      controller.refreshMemoByColor(controller.colorValue.value);
    }
    Get.bottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      SizedBox(
        height: 340,
        width: double.infinity,
        child: Column(
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
                          focusNode: controller.textFocus,
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
          ],
        ),
      ),
    );
  }

  //메뉴 탭 클릭시 오픈.
  openMenuSheet() {
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
          InkWell(
            onTap: () {},
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
            onTap: () {},
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
