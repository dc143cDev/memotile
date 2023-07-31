import 'package:get/get.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

class DefaultDay extends GetView<HomeController> {
  const DefaultDay({
    Key? key,
    this.dateValue,
    this.emptyCheck,
  }) : super(key: key);

  final String? dateValue;
  final String? emptyCheck;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        dateValue!,
        style:
            emptyCheck == 'false' ? TextStyle(color: Colors.grey) : TextStyle(),
      ),
    );
  }
}
