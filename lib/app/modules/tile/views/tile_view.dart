import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:memotile/app/global/marker_tile.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';
import 'package:table_calendar/table_calendar.dart';

//TileController 로 했을때 날짜 검색기능이 작동하지 않는 이슈가 있음.
class TileView extends GetView<HomeController> {
  const TileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
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
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Obx(
          ()=> Text(
            //CurrentMonthForTile 의 초기 값은 '' 이므로 평소에는 타이틀에 아무 값도 나오지 않음.
            //때문에 값이 '' 일때는 HomeView 에서 가져온 월을 먼저 표시하고,
            //페이지가 전환되어 데이터가 생기면 그때부터 CurrentMonthForTile 로 표기.
            controller.CurrentMonthForTile.value == '' ?
            '${Get.arguments['TileMonth']}' :
            controller.CurrentMonthForTile.value,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: TableCalendar(
                calendarBuilders: CalendarBuilders(
                  //마커 타일 빌더.
                  //context 와 날짜(년월일시분초까지 다 표시되는 버전), event(List)를 넘겨줄수 있음.
                  markerBuilder: (context, day, events){
                    //events 의 원형은 [ 단일객체 ] (length == 1) 이기때문에 두번 걸러 리스트화 해야함.
                    //to String,
                    String eventToString = events.toString();
                    //jsonDecode from String to List.
                    List stringEventToList = jsonDecode(eventToString);
                    if(events.isNotEmpty == true){
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
                  }
                  // markerBuilder: (context, day, events) => events.isNotEmpty
                  //     ? Center(
                  //       child: MarKerTile(
                  //           date: '',
                  //           //리스트 객체의 첫번째를 색상 값으로 가져옴.
                  //           event: DateFormat('dd').format(day),
                  //           color: jsonDecode(events.toString()),
                  //           // color: int.parse(events.last.toString().replaceAll(',', ']')),
                  //         ),
                  //     )
                  //     : null,
                ),
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
                onPageChanged: (day){
                  //페이지 전환할때마다 값을 지금이 몇월인지 값 넘겨주기.
                  controller.CurrentMonthForTile.value = DateFormat('MMM').format(day);
                },
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: [

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
