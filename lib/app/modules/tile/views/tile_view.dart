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
        title: Text(
          '${Get.arguments['TileMonth']}',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar(
              calendarBuilders: CalendarBuilders(
                //마커 타일 빌더.
                //context 와 날짜(년월일시분초까지 다 표시되는 버전), event(List)를 넘겨줄수 있음.
                markerBuilder: (context, day, events) => events.isNotEmpty
                    ? MarKerTile(
                        date: '',
                        //리스트 객체의 첫번째를 색상 값으로 가져옴.
                        event: DateFormat('dd').format(day),
                        color: int.parse(events.first.toString()),
                      )
                    : null,
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
              onDaySelected: (DateTime selectedDay, DateTime focusedDay) async {
                //DB 검색 용이성을 위해 미리 지정된 포맷으로 selectedDay 반환.
                await controller.goToTop();
                controller.selectedDay.value =
                    DateFormat("yyyyMMdd").format(selectedDay);
                print('$selectedDay is selected');
                print('$focusedDay is focused');
                print(controller.selectedDay);
                controller.refreshMemoByDateTile(controller.selectedDay);
                controller.dateButtonClicked();
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
