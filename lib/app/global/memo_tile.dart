import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';

class MemoTile extends GetView<HomeController> {
  const MemoTile({Key? key, this.text, this.date}) : super(key: key);

  final String? text;
  final String? date;

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
                controller.memoLongClicked.value = true;
                controller.getOffset(controller.memoKey, text!);
              },
              child: Obx(
                () => Stack(
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
                        color: Colors.white,
                      ),
                      child: Text(
                        text!,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: controller.memoLongClicked.value == false
                            ? Colors.transparent
                            : Colors.grey[100]?.withOpacity(0.4),
                      ),
                      child: Text(
                        text!,
                        style: TextStyle(color: Colors.transparent),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return Padding(
      padding: EdgeInsets.only(right: 18, left: 0, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 30,
          ),
          memo,
        ],
      ),
    );
  }
}
