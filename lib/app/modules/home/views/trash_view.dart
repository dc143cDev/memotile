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
          actions: controller.deletedMemo.isEmpty == true ||
              controller.isDeletedMemoLenghtSameWithHardDeletedMemoLenght
                  .value ==
                  true ? [] :[
            //휴지통 비우기.
            IconButton(
              onPressed: () {
                Get.defaultDialog(
                  titleStyle: TextStyle(fontWeight: FontWeight.bold),
                  title: 'Delete All Items'.tr,
                  content: Text(
                    'Are you sure you want to \npermanently delete all items?'.tr,
                  ),
                  contentPadding: EdgeInsets.all(8),
                  //취소.
                  cancel: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Cancel'.tr),
                  ),
                  //확인.
                  confirm: ElevatedButton(
                    onPressed: () async {
                      await controller.allTrashViewMemoInvisible();
                      Get.back();
                    },
                    child: Text(
                      'Confirm'.tr,
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
            'Deleted Memo'.tr,
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
              //삭제된 메모가 비어있다면 버튼 비활성화.
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: controller.deletedMemo.isEmpty == true ||
                  controller.isDeletedMemoLenghtSameWithHardDeletedMemoLenght
                      .value ==
                      true ? [
                ElevatedButton(
                  onPressed: () {

                  },
                  child: Text(
                    'Recover Memo'.tr,
                    style: TextStyle(
                      color: controller.isDarkModeOn == true ? shadowDark :Colors.grey[400],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {

                  },
                  child: Text(
                    'Hard Delete'.tr,
                    style: TextStyle(
                      color: controller.isDarkModeOn == true ? shadowDark :Colors.grey[400],
                    ),
                  ),
                ),
              ] :[
                ElevatedButton(
                  onPressed: () async {
                    await controller.trashViewCheckedMemoRecover();
                    await controller.refreshDeletedMemo();
                  },
                  child: Text(
                    'Recover Memo'.tr,
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
                    'Hard Delete'.tr,
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
          child: controller.deletedMemo.isEmpty == true ||
                  controller.isDeletedMemoLenghtSameWithHardDeletedMemoLenght
                          .value ==
                      true
              ? Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Obx(
                          () => SizedBox(
                            height: controller.height * 0.6,
                            width: controller.width * 0.6,
                            child: Center(
                              child: Stack(
                                children: [
                                  Center(
                                    child: Icon(
                                      Icons.delete,
                                      size: controller.width * 0.6,
                                      color:
                                          controller.isDarkModeOn.value == true
                                              ? backgroundDark
                                              : backgroundLight,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Deleted Memo\nis Empty'.tr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: controller.isDarkModeOn.value ==
                                                true
                                            ? subDark
                                            : subLight,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
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
                                createdAt: controller.deletedMemo[index]
                                    ['createdAt'],
                                isDeleteChecked: controller.deletedMemo[index]
                                    ['isDeleteChecked'],
                                date: controller.deletedMemo[index]['dateData'],
                                isDeleted: controller.deletedMemo[index]
                                    ['isDeleted'],
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
