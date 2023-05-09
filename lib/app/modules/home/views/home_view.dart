import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:memotile/app/modules/tile/views/tile_view.dart';

import '../../../global/memo_tile.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.to(TileView());
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
                SizedBox(
                  width: 0,
                ),
                Expanded(
                  child: Obx(
                    () => Text(
                      controller.CurrentMonth.value,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Obx(
          () => Text(
            controller.CurrentDay.value,
            style: TextStyle(color: Colors.black),
          ),
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
                    itemCount: controller.MemoList.length,
                    itemBuilder: (BuildContext b, int index) {
                      return MemoTile(
                        text: controller.MemoList[index],
                        date: controller.DateList[index],
                        // date: controller.DateList[index],
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
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: TextFormField(
                          controller: controller.memoController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusColor: Colors.black,
                              hintText: ' Insert here'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0, top: 5, right: 14, bottom: 5),
                      child: IconButton(
                        onPressed: () {
                          controller.MemoList.add(
                              controller.memoController.value.text);
                          controller.getCurrentDate();
                        },
                        icon: Icon(Icons.add),
                      ),
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
