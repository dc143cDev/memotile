import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';

class MarKerTile extends GetView<HomeController> {
  const MarKerTile({
    Key? key,
    required this.date,
    required this.event,
    required this.colorList,
    required this.color,
  }) : super(key: key);

  final String date;
  final String event;
  final List colorList;
  final int color;

  @override
  Widget build(BuildContext context) {
    print('date: ${event}');
    print('colorList: ${colorList}');
    if (colorList.length == 1) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 7,
              width: 12,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    offset: Offset(0, 4),
                  )
                ],
                  color: Color(colorList[0]),
                  borderRadius: BorderRadius.circular(10),),
            ),
          ],
        ),
      );
    } else if (colorList.length == 2) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 7,
              width: 12,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    offset: Offset(0, 4),
                  )
                ],
                color: Color(colorList[0]),
                borderRadius: BorderRadius.circular(10),),
            ),
            Container(
              height: 7,
              width: 12,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    offset: Offset(0, 4),
                  )
                ],
                color: Color(colorList[1]),
                borderRadius: BorderRadius.circular(10),),
            ),
          ],
        ),
      );
    } else if (colorList.length == 3) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 7,
              width: 12,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    offset: Offset(0, 4),
                  )
                ],
                color: Color(colorList[0]),
                borderRadius: BorderRadius.circular(10),),
            ),
            Container(
              height: 7,
              width: 12,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    offset: Offset(0, 4),
                  )
                ],
                color: Color(colorList[1]),
                borderRadius: BorderRadius.circular(10),),
            ),
            Container(
              height: 7,
              width: 12,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    offset: Offset(0, 4),
                  )
                ],
                color: Color(colorList[2]),
                borderRadius: BorderRadius.circular(10),),
            ),
          ],
        ),
      );
    } else if (colorList.length >= 4) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 7,
              width: 12,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    offset: Offset(0, 4),
                  )
                ],
                color: Color(colorList[0]),
                borderRadius: BorderRadius.circular(10),),
            ),
            Container(
              height: 7,
              width: 12,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    offset: Offset(0, 4),
                  )
                ],
                color: Color(colorList[1]),
                borderRadius: BorderRadius.circular(10),),
            ),
            Container(
              height: 7,
              width: 12,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    offset: Offset(0, 4),
                  )
                ],
                color: Color(colorList[2]),
                borderRadius: BorderRadius.circular(10),),
            ),
            Container(
              height: 7,
              width: 12,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    offset: Offset(0, 4),
                  )
                ],
                color: Color(colorList[3]),
                borderRadius: BorderRadius.circular(10),),
            ),
          ],
        ),
      );
    } else if (1 >= colorList.length) {
      return Container();
    } else {
      return Container();
    }
  }
}
