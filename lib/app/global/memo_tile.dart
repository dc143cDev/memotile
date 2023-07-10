import 'package:flutter/material.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:get/get.dart';
import 'package:memotile/app/global/memo.dart';

import 'package:memotile/app/modules/home/controllers/home_controller.dart';

class MemoTile extends GetView<HomeController> {
  const MemoTile(
      {Key? key,
      this.id,
      this.text,
      this.createdAt,
      this.date,
      this.isFirst,
      this.isEditChecked,
      this.isDeleted,
      this.colorValue})
      : super(key: key);

  final int? id;
  final String? text;
  final String? createdAt;
  final String? date;
  final int? isFirst;
  final int? isEditChecked;
  final int? isDeleted;
  final int? colorValue;

  @override
  Widget build(BuildContext context) {
    final memo = Obx(
      () => Flexible(
        child: Column(
          children: [
            isFirst == 1
                ? SizedBox(
                    height: 5,
                  )
                : SizedBox(),
            //해당 날짜의 첫번째 메모라면 위에 날짜 표시줄 생성.
            isFirst == 1
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          width: 200,
                          height: 30,
                          decoration: BoxDecoration(
                            color: controller.isDarkModeOn.value == true
                                ? Colors.grey[800]
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                createdAt!,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            //왜인지 타일의 텍스트가 길면 날짜 표시줄과 간격이 벌어지지 않음. 임의로 작성.
            // text!.length >= 30
            //     ? SizedBox(
            //         height: 15,
            //       )
            //     : Container(),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    controller.isEditMode.value == true
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 0, bottom: 8, top: 8, right: 10),
                            child: Align(
                              child: InkWell(
                                onTap: () async {
                                  if (isEditChecked == 1) {
                                    print('iseidt: ${isEditChecked}');
                                    await MemoHelper.updateItemForEdit(
                                        id!, 0);
                                    controller.refreshMemo();
                                  } else {
                                    print('iseidt: ${isEditChecked}');
                                    await MemoHelper.updateItemForEdit(
                                        id!, 1);
                                    controller.refreshMemo();
                                  }
                                },
                                child: SizedBox(
                                  height: 30,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[400],
                                    child: SizedBox(
                                      height: 22,
                                      child: isEditChecked == 1
                                          ? CircleAvatar(
                                              backgroundColor:
                                                  Colors.grey[400],
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.white,
                                              ),
                                            )
                                          : CircleAvatar(
                                              backgroundColor:
                                                  Colors.grey[400],
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    Flexible(
                      child: InkWell(
                        onLongPress: () {
                          controller.isEditMode.value = true;
                          controller.isMemoTileShake.value = true;
                          // controller.colorValue.value = colorValue!;
                          // //홈 화면의 메모 타일의 데이터가 상세 페이지로 옮겨지는 과정 - 1.
                          // //이 파트에서 goToDetail 로 네가지 arguments 를 전달.
                          // print(createdAt);
                          // controller.goToDetail(id!, text!, date!, colorValue!);
                        },
                        child: ShakeWidget(
                          //에딧모드 진입시 흔들리는 애니메이션.
                          //패키지가 구형이므로 미지원 상정해야함.
                          autoPlay: controller.isMemoTileShake.value,
                          duration: Duration(seconds: 7),
                          shakeConstant: ShakeLittleConstant1(),
                          child: Container(
                            padding: EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
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
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, top: 20, right: 7, bottom: 12),
                      child: Text(
                        date!,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ],
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
                      height: 30,
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
