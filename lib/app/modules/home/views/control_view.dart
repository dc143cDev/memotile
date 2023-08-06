import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:memotile/app/global/default_day.dart';
import 'package:memotile/app/global/palette.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../global/marker_tile.dart';

class ControlView extends GetView<HomeController> {
  const ControlView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final verticalLine = Obx(
      () => AnimatedContainer(
        duration: Duration(milliseconds: 100),
        width: 1,
        height: controller.controllPageLongContainerVerticalLine.value,
        color: controller.isDarkModeOn.value == true ? shadowDark : shadowLight,
      ),
    );

    return Obx(
      () => Scaffold(
        backgroundColor:
            controller.isDarkModeOn.value == true ? subDark : subLight,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: FloatingActionButton(
            child: Icon(
              Icons.close,
              color:
                  controller.isDarkModeOn.value == true ? iconDark : iconLight,
            ),
            backgroundColor:
                controller.isDarkModeOn.value == true ? subDark : subLight,
            onPressed: () {
              controller.pageController.animateToPage(0,
                  duration: Duration(milliseconds: 300), curve: Curves.easeIn);
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: ListView(
          scrollDirection: Axis.vertical,
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            Center(
              child: Column(
                children: [
                  //tile.
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      // height: controller.height.value * 0.55,
                      // width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: controller.isDarkModeOn.value == true
                            ? backgroundDark
                            : backgroundLight,
                        boxShadow: [
                          BoxShadow(
                            color: controller.isDarkModeOn.value == true
                                ? shadowDark
                                : shadowLight,
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 7), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Obx(
                            () => Text(
                              controller.CurrentMonthForTile.value,
                              style: TextStyle(
                                  color: controller.isDarkModeOn.value == true
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: TableCalendar(
                              headerVisible: false,
                              calendarBuilders: CalendarBuilders(
                                defaultBuilder: (context, day, day2) {
                                  final yyyyMMdd =
                                      DateFormat('yyyyMMdd').format(day);
                                  //event Hash Keys가 곧 데이터를 보유한 날짜의 리스트임.
                                  //day(yyyyMMdd)가 keys에 해당되지 않는다면, false를 반환.
                                  //반환된 날짜는 UI에 흐리게 표시되고 클릭되지 않게끔 함.
                                  final isEmpty = controller.keys
                                      .contains(yyyyMMdd)
                                      .toString();
                                  print('isM : $isEmpty');
                                  return DefaultDay(
                                    dateValue: DateFormat('dd').format(day),
                                    emptyCheck: isEmpty,
                                  );
                                },
                                //마커 타일 빌더.
                                //context 와 날짜(년월일시분초까지 다 표시되는 버전), event(List)를 넘겨줄수 있음.
                                markerBuilder: (context, day, events) {
                                  //events 의 원형은 [ 단일객체 ] (length == 1) 이기때문에 두번 걸러 리스트화 해야함.
                                  //to String,
                                  String eventToString = events.toString();
                                  //jsonDecode from String to List.
                                  List stringEventToList =
                                      jsonDecode(eventToString);
                                  if (events.isNotEmpty == true) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        MarKerTile(
                                          date: '',
                                          event: DateFormat('dd').format(day),
                                          //그렇게 리스트화된 colorValue 객체 중 하나를 ui에 넣어주기.
                                          colorList: stringEventToList,
                                          color: stringEventToList.last,
                                        ),
                                      ],
                                    );
                                  }
                                  return null;
                                },
                              ),
                              calendarStyle: CalendarStyle(
                                defaultTextStyle: TextStyle(),
                                todayTextStyle: TextStyle(
                                  color: controller.isDarkModeOn.value == true
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                todayDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          controller.isDarkModeOn.value == true
                                              ? shadowDark
                                              : shadowLight,
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  //오늘 컨테이너 컬러.
                                  color: controller.isDarkModeOn.value == true
                                      ? subDark
                                      : subLight,
                                ),
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
                              onDaySelected: (DateTime selectedDay,
                                  DateTime focusedDay) async {
                                //이쪽도 위의 defaultDayBuilder와 마찬가지.
                                //keys에 해당되지 않는 날짜는 클릭되지 않게끔 함.
                                if (controller.keys.contains(
                                      DateFormat("yyyyMMdd")
                                          .format(selectedDay),
                                    ) ==
                                    true) {
                                  //DB 검색 용이성을 위해 미리 지정된 포맷으로 selectedDay 반환.
                                  // await controller.goToTop();
                                  controller.selectedDay.value =
                                      DateFormat("yyyyMMdd")
                                          .format(selectedDay);
                                  print('$selectedDay is selected');
                                  print('$focusedDay is focused');
                                  print(controller.selectedDay);
                                  controller.refreshMemoByDateTile(
                                      controller.selectedDay);
                                  controller.dateButtonClicked();
                                  controller.pageController.animateToPage(0,
                                      duration: Duration(milliseconds: 200),
                                      curve: Curves.easeIn);
                                } else {
                                  null;
                                }
                              },
                              onPageChanged: (day) {
                                //페이지 전환할때마다 값을 지금이 몇월인지 값 넘겨주기.
                                controller.CurrentMonthForTile.value =
                                    DateFormat('MMM').format(day);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //알람 센터 기능은 보류. 테마 셀렉터로 바꾸기.
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                    child: Obx(
                      () => AnimatedContainer(
                        curve: Curves.easeIn,
                        duration: Duration(milliseconds: 100),
                        width: controller.controllPageLongContainerX.value,
                        height:
                            controller.controllPageLongContainerY.value * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: controller.isDarkModeOn.value == true
                              ? backgroundDark.withOpacity(
                                  controller.controllPageContainerOpacity.value)
                              : backgroundLight.withOpacity(controller
                                  .controllPageContainerOpacity.value),
                          boxShadow: [
                            BoxShadow(
                              color: controller.isDarkModeOn.value == true
                                  ? shadowDark
                                  : shadowLight,
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 7), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //시스템 테마.
                              InkWell(
                                onTap: () {
                                  controller.deviceThemeOn();
                                },
                                child: AnimatedContainer(
                                  curve: Curves.easeIn,
                                  duration: Duration(milliseconds: 100),
                                  width: controller
                                          .controllPageShortContainerX.value *
                                      0.46,
                                  height: controller
                                          .controllPageShortContainerX.value *
                                      0.6,
                                  decoration: BoxDecoration(
                                    color: controller.isDarkModeOn.value == true
                                        ? subDark
                                        : subLight,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 7,
                                      ),
                                      //디바이스 테마 활성화시에는 항상 노란불.
                                      controller.useDeviceTheme.value == true
                                          ? Expanded(
                                              child: Icon(
                                                Icons.perm_device_info,
                                                color: seletedThemeIcon,
                                              ),
                                            )
                                          : Expanded(
                                              child: Icon(
                                                //아니라면 테마에 맞는 비활성화 아이콘 색깔로.
                                                Icons.perm_device_info,
                                                color: controller.isDarkModeOn
                                                            .value ==
                                                        true
                                                    ? iconDark
                                                    : iconLight,
                                              ),
                                            ),
                                      // SizedBox(
                                      //   height: 5,
                                      // ),
                                      Expanded(
                                        child: Text(
                                          'Device'.tr,
                                          // style: TextStyle(
                                          //   fontSize: controller
                                          //       .controllPageTextSize.value,
                                          // ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              verticalLine,
                              //라이트 테마.
                              InkWell(
                                onTap: () {
                                  controller.lightModeOn();
                                },
                                child: AnimatedContainer(
                                  curve: Curves.easeIn,
                                  duration: Duration(milliseconds: 100),
                                  width: controller
                                          .controllPageShortContainerX.value *
                                      0.46,
                                  height: controller
                                          .controllPageShortContainerX.value *
                                      0.6,
                                  decoration: BoxDecoration(
                                    color: controller.isDarkModeOn.value == true
                                        ? subDark
                                        : subLight,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 7,
                                      ),
                                      controller.useDeviceTheme.value == true
                                          ? Expanded(
                                              child: Icon(
                                                Icons.light_mode,
                                                color: controller.isDarkModeOn
                                                            .value ==
                                                        true
                                                    ? iconDark
                                                    : iconLight,
                                              ),
                                            )
                                          : Expanded(
                                              child: Icon(
                                                Icons.light_mode,
                                                color: controller.isDarkModeOn
                                                            .value ==
                                                        true
                                                    ? iconDark
                                                    : seletedThemeIcon,
                                              ),
                                            ),
                                      Expanded(
                                        child: Text(
                                          'Light'.tr,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              verticalLine,
                              //다크 테마.
                              InkWell(
                                onTap: () {
                                  controller.darkModeOn();
                                },
                                child: AnimatedContainer(
                                  curve: Curves.easeIn,
                                  duration: Duration(milliseconds: 100),
                                  width: controller
                                          .controllPageShortContainerX.value *
                                      0.46,
                                  height: controller
                                          .controllPageShortContainerX.value *
                                      0.6,
                                  decoration: BoxDecoration(
                                    color: controller.isDarkModeOn.value == true
                                        ? subDark
                                        : subLight,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 7,
                                      ),
                                      controller.useDeviceTheme.value == true
                                          ? Expanded(
                                              child: Icon(
                                                Icons.dark_mode,
                                                color: controller.isDarkModeOn
                                                            .value ==
                                                        true
                                                    ? iconDark
                                                    : iconLight,
                                              ),
                                            )
                                          : Expanded(
                                              child: Icon(
                                                Icons.dark_mode,
                                                color: controller.isDarkModeOn
                                                            .value ==
                                                        false
                                                    ? iconLight
                                                    : seletedThemeIcon,
                                              ),
                                            ),
                                      Expanded(
                                        child: Text(
                                          'Dark'.tr,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed('/tags');
                          },
                          child: Obx(
                            () => Center(
                              child: AnimatedContainer(
                                curve: Curves.easeIn,
                                duration: Duration(milliseconds: 100),
                                width: controller
                                    .controllPageShortContainerX.value,
                                height: controller
                                        .controllPageShortContainerY.value *
                                    1.1,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AnimatedContainer(
                                        curve: Curves.easeIn,
                                        duration: Duration(milliseconds: 100),
                                        width: controller
                                                .controllPageShortContainerX
                                                .value *
                                            0.46,
                                        height: controller
                                                .controllPageShortContainerX
                                                .value *
                                            0.46,
                                        decoration: BoxDecoration(
                                          color:
                                              controller.isDarkModeOn.value ==
                                                      true
                                                  ? subDark
                                                  : subLight,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Center(
                                          child: Stack(
                                            children: [
                                              //태그버튼 내부 원모양 디자인 Ui 1.
                                              Positioned(
                                                left: 12,
                                                bottom: 12,
                                                child: AnimatedContainer(
                                                  curve: Curves.easeIn,
                                                  duration: Duration(
                                                      milliseconds: 200),
                                                  width: controller
                                                          .controllPageShortContainerX
                                                          .value *
                                                      0.2,
                                                  height: controller
                                                          .controllPageShortContainerX
                                                          .value *
                                                      0.2,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: controller
                                                                .isDarkModeOn
                                                                .value ==
                                                            true
                                                        ? iconDark
                                                        : iconLight,
                                                  ),
                                                ),
                                              ),
                                              //태그버튼 내부 원모양 디자인 Ui 2.
                                              Positioned(
                                                right: 12,
                                                top: 12,
                                                child: AnimatedContainer(
                                                  curve: Curves.easeIn,
                                                  duration: Duration(
                                                      milliseconds: 200),
                                                  width: controller
                                                          .controllPageShortContainerX
                                                          .value *
                                                      0.2,
                                                  height: controller
                                                          .controllPageShortContainerX
                                                          .value *
                                                      0.2,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: controller
                                                                .isDarkModeOn
                                                                .value ==
                                                            true
                                                        ? backgroundDark
                                                        : backgroundLight,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Obx(
                                        () => AnimatedContainer(
                                          curve: Curves.easeIn,
                                          duration: Duration(milliseconds: 200),
                                          child: Text(
                                            'Tags'.tr,
                                            style: TextStyle(
                                              fontSize: controller
                                                  .controllPageTextSize.value,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: controller.isDarkModeOn.value == true
                                      ? backgroundDark.withOpacity(controller
                                          .controllPageContainerOpacity.value)
                                      : backgroundLight.withOpacity(controller
                                          .controllPageContainerOpacity.value),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          controller.isDarkModeOn.value == true
                                              ? shadowDark
                                              : shadowLight,
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 7), // changes position of shadow
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: controller.width.value * 0.05,
                        ),
                        InkWell(
                          onTap: () async {
                            await controller.refreshDeletedMemo();
                            await controller.trashViewCheckClear();
                            Get.toNamed('/trash');
                          },
                          child: Obx(
                            () => Center(
                              child: AnimatedContainer(
                                curve: Curves.easeIn,
                                duration: Duration(milliseconds: 200),
                                width: controller
                                    .controllPageShortContainerX.value,
                                height: controller
                                        .controllPageShortContainerY.value *
                                    1.1,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AnimatedContainer(
                                        curve: Curves.easeIn,
                                        duration: Duration(milliseconds: 200),
                                        width: controller
                                                .controllPageShortContainerX
                                                .value *
                                            0.46,
                                        height: controller
                                                .controllPageShortContainerX
                                                .value *
                                            0.46,
                                        decoration: BoxDecoration(
                                          color:
                                              controller.isDarkModeOn.value ==
                                                      true
                                                  ? subDark
                                                  : subLight,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Icon(
                                          Icons.delete_outline,
                                          size: controller
                                              .controllPageIconSize.value,
                                        ),
                                      ),
                                      Obx(
                                        () => AnimatedContainer(
                                          curve: Curves.easeIn,
                                          duration: Duration(milliseconds: 300),
                                          child: Text(
                                            'Deleted Memo'.tr,
                                            style: TextStyle(
                                              fontSize: controller
                                                  .controllPageTextSize.value,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: controller.isDarkModeOn.value == true
                                      ? backgroundDark.withOpacity(controller
                                          .controllPageContainerOpacity.value)
                                      : backgroundLight.withOpacity(controller
                                          .controllPageContainerOpacity.value),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          controller.isDarkModeOn.value == true
                                              ? shadowDark
                                              : shadowLight,
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 7), // changes position of shadow
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //메뉴 4번째 라인.
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //locale
                        InkWell(
                          onTap: () {
                            Get.toNamed('/locale');
                          },
                          child: Obx(
                            () => Center(
                              child: AnimatedContainer(
                                curve: Curves.easeIn,
                                duration: Duration(milliseconds: 100),
                                width: controller
                                    .controllPageShortContainerX.value,
                                height: controller
                                        .controllPageShortContainerY.value *
                                    1.1,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AnimatedContainer(
                                        curve: Curves.easeIn,
                                        duration: Duration(milliseconds: 100),
                                        width: controller
                                                .controllPageShortContainerX
                                                .value *
                                            0.46,
                                        height: controller
                                                .controllPageShortContainerX
                                                .value *
                                            0.46,
                                        decoration: BoxDecoration(
                                          color:
                                              controller.isDarkModeOn.value ==
                                                      true
                                                  ? subDark
                                                  : subLight,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Center(
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 16,
                                                bottom: 16,
                                                child: Text(
                                                  '한',
                                                  style: TextStyle(
                                                    fontSize: controller
                                                            .controllPageTextSize
                                                            .value *
                                                        1.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: controller
                                                                .isDarkModeOn
                                                                .value ==
                                                            true
                                                        ? backgroundDark
                                                        : backgroundLight,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 16,
                                                top: 16,
                                                child: Text(
                                                  'A',
                                                  style: TextStyle(
                                                    fontSize: controller
                                                            .controllPageTextSize
                                                            .value *
                                                        1.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: controller
                                                                .isDarkModeOn
                                                                .value ==
                                                            true
                                                        ? iconDark
                                                        : iconLight,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Obx(
                                        () => AnimatedContainer(
                                          curve: Curves.easeIn,
                                          duration: Duration(milliseconds: 200),
                                          child: Text(
                                            'Fonts & Locale'.tr,
                                            style: TextStyle(
                                              fontSize: controller
                                                  .controllPageTextSize.value,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: controller.isDarkModeOn.value == true
                                      ? backgroundDark.withOpacity(controller
                                          .controllPageContainerOpacity.value)
                                      : backgroundLight.withOpacity(controller
                                          .controllPageContainerOpacity.value),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          controller.isDarkModeOn.value == true
                                              ? shadowDark
                                              : shadowLight,
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 7), // changes position of shadow
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: controller.width.value * 0.05,
                        ),
                        InkWell(
                          onTap: () async {
                            Get.toNamed('/info');
                          },
                          child: Obx(
                            () => Center(
                              child: AnimatedContainer(
                                curve: Curves.easeIn,
                                duration: Duration(milliseconds: 200),
                                width: controller
                                    .controllPageShortContainerX.value,
                                height: controller
                                        .controllPageShortContainerY.value *
                                    1.1,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AnimatedContainer(
                                        curve: Curves.easeIn,
                                        duration: Duration(milliseconds: 200),
                                        width: controller
                                                .controllPageShortContainerX
                                                .value *
                                            0.46,
                                        height: controller
                                                .controllPageShortContainerX
                                                .value *
                                            0.46,
                                        decoration: BoxDecoration(
                                          color:
                                              controller.isDarkModeOn.value ==
                                                      true
                                                  ? subDark
                                                  : subLight,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Icon(
                                          Icons.code,
                                          size: controller
                                              .controllPageIconSize.value,
                                        ),
                                      ),
                                      Obx(
                                        () => AnimatedContainer(
                                          curve: Curves.easeIn,
                                          duration: Duration(milliseconds: 300),
                                          child: Text(
                                            'Application Info'.tr,
                                            style: TextStyle(
                                              fontSize: controller
                                                  .controllPageTextSize.value,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: controller.isDarkModeOn.value == true
                                      ? backgroundDark.withOpacity(controller
                                          .controllPageContainerOpacity.value)
                                      : backgroundLight.withOpacity(controller
                                          .controllPageContainerOpacity.value),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          controller.isDarkModeOn.value == true
                                              ? shadowDark
                                              : shadowLight,
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: Offset(
                                        0,
                                        7,
                                      ), // changes position of shadow
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
}
