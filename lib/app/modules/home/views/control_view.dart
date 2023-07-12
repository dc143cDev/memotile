import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../global/marker_tile.dart';

class ControlView extends GetView<HomeController> {
  const ControlView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final verticalLine = Container(
      width: 2,
      height: controller.controllPageLongContainerVerticalLine.value,
      color: Colors.grey[200],
    );

    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.close,
          color: Colors.white,
        ),
        backgroundColor: Colors.grey[400],
        onPressed: () {
          // controller.getControllPageContainer();
          controller.pageController.animateToPage(0,
              duration: Duration(milliseconds: 300), curve: Curves.easeIn);
        },
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
                SafeArea(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        height: controller.width.value * 1,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 10), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
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
                                  List stringEventToList =
                                      jsonDecode(eventToString);
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
                                  titleTextStyle:
                                      TextStyle(color: Colors.white),
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
                                  // controller.goToDown();
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
                  ),
                ),
                //알람 센터.
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
                        color: Colors.white.withOpacity(
                            controller.controllPageContainerOpacity.value),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 10), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  width: controller.controllPageLongContainerSubBox.value,
                                  height: controller.controllPageLongContainerSubBox.value,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey[300],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.7),
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 7), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '1',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ],
                            ),
                            verticalLine,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  width: controller.controllPageLongContainerSubBox.value,
                                  height: controller.controllPageLongContainerSubBox.value,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey[300],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.7),
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 7), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '1',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ],
                            ),
                            verticalLine,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  width: controller.controllPageLongContainerSubBox.value,
                                  height: controller.controllPageLongContainerSubBox.value,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey[300],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.7),
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 7), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '1',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                //
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                        () => Center(
                          child: AnimatedContainer(
                            curve: Curves.easeIn,
                            duration: Duration(milliseconds: 240),
                            width: controller.controllPageShortContainerX.value,
                            height:
                                controller.controllPageShortContainerY.value,
                            child: Text('태그설정'),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white.withOpacity(controller
                                  .controllPageContainerOpacity.value),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 10), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Obx(
                          () => Center(
                            child: AnimatedContainer(
                              curve: Curves.easeIn,
                              duration: Duration(milliseconds: 300),
                              width:
                                  controller.controllPageShortContainerX.value,
                              height:
                                  controller.controllPageShortContainerY.value,
                              child: Text('쓰레기통'),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white.withOpacity(controller
                                    .controllPageContainerOpacity.value),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 10), // changes position of shadow
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
    );
  }
}
