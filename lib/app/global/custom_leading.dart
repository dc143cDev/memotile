import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';

class CustomLeading extends StatelessWidget {
  const CustomLeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        HomeController().refreshMemo();
      },
    );
  }
}
