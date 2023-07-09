import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';

class ControlView extends GetView<HomeController> {
  const ControlView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: const Text('ControlView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ControlView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
