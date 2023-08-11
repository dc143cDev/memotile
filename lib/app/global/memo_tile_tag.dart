import 'package:flutter/material.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:get/get.dart';
import 'package:memotile/app/global/memo.dart';
import 'package:memotile/app/global/palette.dart';

import 'package:memotile/app/modules/home/controllers/home_controller.dart';

//캘린더에서 테크모드로 조회시 빌드될 메모타일.
//차이점은 위에 날짜표시줄과 옆에 시간표시가 없다는 것.

class MemoTileTag extends GetView<HomeController> {
  const MemoTileTag(
      {Key? key,
      this.id,
      this.text,
      this.date,
      this.isEditChecked,
      this.isDeleted,
      this.colorValue})
      : super(key: key);

  final int? id;
  final String? text;
  final String? date;
  final int? isEditChecked;
  final int? isDeleted;
  final int? colorValue;

  @override
  Widget build(BuildContext context) {
    final memo = Obx(
      () => Flexible(
        child: Column(
          children: [
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset.zero,
                end: Offset(0.2, 0.0),
              ).animate(
                CurvedAnimation(
                  parent: controller.memoTileAnimationController,
                  curve: Curves.easeIn,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  controller.isEditMode.value == true
                      ? Padding(
                          padding: const EdgeInsets.only(
                            left: 0,
                            bottom: 8,
                            top: 8,
                            right: 10,
                          ),
                          child: Align(
                            child: InkWell(
                              onTap: () async {
                                if (isEditChecked == 1) {
                                  print('iseidt: ${isEditChecked}');
                                  await MemoHelper.updateItemForEdit(id!, 0);
                                  controller.refreshMemo();
                                } else {
                                  print('iseidt: ${isEditChecked}');
                                  await MemoHelper.updateItemForEdit(id!, 1);
                                  controller.refreshMemo();
                                }
                              },
                              child: Obx(
                                //체크박스
                                () => AnimatedContainer(
                                  curve: Curves.fastOutSlowIn,
                                  duration: Duration(seconds: 1),
                                  width: controller.editModeCheckBoxX.value,
                                  height: controller.editModeCheckBoxY.value,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: controller.isDarkModeOn.value == true
                                        ? subDark
                                        : subLight,
                                  ),
                                  child: isEditChecked == 1
                                      ? Icon(
                                          Icons.check,
                                          color:
                                              controller.isDarkModeOn.value ==
                                                      true
                                                  ? iconDark
                                                  : iconLight,
                                        )
                                      : Container(),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  Flexible(
                    child: InkWell(
                      child: ShakeWidget(
                        //에딧모드 진입시 흔들리는 애니메이션.
                        //패키지가 구형이므로 미지원 상정해야함.
                        //흔들리는 애니메이션은 에딧모드에서 선택됐을때만.
                        autoPlay: isEditChecked == 1 ? true : false,
                        duration: Duration(seconds: 4),
                        shakeConstant: ShakeLittleConstant1(),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: controller.isDarkModeOn.value == true
                                    ? shadowDark
                                    : shadowLight,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(8),
                            color: Color(colorValue!),
                          ),
                          child: Text(
                            text!,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //ui에 안닿게.
                  SizedBox(
                    width: controller.width * 0.12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    //deleted 된 상태라면 안보이게끔 함.
    return isDeleted == 1
        ? Container()
        : Padding(
            padding: EdgeInsets.only(right: 32, left: 18, top: 5, bottom: 5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 3,
                    ),
                    //최종적으로 감싸기.
                    memo,
                  ],
                ),
              ],
            ),
          );
  }
}
