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
      decoration: BoxDecoration(color: Color(color)),
      child: Column(
        children: [
          Text(date),
          Text(event),
        ],
      ),
    );
  }
}
