import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:memotile/app/global/palette.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';

import '../../../global/memo_tile_deleted.dart';

class TrashView extends GetView<HomeController> {
  const TrashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            controller.isDarkModeOn.value == true ? subDark : subLight,
        appBar: AppBar(
          actions: [
            //휴지통 비우기.
            IconButton(
              onPressed: () {
                Get.defaultDialog(
                  title: 'Delete All Items',
                  content: Text(
                    'Are you sure you want to \npermanently delete all items?',
                  ),
                  contentPadding: EdgeInsets.all(8),
                  //취소.
                  cancel: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Cancel'),
                  ),
                  //확인.
                  confirm: ElevatedButton(
                    onPressed: () async{
                      await controller.allTrashViewMemoInvisible();
                      Get.back();
                    },
                    child: Text(
                      'Confrim',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
            ),
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () async {
              //체크된 항목들 체크해제.
              await controller.trashViewCheckClear();
              //페이지에서 나갈때 표면적 삭제되었던 메모들 영구삭제.
              await controller.trashViewCheckedMemoHardDelete();
              Get.back();
            },
          ),
          title: Text(
            'Deleted Memo',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor:
              controller.isDarkModeOn.value == true ? subDark : subLight,
          centerTitle: false,
        ),
        bottomNavigationBar: Obx(
          () => BottomAppBar(
            height: controller.height.value * 0.12,
            elevation: 0,
            shadowColor: controller.isDarkModeOn.value == true
                ? shadowDark
                : shadowLight,
            surfaceTintColor: null,
            color: controller.isDarkModeOn.value == true
                ? backgroundDark
                : backgroundLight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await controller.trashViewCheckedMenoRecover();
                    await controller.refreshDeletedMemo();
                  },
                  child: Text(
                    'Recover Memo',
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await controller.trashViewCheckedMemoInvisible();
                    await controller.refreshDeletedMemo();
                  },
                  child: Text(
                    'Hard Delete',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: controller.deletedMemo.isEmpty == true || controller.isDeletedMemoLenghtSameWithHardDeletedMemoLenght.value == true ? Column(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Obx(
                        () => Text(
                      'empty',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 31,
                        color: controller.isDarkModeOn.value ==
                            true
                            ? iconDark
                            : iconLight,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: SizedBox(),
              ),
              //textField. empty 상태일때 굳이 필요 없다고 판단.
            ],
          ) :Column(
            children: [
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    reverse: false,
                    physics: AlwaysScrollableScrollPhysics(),
                    controller: controller.scrollController.value,
                    itemCount: controller.deletedMemo.length,
                    itemBuilder: (context, index) {
                      return Obx(
                        () => MemoTileDeleted(
                          //memo_tile ui 에 들어갈 각 객체를 index 와 column 값을 넣어 구성.
                          id: controller.deletedMemo[index]['id'],
                          text: controller.deletedMemo[index]['content'],
                          createdAt: controller.deletedMemo[index]['createdAt'],
                          isDeleteChecked: controller.deletedMemo[index]
                              ['isDeleteChecked'],
                          date: controller.deletedMemo[index]['dateData'],
                          isFirst: controller.deletedMemo[index]['isFirst'],
                          isDeleted: controller.deletedMemo[index]['isDeleted'],
                          isHardDeleted: controller.deletedMemo[index]
                              ['isHardDeleted'],
                          colorValue: controller.deletedMemo[index]
                              ['colorValue'],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
