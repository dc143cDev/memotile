import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../global/memo.dart';

class HomeController extends GetxController {
  GlobalKey memoKey = GlobalKey();

  // List<GlobalObjectKey> memoKey =
  //     List.generate(5, (index) => GlobalObjectKey(index));
  RxList memo = [].obs;
  RxBool isLoading = true.obs;

  RxDouble? x = 0.0.obs;
  RxDouble? y = 0.0.obs;

  RxList MemoList = [].obs;
  RxList DateList = [].obs;

  RxString CurrentDate = ''.obs;
  RxString CurrentDay = ''.obs;
  RxString CurrentMonth = ''.obs;

  int whiteValue = Colors.white.value;

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

  refreshMemo() async {
    final data = await MemoHelper.getItems();
    memo.value = data;
    isLoading.value = false;
  }

  //C
  Future<void> addItem() async {
    await MemoHelper.createItem(memoController.text, CurrentDate.value.toString(), whiteValue);
    refreshMemo();
  }

  //U
  Future<void> updateItem(int id) async {
    await MemoHelper.updateItem(id, memoController.text, whiteValue);
    refreshMemo();
  }

  //D
  void deleteItem(int id) async {
    await MemoHelper.deleteItem(id);
    refreshMemo();
  }

  @override
  void onInit() async {
    super.onInit();
    await MemoHelper.db();
    refreshMemo();
    // await refreshMemo();
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
