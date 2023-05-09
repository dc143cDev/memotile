import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  RxList MemoList = [].obs;
  RxList DateList = [].obs;

  RxString CurrentDate = ''.obs;
  RxString CurrentDay = ''.obs;
  RxString CurrentMonth = ''.obs;

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
