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

  //홈 화면의 메모 타일의 데이터가 상세 페이지로 옮겨지는 과정 - 3-1.
  //memo_tile 의 text = > content = detailController(그릇).
  RxString detailContent = "".obs;

  //memo_detail 에 들어갈 TextField 의 controller.
  TextEditingController memoDetailController = TextEditingController();

  ////홈 화면의 메모 타일의 데이터가 상세 페이지로 옮겨지는 과정 - 4.
  //그렇게 최종적으로 ui 에 표시되기 위해 받아온 detailContent 를 TEC 의 text 부분에 넘겨서 표시.
  getDetail() {
    memoDetailController.text = detailContent.value;
  }

  //scroll control.
  var scrollController = ScrollController().obs;

  //스크롤 아래로 내리기.
  //아이템 추가, 처음 ui 진입 시 호출됨.
  goToDown() async {
    //비동기적으로 getItems 로 메모 데이터를 가져온 뒤에 화면을 내려야 하기에, 딜레이를 줬음.
    await Future.delayed(Duration(milliseconds: 300));
    scrollController.value.animateTo(
      scrollController.value.position.maxScrollExtent,
      curve: Curves.easeOut,
      //딜레이는 화면이 내려가는 애니메이션의 Duration 과 같게 해서 위화감이 없도록 함.
      duration: const Duration(milliseconds: 300),
    );

    print('go to down');
  }

  //로딩.
  RxBool isLoading = true.obs;

  //상세 페이지로 이동.
  //홈 화면의 메모 타일의 데이터가 상세 페이지로 옮겨지는 과정 - 2.
  //memo_tile ui 에서 이미 db 에서 받아져있던 변수들(text, date, color 등) 을 넘기면,
  //이쪽에서 content, date, color arugments 로 받아옴.
  goToDetail(int? id, String content, String date, int color) async {
    //홈 화면의 메모 타일의 데이터가 상세 페이지로 옮겨지는 과정 - 3(2).
    //memo_tile 에서 받아온 text = > content 로 argument 화 했다면,
    //ui 에 표시하기 위해 미리 선언해둔 detailContent obs 변수로 받아줌.
    if (id != null) {
      // memo.firstWhere((element) => element['id'] == id);
      memoDetailController.text = detailContent.value;
      detailContent.value = content;
      await getDetail();
      print(id.toString());
      Get.toNamed('/detail', arguments: {
        'id': id,
        'content': content,
        'date': date,
        'color': color,
      });
    } else {
      print('else');
    }
  }

  // goToDetail2() async{
  //   final data = await MemoHelper.getItem(id);
  // }

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
    CurrentDay.value = DateFormat("dd").format(DateTime.now());
  }

  //appBar 의 Leading 에 들어갈 월.
  getCurrentMonth() {
    CurrentMonth.value = DateFormat("MMM").format(DateTime.now());
  }

  //color PART
  //가변적으로 변하는 RxInt 변수와, flutter ui 의 Color 를 int 로 저장할 수 있는 변수들.
  RxInt colorValue = 0.obs;

  //memoDetailView 에서 update 를 위해 선언될 변수.
  RxInt detailColorValue = 0.obs;
  RxBool isColorChanged = false.obs;

  //palette(int value)
  int whiteValue = Colors.white.value;
  int redValue = Colors.red.value;
  int tealValue = Colors.teal.value;

  //앱 시작시 초기 컬러 가져오기.
  getDefaultColor() {
    colorValue.value = whiteValue;
  }

  getRed() {
    colorValue.value = redValue;
  }

  getTeal() {
    colorValue.value = tealValue;
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
    print('memo refreshed');
  }

  //C
  Future<void> addItem() async {
    await MemoHelper.createItem(
        memoController.text, CurrentDate.value.toString(), colorValue.value);
    refreshMemo();
    // goToDown();
  }

  //R 은 MemoHelper 단에서.

  //U
  Future<void> updateItem(
      int id, String editedContent, String editedDate, int editedColor) async {
    await MemoHelper.updateItem(
        id, editedContent, '${editedDate} (Edited)', editedColor);
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
  void onReady() async {
    super.onReady();
    //시작시 화면 내리기.
    await goToDown();
    //혹여나 버그로 화면이 다 내려가지 않는다면 1 microsecond 뒤에 한번 더 내림.
    Future.delayed(Duration(microseconds: 1), () {
      goToDown();
    });

  }

  @override
  void onClose() {
    super.onClose();
  }
}
