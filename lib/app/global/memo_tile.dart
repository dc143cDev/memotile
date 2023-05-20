import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:memotile/app/global/memo.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';

class MemoTile extends GetView<HomeController> {
  const MemoTile({Key? key, this.id, this.text, this.date, this.colorValue})
      : super(key: key);

  final int? id;
  final String? text;
  final String? date;
  final int? colorValue;

  @override
  Widget build(BuildContext context) {
    final memo = Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 14, top: 18, right: 7, bottom: 12),
              child: Text(
                date!,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Flexible(
            child: InkWell(
              onLongPress: () {
                //홈 화면의 메모 타일의 데이터가 상세 페이지로 옮겨지는 과정 - 1.
                //이 파트에서 goToDetail 로 네가지 arguments 를 전달.
                controller.goToDetail(id!, text!, date!, colorValue!);
              },
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          blurRadius: 5.0,
                          spreadRadius: 0.0,
                          offset: Offset(0, 7),
                        )
                      ],
                      borderRadius: BorderRadius.circular(2),
                      color: Color(colorValue!),
                    ),
                    child: Text(
                      text!,
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(14),
                  //   decoration: BoxDecoration(
                  //     color: controller.memoLongClicked.value == false
                  //         ? Colors.transparent
                  //         : Colors.grey[100]?.withOpacity(0.4),
                  //   ),
                  //   child: Text(
                  //     text!,
                  //     style: TextStyle(color: Colors.transparent),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    return Form(
      child: Padding(
        padding: EdgeInsets.only(right: 18, left: 0, top: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 30,
            ),
            //최종적으로 감싸기.
            memo,
          ],
        ),
      ),
    );
  }
}
