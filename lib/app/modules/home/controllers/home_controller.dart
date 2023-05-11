import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  GlobalKey memoKey = GlobalKey();
  // List<GlobalObjectKey> memoKey =
  //     List.generate(5, (index) => GlobalObjectKey(index));
  RxDouble? x = 0.0.obs;
  RxDouble? y = 0.0.obs;

  RxList MemoList = [].obs;
  RxList DateList = [].obs;

  RxString CurrentDate = ''.obs;
  RxString CurrentDay = ''.obs;
  RxString CurrentMonth = ''.obs;

  RxBool memoLongClicked = false.obs;

  TextEditingController memoController = TextEditingController();

  //메모 왼쪽에 표시될 작성 시간을 가져옵니다.
  getCurrentDate() {
    CurrentDate.value = DateFormat("hh:mm a").format(DateTime.now());
    DateList.add(CurrentDate.value);
  }

  //앱바 상단에 위치할 날짜를 가져옵니다.
  getCurrentDay() {
    CurrentDay.value = DateFormat("MM-dd").format(DateTime.now());
  }

  getCurrentMonth() {
    CurrentMonth.value = DateFormat("MMM").format(DateTime.now());
  }

  void getOffset(Key key, String text) {
    // RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    // Offset? position = box?.localToGlobal(Offset.zero);
    // final sizeBox = box?.size;
    // if (position != null) {
    //   x?.value = position.dx;
    //   y?.value = position.dy;
    // print(x.toString());
    // print(y.toString());
    // print(sizeBox.toString());
    print(key);
    print(text);
    // }
  }

  @override
  void onInit() async {
    super.onInit();
    await getCurrentDay();
    await getCurrentMonth();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
