import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../global/memo.dart';

class HomeController extends GetxController {

  //가장 중요한 변수. 여기에 모든 db 의 data 가 담김.
  //
  RxList memo = [].obs;

  //클릭 감지.
  RxBool memoLongClicked = false.obs;

  //insert here.
  TextEditingController memoController = TextEditingController();

  //로딩.
  RxBool isLoading = true.obs;


  //date PART
  //날짜 정보를 받아오기 위한 RxString.
  RxString CurrentDate = ''.obs;
  RxString CurrentDay = ''.obs;
  RxString CurrentMonth = ''.obs;

  //메모 왼쪽에 표시될 작성 시간을 가져옵니다.
  getCurrentDate() {
    CurrentDate.value = DateFormat("hh:mm a").format(DateTime.now());
  }

  //앱바 상단에 위치할 날짜를 가져옵니다.
  getCurrentDay() {
    CurrentDay.value = DateFormat("MM-dd").format(DateTime.now());
  }

  //appBar 의 Leading 에 들어갈 월.
  getCurrentMonth() {
    CurrentMonth.value = DateFormat("MMM").format(DateTime.now());
  }


  //color palette PART
  //가변적으로 변하는 RxInt 변수와, flutter ui 의 Color 를 int 로 저장할 수 있는 변수들.
  RxInt colorValue = 0.obs;
  int whiteValue = Colors.white.value;
  int redValue = Colors.red.value;

  getDefaultColor(){
    colorValue.value = whiteValue;
  }

  getRed(){
    colorValue.value = redValue;
  }

  //DB PART
  //새로고침.
  //MemoHelper 에서 아이템을 추가하거나 업데이트하면 실행됨.
  //최상단의 memo RxList 를 db 의 데이터를 가져온 data 내부 변수로 저장함.
  //실질적 db 데이터인 data = ui 에 표시되기 위한 데이터 List 인 memo.
  refreshMemo() async {
    final data = await MemoHelper.getItems();
    memo.value = data;
    isLoading.value = false;
  }

  //C
  Future<void> addItem() async {
    await MemoHelper.createItem(memoController.text, CurrentDate.value.toString(), colorValue.value);
    refreshMemo();
  }

  //U
  Future<void> updateItem(int id) async {
    await MemoHelper.updateItem(id, memoController.text, colorValue.value);
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
    await getDefaultColor();
    await getCurrentDay();
    await getCurrentMonth();
    refreshMemo();
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
