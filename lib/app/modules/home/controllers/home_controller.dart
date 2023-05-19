import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../global/memo.dart';

class HomeController extends GetxController {

  //가장 중요한 변수. 여기에 모든 db 의 data 가 담김.
  //실질적 데이터인 MemoHelper 에서 내려온 data 변수가 ui 에 표시되기 위해 여기에 담김.
  RxList memo = [].obs;

  //클릭 감지.
  RxBool memoLongClicked = false.obs;

  //insert here.
  TextEditingController memoController = TextEditingController();

  //scroll control.
  var scrollController = ScrollController().obs;

  //스크롤 아래로 내리기.
  //아이템 추가, 처음 ui 진입 시 호출됨.
  goToDown()async{
    //비동기적으로 getItems 로 메모 데이터를 가져온 뒤에 화면을 내려야 하기에, 딜레이를 줬음.
    await Future.delayed(Duration(milliseconds: 200));
    scrollController.value.animateTo(
      scrollController.value.position.maxScrollExtent,
      curve: Curves.easeOut,
      //딜레이는 화면이 내려가는 애니메이션의 Duration 과 같게 해서 위화감이 없도록 함.
      duration: const Duration(milliseconds: 200),
    );

    print('go to down');
  }

  //로딩.
  RxBool isLoading = true.obs;

  //상세 페이지로 이동.
  goToDetail(String content, String date, int color){
    Get.toNamed('/detail', arguments: {
      'content' : content,
      'date' : date,
      'color' : color
    });
  }


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


  //color PART
  //가변적으로 변하는 RxInt 변수와, flutter ui 의 Color 를 int 로 저장할 수 있는 변수들.
  RxInt colorValue = 0.obs;

  //palette(int value)
  int whiteValue = Colors.white.value;
  int redValue = Colors.red.value;

  //앱 시작시 초기 컬러 가져오기.
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
    goToDown();
    print('memo refreshed');
  }

  //C
  Future<void> addItem() async {
    await MemoHelper.createItem(memoController.text, CurrentDate.value.toString(), colorValue.value);
    refreshMemo();
    // goToDown();
  }

  //R 은 MemoHelper 단에서.

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

  //컨트롤러 생성 및 삽입시 초기에 실행.
  //여기서 db 를 init 하고 고정적으로 불러와야 할 값들을 가져옴.
  //초기에 불러와야 할 값들 : ui 에 표시될 날짜들, 메모 기본 색상 등.
  @override
  void onInit() async {
    super.onInit();

    await MemoHelper.db();
    await getDefaultColor();
    await getCurrentDay();
    await getCurrentMonth();
    //처음 한번 새로고침으로 메모 가져오기.
    refreshMemo();

  }

  //init 후 1프레임 뒤.
  @override
  void onReady() {
    super.onReady();
    //시작시 화면 내리기.
    goToDown();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
