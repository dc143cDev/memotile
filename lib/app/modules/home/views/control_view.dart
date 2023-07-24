import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:memotile/app/global/palette.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../global/marker_tile.dart';

class ControlView extends GetView<HomeController> {
  const ControlView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final verticalLine = Obx(
    //   () => AnimatedContainer(
    //     duration: Duration(milliseconds: 100),
    //     width: 2,
    //     height: controller.controllPageLongContainerVerticalLine.value,
    //     color: Colors.grey[200],
    //   ),
    // );

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
                                //DB 검색 용이성을 위해 미리 지정된 포맷으로 selectedDay 반환.
                                // await controller.goToTop();
                                controller.selectedDay.value =
                                    DateFormat("yyyyMMdd").format(selectedDay);
                                print('$selectedDay is selected');
                                print('$focusedDay is focused');
                                print(controller.selectedDay);
                                controller.refreshMemoByDateTile(
                                    controller.selectedDay);
                                controller.dateButtonClicked();
                                controller.pageController.animateToPage(0,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeIn);
                                // controller.goToDown();
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
                        height: controller.controllPageLongContainerY.value,
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
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('설정에 맞게'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  controller.isDarkModeOn.value = false;
                                  Get.changeTheme(
                                      ThemeData.light(useMaterial3: true));
                                },
                                child: Text('화이트'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  controller.isDarkModeOn.value = true;
                                  Get.changeTheme(
                                      ThemeData.dark(useMaterial3: true));
                                },
                                child: Text('다크'),
                              ),

                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     AnimatedContainer(
                              //       duration: Duration(milliseconds: 300),
                              //       width: controller
                              //           .controllPageLongContainerSubBox.value,
                              //       height: controller
                              //           .controllPageLongContainerSubBox.value,
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(15),
                              //         color: Colors.grey[300],
                              //         boxShadow: [
                              //           BoxShadow(
                              //             color: Colors.grey.withOpacity(0.7),
                              //             spreadRadius: 2,
                              //             blurRadius: 4,
                              //             offset: Offset(
                              //                 0, 7), // changes position of shadow
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       height: 5,
                              //     ),
                              //     Text(
                              //       '최근 알림',
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.w600,
                              //         color: Colors.grey[900],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // verticalLine,
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     AnimatedContainer(
                              //       duration: Duration(milliseconds: 300),
                              //       width: controller
                              //           .controllPageLongContainerSubBox.value,
                              //       height: controller
                              //           .controllPageLongContainerSubBox.value,
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(15),
                              //         color: Colors.grey[300],
                              //         boxShadow: [
                              //           BoxShadow(
                              //             color: Colors.grey.withOpacity(0.7),
                              //             spreadRadius: 2,
                              //             blurRadius: 4,
                              //             offset: Offset(
                              //                 0, 7), // changes position of shadow
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       height: 5,
                              //     ),
                              //     Text(
                              //       '',
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.w600,
                              //         color: Colors.grey[900],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // verticalLine,
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     AnimatedContainer(
                              //       duration: Duration(milliseconds: 300),
                              //       width: controller
                              //           .controllPageLongContainerSubBox.value,
                              //       height: controller
                              //           .controllPageLongContainerSubBox.value,
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(15),
                              //         color: Colors.grey[300],
                              //         boxShadow: [
                              //           BoxShadow(
                              //             color: Colors.grey.withOpacity(0.7),
                              //             spreadRadius: 2,
                              //             blurRadius: 4,
                              //             offset: Offset(
                              //                 0, 7), // changes position of shadow
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       height: 5,
                              //     ),
                              //     Text(
                              //       '',
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.w600,
                              //         color: Colors.grey[900],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
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
                                duration: Duration(milliseconds: 240),
                                width: controller
                                    .controllPageShortContainerX.value,
                                height: controller
                                    .controllPageShortContainerY.value,
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
                                        child: Icon(Icons.tag),
                                      ),
                                      Obx(
                                        () => AnimatedContainer(
                                          curve: Curves.easeIn,
                                          duration: Duration(milliseconds: 50),
                                          child: Text(
                                            'Tags',
                                            style: TextStyle(
                                              fontSize: controller
                                                  .controlViewTextSize.value,
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
                            Get.toNamed('/trash');
                          },
                          child: Obx(
                            () => Center(
                              child: AnimatedContainer(
                                curve: Curves.easeIn,
                                duration: Duration(milliseconds: 100),
                                width: controller
                                    .controllPageShortContainerX.value,
                                height: controller
                                    .controllPageShortContainerY.value,
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
                                        child: Icon(Icons.delete_outline),
                                      ),
                                      Obx(
                                        () => AnimatedContainer(
                                          curve: Curves.easeIn,
                                          duration: Duration(milliseconds: 50),
                                          child: Text(
                                            'Deleted Memo',
                                            style: TextStyle(
                                              fontSize: controller
                                                  .controlViewTextSize.value,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
