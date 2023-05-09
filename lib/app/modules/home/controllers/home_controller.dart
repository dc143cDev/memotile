import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  RxList MemoList = [].obs;
  RxList DateList = [].obs;
  RxString CurrentDate = ''.obs;

  TextEditingController memoController = TextEditingController();

  getCurrentDate() {
    CurrentDate.value = DateFormat("hh:mm a").format(DateTime.now());
    DateList.add(CurrentDate.value);

    print(DateList.value.toString());
    print(CurrentDate.value);
  }

  @override
  void onInit() {
    super.onInit();
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
