import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';

class MarKerTile extends GetView<HomeController> {
  const MarKerTile({
    Key? key,
    required this.date,
    required this.event,
    required this.color,
  }) : super(key: key);

  final String date;
  final String event;
  final int color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              blurRadius: 5.0,
              spreadRadius: 0.0,
              offset: Offset(0, 7),
            )
          ],
          color: Color(color), borderRadius: BorderRadius.circular(50)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(event),
          ],
        ),
      ),
    );
  }
}
