import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../global/memo_tile.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Day',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Obx(
                () => Container(
                  child: ListView.builder(
                    itemCount: controller.list.length,
                    itemBuilder: (BuildContext b, int index) {
                      return MemoTile(
                        text: controller.list[index],
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.memoController,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.list
                            .add(controller.memoController.value.text);
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
