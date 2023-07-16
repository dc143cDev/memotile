import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';

import '../../../global/memo_tile_deleted.dart';

class TrashView extends GetView<HomeController> {
  const TrashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        centerTitle: true,
      ),
      body: Obx(
        () => SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: ListView.builder(
                  shrinkWrap: true,
                  reverse: false,
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: controller.scrollController.value,
                  itemCount: controller.deletedMemo.length,
                  itemBuilder: (context, index) {
                    return MemoTileDeleted(
                      //memo_tile ui 에 들어갈 각 객체를 index 와 column 값을 넣어 구성.
                      id: controller.deletedMemo[index]['id'],
                      text: controller.deletedMemo[index]['content'],
                      createdAt: controller.deletedMemo[index]['createdAt'],
                      isEditChecked: controller.deletedMemo[index]
                          ['isEditChecked'],
                      date: controller.deletedMemo[index]['dateData'],
                      isFirst: controller.deletedMemo[index]['isFirst'],
                      isDeleted: controller.deletedMemo[index]['isDeleted'],
                      colorValue: controller.deletedMemo[index]['colorValue'],
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
