import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get_storage/get_storage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../global/memo.dart';

class HomeController extends GetxController {
  //set up part.

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
    //비동기적인 메모 데이터를 가져온 뒤에 화면을 내려야 하기에, 딜레이를 줬음.
    await Future.delayed(Duration(milliseconds: 100));
    scrollController.value.animateTo(
      scrollController.value.position.maxScrollExtent,
      curve: Curves.easeOut,
      //딜레이는 화면이 내려가는 애니메이션의 Duration 과 같게 해서 위화감이 없도록 함.
      duration: const Duration(milliseconds: 100),
    );

    print('go to down');
  }

  goToTop() async {
    //특정 모드 해제 이후 메모 데이터를 가져온 뒤에 화면을 올려야 하기에, 딜레이를 줬음.
    await Future.delayed(Duration(milliseconds: 100));
    scrollController.value.animateTo(
      scrollController.value.position.minScrollExtent,
      curve: Curves.easeOut,
      //딜레이는 화면이 올라가는 애니메이션의 Duration 과 같게 해서 위화감이 없도록 함.
      duration: const Duration(milliseconds: 100),
    );

    print('go to Top');
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
  RxString CurrentDayOf = ''.obs;
  RxString CurrentDay = ''.obs;
  RxString CurrentDayDetail = ''.obs;
  RxString CurrentMonthMMM = ''.obs;
  RxString CurrentMonthMM = ''.obs;
  RxString CurrentMonthForTile = ''.obs;
  RxString CurrentYear = ''.obs;

  RxInt CurrentYyyy = 0.obs;
  RxInt CurrentMM = 0.obs;
  RxInt CurrentDD = 0.obs;

  //AppBar 날짜 하단의 요일중 토,일 색상 변경을 위한 Rx변수.
  RxInt ssDayColorValue = 0.obs;

  //토요일 혹은 일요일이면 빨강색, 아니면 검은색.
  getDayColor() {
    switch (CurrentDayOf.value) {
      case 'Sat':
        ssDayColorValue.value = redValue;
        break;

      case 'Sun':
        ssDayColorValue.value = redValue;
        break;

      default:
        ssDayColorValue.value = Colors.black.value;
    }
  }

  //메모 왼쪽에 표시될 작성 시간을 가져옵니다.
  getCurrentDate() {
    CurrentDate.value = DateFormat("hh:mm a").format(DateTime.now());
  }

  //앱바 상단에 위치할 날짜를 가져옵니다.
  getCurrentDay() {
    CurrentDay.value = DateFormat("dd").format(DateTime.now());
    CurrentDD.value = int.parse(CurrentDay.value);
  }

  getCurrentDayDetail() {
    CurrentDayDetail.value = DateFormat("yyyyMMdd").format(DateTime.now());
  }

  getCurrentDayOf() {
    CurrentDayOf.value = DateFormat("EEE").format(DateTime.now());
  }

  //appBar 의 Leading 에 들어갈 월.
  getCurrentMonthMMM() {
    CurrentMonthMMM.value = DateFormat("MMM").format(DateTime.now());
  }

  getCurrentMonthMM() {
    CurrentMonthMM.value = DateFormat("MM").format(DateTime.now());
    CurrentMM.value = int.parse(CurrentMonthMM.value);
  }

  getCurrentYear() {
    CurrentYear.value = DateFormat("yyyy").format(DateTime.now());
    CurrentYyyy.value = int.parse(CurrentYear.value);
  }

  //color PART
  //가변적으로 변하는 RxInt 변수와, flutter ui 의 Color 를 int 로 저장할 수 있는 변수들.
  RxInt colorValue = 0.obs;

  //memoDetailView 에서 update 를 위해 선언될 변수.
  RxInt detailColorValue = 0.obs;
  RxBool isColorChanged = false.obs;

  colorChanged() {
    isColorChanged.value = true;
  }

  //palette(int value)
  int whiteValue = Colors.white.value;
  int redValue = Colors.red.value;
  int tealValue = Colors.teal.value;
  int lightPinkValue = Color(0xfff28b81).value;
  int yellowValue = Color(0xfffbf476).value;
  int lightGreenValue = Color(0xffcdff90).value;
  int turquoiseValue = Color(0xffa7feeb).value;
  int lightCyanValue = Color(0xffcbf0f8).value;
  int lightBlueValue = Color(0xffafcbfa).value;
  int plumValue = Color(0xffd7aefc).value;

  final colors = [
    Color(0xffffffff), // classic white
    Color(0xfff28b81), // light pink
    Color(0xfff7bd02), // yellow
    Color(0xfffbf476), // light yellow
    Color(0xffcdff90), // light green
    Color(0xffa7feeb), // turquoise
    Color(0xffcbf0f8), // light cyan
    Color(0xffafcbfa), // light blue
    Color(0xffd7aefc), // plum
    Color(0xfffbcfe9), // misty rose
    Color(0xffe6c9a9), // light brown
    Color(0xffe9eaee) // light gray
  ];

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

  getLightPink() {
    colorValue.value = lightPinkValue;
  }

  getYellow() {
    colorValue.value = yellowValue;
  }

  getLightGreen() {
    colorValue.value = lightGreenValue;
  }

  getTurquoise() {
    colorValue.value = turquoiseValue;
  }

  getLightCyan() {
    colorValue.value = lightCyanValue;
  }

  getLightBlue() {
    colorValue.value = lightBlueValue;
  }

  getPlum() {
    colorValue.value = plumValue;
  }

  //tags customize 시 사용될 TextField controllers
  TextEditingController redTagController = TextEditingController();
  TextEditingController tealTagController = TextEditingController();
  TextEditingController lightPinkTagController = TextEditingController();
  TextEditingController yellowTagController = TextEditingController();
  TextEditingController lightGreenTagController = TextEditingController();
  TextEditingController turquoiseTagController = TextEditingController();
  TextEditingController lightCyanTagController = TextEditingController();
  TextEditingController lightBlueTagController = TextEditingController();
  TextEditingController plumTagController = TextEditingController();

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

  //colorValue 에 따라 아이템 가져오기.
  //색상 태그별 정리 기능에 사용됨.
  refreshMemoByColor(int color) async {
    final data = await MemoHelper.getItemsByColor(color);
    memo.value = data;
    isLoading.value = false;
    print(memo.toString());
    print('memo refreshed by color $color');
  }

  //날짜 정보에 따라 아이템 가져오기.
  refreshMemoByDate() async {
    await getCurrentDayDetail();
    await getCurrentYear();
    await getCurrentMonthMM();
    await getCurrentDay();
    //yyyy + mm + dd 로 포맷 맞추기.
    final date = CurrentYear.toString() +
        CurrentMonthMM.toString() +
        CurrentDay.toString();
    final data = await MemoHelper.getItemsByDate(date);
    memo.value = data;
    isLoading.value = false;
    print('memo refreshed by date $date');
  }

  //월별로 데이터 가져오기.
  RxList eventRaw = [].obs;

  refreshMemoByDateMM() async {
    await getCurrentMonthMM();
    print(CurrentMM.value);
    //tile 구현 스텝 1. MM 단위로 데이터 가져오기.
    final data = await MemoHelper.getItemsByDateMM(CurrentMM.value);
    //tile 구현 스텝 2. Raw 데이터 넣어주기.
    eventRaw.value = data;
    //tile 구현 스텝 3. forEach 사용해서 map 형태인 eventHash 에 eventRaw 의 알맞은 key value 넣기.
    eventRaw.forEach((element) {
      //white 타일은 존재하지 않기 때문에 colorValue 가 white 면 eventsHash 에 추가하지 않도록 함.
      if(element['colorValue'] == 4294967295) {
        null;
      }else{
        eventsHash['${element['createdAt']}'] = ['${element['colorValue']}'];
      }
    });
    isLoading.value = false;
    print('event Hash = $eventsHash');
    print('memo refreshed by dateMM $eventRaw');
  }

  //정해진 포맷의 날짜를 받아올 RxString
  RxString selectedDay = ''.obs;

  //tile view 에서 날짜를 클릭해서 검색할때.
  refreshMemoByDateTile(RxString selectedDay) async {
    //yyyy + mm + dd 로 포맷 맞추기.
    // final date = CurrentYear.toString() + CurrentMonthMM.toString() + CurrentDay.toString();
    final data = await MemoHelper.getItemsByDate(selectedDay.value);
    memo.value = data;
    isLoading.value = false;
    print('memo refreshed by date $selectedDay');
  }

  //검색 기능. 내용에 따라 아이템 가져오기.
  refreshMemoByContent(String content) async {
    final data = await MemoHelper.getItemsByContent(content);
    print(data);
    memo.value = data;
    isLoading.value = false;
    print('memo refreshed by content $content');
  }

  //해당 날짜가 비어있는지 아닌지 확인하기.
  RxList firstCheckValue = [].obs;

  firstCheckByDate() async {
    await getCurrentDayDetail();
    final data = await MemoHelper.getItemsByDate(CurrentDayDetail.value);
    firstCheckValue.value = data;
    print('memo refreshed by date ${firstCheckValue}');
  }

  //C
  Future<void> addItem() async {
    //위의 firstCheck 를 활용하여 해당 날짜의 첫번째 메모라면 true, 아니라면 false.
    if (firstCheckValue.isEmpty) {
      await MemoHelper.createItem(
          memoController.text,
          //yyyy:MM:dd / createdAt
          CurrentDayDetail.value.toString(),
          CurrentYear.value.toString(),
          CurrentMonthMM.value.toString(),
          CurrentDay.value.toString(),
          //firstCheck 1 = true
          1,
          //hh:mm a
          CurrentDate.value.toString(),
          colorValue.value);
      refreshMemo();
      print('first check true');
    } else {
      await MemoHelper.createItem(
          memoController.text,
          //yyyy:MM:dd / createdAt
          CurrentDayDetail.value.toString(),
          CurrentYear.value.toString(),
          CurrentMonthMM.value.toString(),
          CurrentDay.value.toString(),
          //firstCheck 0 = false
          0,
          //hh:mm a
          CurrentDate.value.toString(),
          colorValue.value);
      refreshMemo();
      print('first check false');
    }

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


  //UI part(bottom sheet)

  //search bar controller
  TextEditingController searchBarController = TextEditingController();

  //AppBar mode
  //search mode
  //검색모드 전환시 bool.
  RxBool searchModeOn = false.obs;

  //태그 모드 전환시 bool.
  RxBool tagModeOn = false.obs;

  //날짜 모드 전환시 bool.
  RxBool dateModeOn = false.obs;

  searchButtonClicked() {
    if (searchBarController.text != '') {
      searchModeOn.value = true;
      tagModeOn.value = false;
      dateModeOn.value = false;
    }
  }

  tagButtonClicked() {
    tagModeOn.value = true;
    searchModeOn.value = false;
    dateModeOn.value = false;
  }

  dateButtonClicked() {
    tagModeOn.value = false;
    searchModeOn.value = false;
    dateModeOn.value = true;
  }

  defaultModeOn() {
    tagModeOn.value = false;
    searchModeOn.value = false;
    dateModeOn.value = false;
  }

  RxString nowTag = ''.obs;

  //storage part(get storage)
  final tag = GetStorage();

  //최초 실행시 태그 밸류 null 방지를 위한(동시에 색상 이름 표시) 메소드.
  tagInit() {
    tag.writeIfNull('red', 'red');
    tag.writeIfNull('teal', 'teal');
    tag.writeIfNull('lightPink', 'lightPink');
    tag.writeIfNull('yellow', 'yellow');
    tag.writeIfNull('lightGreen', 'lightGreen');
    tag.writeIfNull('turquoise', 'turquoise');
    tag.writeIfNull('lightCyan', 'lightCyan');
    tag.writeIfNull('lightBlue', 'lightBlue');
    tag.writeIfNull('plum', 'plum');
  }

  //tileView part
  //월별로 가져온 메모 데이터. 이벤트 표시를 위해 사용됨.

  // late List<Map<DateTime, List<Event>>> events;
  final Map<String, List<dynamic>> eventsHash = {
    // '20230613': [4294198070],
    // '20230614': [4278228616],
    // '20230615': [4278228616],
    // '20230616': [4294085505],
    //data
  };

  //eventLoader 가 가져갈 해시맵.
  //DateTime, List<> 에 들어갈 첫번째 객체가 타일뷰에 표시될 색상값이 됨.
  //현재 사용 안함.
  Map<DateTime, List<dynamic>> events = LinkedHashMap(
    equals: isSameDay,
  )..addAll({
      DateTime.utc(2023, 6, 13): [4294198070],
      DateTime.utc(2023, 6, 14): [4278228616],
      DateTime.utc(2023, 6, 15): [4278228616],
      DateTime.utc(2023, 6, 17): [4294085505],
    });

  //해당 포맷(yyyy-mm-dd)의 데이터가 존재하지 않으면 [] 을 리턴시켜 null error 방지.
  //tile 구현 스텝 4. 그렇게 완성된 eventsHash 의 첫 객체를 DateTime 포맷에 맞추어 인식시켜 타일 구현.
  List<dynamic> getEvents(DateTime day) {
    if (eventsHash[DateFormat('yyyyMMdd').format(day)] != null) {
      print(eventsHash[DateFormat('yyyyMMdd').format(day)]);
      return eventsHash[DateFormat('yyyyMMdd').format(day)]!;
    } else {
      //해당 날짜에 해당하는 데이터가 없다면 미표기. 이거 없으면 다 표시되는 버그가 생김.
      return [];
    }
    // return events[day] ?? [];
  }

  //컨트롤러 생성 및 삽입시 초기에 실행.
  //여기서 db 를 init 하고 고정적으로 불러와야 할 값들을 가져옴.
  //초기에 불러와야 할 값들 : ui 에 표시될 날짜들, 메모 기본 색상 등.
  @override
  void onInit() async {
    super.onInit();

    await MemoHelper.db();
    await getDefaultColor();
    await getCurrentYear();
    await getCurrentMonthMM();
    await getCurrentDay();
    await getCurrentDayOf();
    await getDayColor();
    await getCurrentMonthMMM();
    await tagInit();
    // await eventsValueInit();
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

class Event {
  String title;

  Event({
    required this.title,
  });
}
