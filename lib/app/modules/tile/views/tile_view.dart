import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controllers/tile_controller.dart';

class TileView extends GetView<TileController> {
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
                // SizedBox(
                //   width: 0,
                // ),
                // Expanded(
                //   child: Text(
                //     '${Get.arguments['TileDay']}',
                //     style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         color: Colors.black,
                //         fontSize: 13),
                //   ),
                // ),
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
              headerStyle: HeaderStyle(
                titleTextStyle: TextStyle(color: Colors.white),
                titleCentered: true,
                leftChevronVisible: false,
                rightChevronVisible: false,
                formatButtonVisible: false,
              ),
              focusedDay: DateTime.now(),
              firstDay: DateTime(2023, 5, 1),
              lastDay: DateTime(2023, 12, 31),
            ),
          ],
        ),
      ),
    );
  }
}
