import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/scheduler.dart';

import '../../../global/memo.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //home Controller part 분류.
  //각 파트는 변수의 타입과 상관없이 기능, 혹은 페이지의 단위로 분류되었음.
  //1.set up
  var setUpBookMark;

  //2.scroll control
  var scrollControlBookMark;

  //3.date
  var dateBookMark;

  //4.color
  var colorBookMark;

  //5.tags
  var tagsBookMark;

  //6.theme
  var themeBookMark;

  //7.mode
  var modeBookMark;

  //8.db
  var dbBookMark;

  //9.bottomSheet
  var bottomSheetBookMark;

  //10.animation
  var animationBookMark;

  //set up part.
  setUpPartHere() {
    setUpBookMark = '1';
  }

  //가장 중요한 변수.
  //실질적 데이터인 MemoHelper 에서 내려온 data 변수가 ui 에 표시되기 위해 여기에 담김.
  RxList memo = [].obs;
  RxInt memoLenght = 10.obs;

  //삭제된 메모 조회를 위한 변수.
  RxList deletedMemo = [].obs;

  RxList currentKeyList = [].obs;

  //클릭 감지.
  RxBool memoLongClicked = true.obs;

  //page
  PageController pageController = PageController();

  //Screen Size.
  RxDouble width = 0.0.obs;
  RxDouble height = 0.0.obs;

  //스크린 사이즈 가져오기.
  getScreenSize() {
    width.value = Get.width;
    height.value = Get.height;

    print('Screen width: ${width.value}');
    print('Screen height: ${height.value}');
  }

  //focus node.
  FocusNode textFocus = FocusNode();
  FocusNode searchTextFocus = FocusNode();

  //edit 버튼 클릭시.
  var isEditMode = false.obs;

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

  //scroll control part.
  scrollControlPartHere() {
    scrollControlBookMark = '2';
  }

  var scrollController = ScrollController().obs;
  var isLoading = true.obs;
  var hasMore = false.obs;
  var goToDownButtonDontShow = true.obs;
  var isScrollMax = false.obs;
  var dragStartForEditMode = false.obs;
  var dragStartForPageSwipe = false.obs;

  //스크롤 아래로 내리기.
  //아이템 추가, 처음 ui 진입 시 호출됨.
  goToDown() async {
    //memo(리스트)에 아무런 데이터가 없으면 스크롤 컨트롤러 에러가 뜸. 때문에 조건 추가.
    if (memo.isNotEmpty) {
      //비동기적인 메모 데이터를 가져온 뒤에 화면을 내려야 하기에, 딜레이를 줬음.
      await Future.delayed(Duration(milliseconds: 100));
      await scrollController.value.animateTo(
        scrollController.value.position.maxScrollExtent,
        curve: Curves.easeOut,
        //딜레이는 화면이 내려가는 애니메이션의 Duration 과 같게 해서 위화감이 없도록 함.
        duration: const Duration(milliseconds: 100),
      );
      //끝까지 안내려가는걸 방지하여 100ms의 애니메이션 후 다시 한번 내리기.
      scrollController.value.animateTo(
        scrollController.value.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 1),
      );
      print('go to down');
    }
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

  //empty 상태 표기를 위한 empty 체크.
  //메모의 갯수가 삭제된 메모의 갯수와 같거나(모든 메모가 쓰레기통으로 들어갔다는 뜻).
  //memo변수가 isEmpty상태라면 empty를 표기하도록 함.
  //trashView에서는 삭제된 메모의 갯수와 영구삭제된(될)메모의 갯수를 비교함.

  //영구삭제될 메모를 담아둘 변수가 없어서 여기에 추가함.
  //기존 기능에서는 바로 삭제되므로 굳이 만들어두지 않았었음.
  var hardDeletedItemForEmptyCheck = [].obs;

  //두 진영 메모 변수의 갯수가 같은지 확인하기 위한 변수.
  //for Home
  var isDeletedMemoLenghtSameWithNormalMemoLenght = false.obs;

  //for Trash
  var isDeletedMemoLenghtSameWithHardDeletedMemoLenght = false.obs;

  //refreshMemo에 포함됨.
  homeEmptyCheck() {
    refreshDeletedMemo();
    if (memo.length == deletedMemo.length) {
      isDeletedMemoLenghtSameWithNormalMemoLenght.value = true;
    } else {
      isDeletedMemoLenghtSameWithNormalMemoLenght.value = false;
    }
  }

  //refreshDeletedMemo에 포함됨.
  trashEmptyCheck() async {
    final data = await MemoHelper.getItemsByHardDeleted();
    hardDeletedItemForEmptyCheck.addAll(data);
    if (deletedMemo.length == hardDeletedItemForEmptyCheck.length) {
      isDeletedMemoLenghtSameWithHardDeletedMemoLenght.value = true;
    } else {
      isDeletedMemoLenghtSameWithHardDeletedMemoLenght.value = false;
    }
    hardDeletedItemForEmptyCheck.clear();
  }

  //date PART
  datePartHere() {
    dateBookMark = '3';
  }

  //날짜 정보를 받아오기 위한 RxString.
  RxString CurrentMinutes = ''.obs;
  RxString CurrentHour = ''.obs;
  RxString CurrentDate = ''.obs;
  RxString CurrentDayOf = ''.obs;
  RxString CurrentDay = ''.obs;
  RxString CurrentDayDetail = ''.obs;
  RxString CurrentMonthMMM = ''.obs;
  RxString CurrentMonthMM = ''.obs;
  RxString CurrentMonthForTile = ''.obs;
  RxString CurrentYear = ''.obs;

  RxInt CurrentMinutesInt = 0.obs;
  RxInt CurrentHourInt = 0.obs;
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

  getCurrentMinute() {
    CurrentMinutes.value = DateFormat("mm").format(DateTime.now());
    CurrentMinutesInt.value = int.parse(CurrentMinutes.value);
  }

  getCurrentHour() {
    CurrentHour.value = DateFormat("hh").format(DateTime.now());
    CurrentHourInt.value = int.parse(CurrentHour.value);
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
  colorPartHere() {
    colorBookMark = '4';
  }

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

  //new palette
  int blueValue = Color(0xff86b1f7).value;
  int redredValue = Color(0xfffa6173).value;
  int aquaValue = Color(0xffb8f2ed).value;
  int greenValue = Color(0xff98e381).value;
  int pinkValue = Color(0xfff5a6de).value;
  int orangeValue = Color(0xfffca772).value;
  int purpleValue = Color(0xffbb9beb).value;
  int mustardValue = Color(0xfff0dc7a).value;

  //구 테마 가져오기.
  // getRed() {
  //   colorValue.value = redValue;
  // }
  //
  // getTeal() {
  //   colorValue.value = tealValue;
  // }
  //
  // getLightPink() {
  //   colorValue.value = lightPinkValue;
  // }
  //
  // getYellow() {
  //   colorValue.value = yellowValue;
  // }
  //
  // getLightGreen() {
  //   colorValue.value = lightGreenValue;
  // }
  //
  // getTurquoise() {
  //   colorValue.value = turquoiseValue;
  // }
  //
  // getLightCyan() {
  //   colorValue.value = lightCyanValue;
  // }
  //
  // getLightBlue() {
  //   colorValue.value = lightBlueValue;
  // }
  //
  // getPlum() {
  //   colorValue.value = plumValue;
  // }

  //앱 시작시 초기 컬러 가져오기.
  //기본 컬러(화이트) 가져오기.
  getDefaultColor() {
    colorValue.value = whiteValue;
  }

  //테마 컬러 가져오기.
  getRedRed() {
    colorValue.value = redredValue;
  }

  getBlue() {
    colorValue.value = blueValue;
  }

  getAqua() {
    colorValue.value = aquaValue;
  }

  getGreen() {
    colorValue.value = greenValue;
  }

  getPink() {
    colorValue.value = pinkValue;
  }

  getOrange() {
    colorValue.value = orangeValue;
  }

  getPurple() {
    colorValue.value = purpleValue;
  }

  getMustard() {
    colorValue.value = mustardValue;
  }

  //tag part.
  tagsPartHere() {
    tagsBookMark = '5';
  }

  RxString nowTag = ''.obs;
  final tag = GetStorage();

  //구 테마.
  // TextEditingController redTagController = TextEditingController();
  // TextEditingController tealTagController = TextEditingController();
  // TextEditingController lightPinkTagController = TextEditingController();
  // TextEditingController yellowTagController = TextEditingController();
  // TextEditingController lightGreenTagController = TextEditingController();
  // TextEditingController turquoiseTagController = TextEditingController();
  // TextEditingController lightCyanTagController = TextEditingController();
  // TextEditingController lightBlueTagController = TextEditingController();
  // TextEditingController plumTagController = TextEditingController();

  //tags customize 시 사용될 TextField controllers
  TextEditingController redTagController = TextEditingController();
  TextEditingController blueTagController = TextEditingController();
  TextEditingController aquaTagController = TextEditingController();
  TextEditingController greenTagController = TextEditingController();
  TextEditingController pinkTagController = TextEditingController();
  TextEditingController orangeTagController = TextEditingController();
  TextEditingController purpleTagController = TextEditingController();
  TextEditingController mustardTagController = TextEditingController();

  //tags customize에 사용될 포커스노드.
  FocusNode redTagFocusNode = FocusNode();
  FocusNode blueTagFocusNode = FocusNode();
  FocusNode aquaTagFocusNode = FocusNode();
  FocusNode greenTagFocusNode = FocusNode();
  FocusNode pinkTagFocusNode = FocusNode();
  FocusNode orangeTagFocusNode = FocusNode();
  FocusNode purpleTagFocusNode = FocusNode();
  FocusNode mustardTagFocusNode = FocusNode();

  //최초 실행시 태그 밸류 null 방지를 위한(동시에 색상 이름 표시) 메소드.
  tagInit() {
    tag.writeIfNull('red', 'red');
    tag.writeIfNull('blue', 'blue');
    tag.writeIfNull('aqua', 'aqua');
    tag.writeIfNull('green', 'green');
    tag.writeIfNull('pink', 'pink');
    tag.writeIfNull('orange', 'orange');
    tag.writeIfNull('purple', 'purple');
    tag.writeIfNull('mustard', 'mustard');
  }

  //theme part.
  themePartHere() {
    themeBookMark = '6';
  }

  //현재 상태 감지에 쓰일 true, false는 dark모드를 기준으로 함.
  final isDeviceThemeDark =
      SchedulerBinding.instance.window.platformBrightness == Brightness.dark;

  //디바이스 테마 사용. 기본값은 true. 테마를 따로 조작하면 false.
  var useDeviceTheme = true.obs;
  var themeData = Get.isDarkMode ? ThemeData.dark() : ThemeData.light();

  var isDarkModeOn = false.obs;
  RxInt darkModeDateIndicatorColor = Colors.grey.value.obs;
  RxInt lightModeDateIndicatorColor = Colors.white.value.obs;

  var backgoundColorValue = 0.obs;
  var subColorValue = 0.obs;
  var iconColorValue = 0.obs;
  var textColorValue = 0.obs;
  var shadowColorValue = 0.obs;

  //앱 진입시 테마적용.
  themeInit() {
    print('theme init');
    if (isDeviceThemeDark == true) {
      //darkModeOn()을 사용하지 않는 이유: darkModeOn()은 디바이스 테마 해제 기능도 겸하기 때문.
      Get.changeThemeMode(ThemeMode.dark);
      Get.changeTheme(ThemeData.dark(useMaterial3: true));
      isDarkModeOn.value = true;
    } else {
      Get.changeThemeMode(ThemeMode.light);
      Get.changeTheme(ThemeData.light(useMaterial3: true));
      isDarkModeOn.value = false;
    }
  }

  deviceThemeOn() {
    //디바이스 사용 확인.
    useDeviceTheme.value = true;
    if (isDeviceThemeDark == true) {
      //darkModeOn()을 사용하지 않는 이유: darkModeOn()은 디바이스 테마 해제 기능도 겸하기 때문.
      Get.changeThemeMode(ThemeMode.dark);
      Get.changeTheme(ThemeData.dark(useMaterial3: true));
      isDarkModeOn.value = true;
    } else {
      //이하 마찬가지.
      Get.changeThemeMode(ThemeMode.light);
      Get.changeTheme(ThemeData.light(useMaterial3: true));
      isDarkModeOn.value = false;
    }
  }

  darkModeOn() {
    Get.changeThemeMode(ThemeMode.dark);
    Get.changeTheme(ThemeData.dark(useMaterial3: true));
    isDarkModeOn.value = true;
    //사용자가 테마를 변경하면 디바이스 테마를 사용하지 않는 것으로 간주함.
    useDeviceTheme.value = false;
  }

  lightModeOn() {
    Get.changeThemeMode(ThemeMode.light);
    Get.changeTheme(ThemeData.light(useMaterial3: true));
    isDarkModeOn.value = false;
    //사용자가 테마를 변경하면 디바이스 테마를 사용하지 않는 것으로 간주함.
    useDeviceTheme.value = false;
  }

  //mode part.
  modePartHere() {
    modeBookMark = '7';
  }

  //검색모드 전환시 bool.
  RxBool searchModeOn = false.obs;

  //태그 모드 전환시 bool.
  RxBool tagModeOn = false.obs;

  //날짜 모드 전환시 bool.
  RxBool dateModeOn = false.obs;

  RxBool defaultModeValueOn = true.obs;

  searchButtonClicked() {
    if (searchBarController.text != '') {
      searchModeOn.value = true;
      tagModeOn.value = false;
      dateModeOn.value = false;

      // defaultModeOn.value = true;
    }
  }

  tagButtonClicked() {
    tagModeOn.value = true;
    searchModeOn.value = false;
    dateModeOn.value = false;
    //
    // defaultModeOn.value = true;
  }

  dateButtonClicked() {
    tagModeOn.value = false;
    searchModeOn.value = false;
    dateModeOn.value = true;
    //
    // defaultModeOn.value = true;
  }

  defaultModeOn() async {
    //모드 해제시 애니메이션.
    await modeDoneAnimation();
    tagModeOn.value = false;
    searchModeOn.value = false;
    dateModeOn.value = false;
    isEditMode.value = false;
    //
    // defaultModeOn.value = true;

    refreshMemo();
    goToDown();
  }

  //에딧모드 체크된 메모들을 가져와 for Each로 에딧 체크 콜롬에 0(false)을 넣어줌.
  //홈뷰의 X FAB를 누를때 실행되며, 다시 메모 에딧 모드로 넘어갈때 이미 체크되어있는 상황을 방지하기 위함.
  RxList editedMemo = [].obs;

  RxList deleteCheckedMemo = [].obs;

  editModeDone() async {
    final data = await MemoHelper.getItemsByEditModeCheck();
    // await modeDoneAnimation();
    print('edited: ${data}');
    editedMemo.addAll(data);
    editedMemo.forEach(
      (element) {
        updateItemForEditCheckClear(element['id'], 0);
      },
    );
    editedMemo.value = [];
    print('edit mode done');
  }

  editModeCheckedItemDelete() async {
    final data = await MemoHelper.getItemsByEditModeCheck();
    print('edited: ${data}');
    editedMemo.addAll(data);
    editedMemo.forEach(
      (element) {
        itemToTrash(element['id']);
      },
    );
    editedMemo.value = [];
    // refreshMemo();
  }

  editModeCheckedItemColorFill(color) async {
    final data = await MemoHelper.getItemsByEditModeCheck();
    print('edited cf: ${data}');
    editedMemo.addAll(data);
    editedMemo.forEach(
      (element) {
        updateItemForEditCheckItemColorControll(
          element['id'],
          color,
        );
      },
    );
    editedMemo.value = [];
    // refreshMemo();
    print('edit color fill');
  }

  //trashView 삭제 체크 클리어.
  trashViewCheckClear() async {
    final data = await MemoHelper.getDeletedItem();
    print('deleted: ${data}');
    deleteCheckedMemo.addAll(data);
    deleteCheckedMemo.forEach(
      (element) {
        updateItemForDeletedCheckClear(element['id'], 0);
      },
    );

    deleteCheckedMemo.value = [];
  }

  //영구삭제 이전에 ui상에 안보이게끔 하기. (표면적 삭제)
  trashViewCheckedMemoInvisible() async {
    final data = await MemoHelper.getDeleteCheckedItem();
    print('edited: ${data}');
    deleteCheckedMemo.addAll(data);
    deleteCheckedMemo.forEach(
      (element) {
        trashViewItemInvisible(element['id']);
      },
    );
    deleteCheckedMemo.value = [];
  }

  //trashView의 모든 아이템 표면적 삭제.
  allTrashViewMemoInvisible() async {
    final data = await MemoHelper.getDeletedItem();
    print('edited: ${data}');
    deleteCheckedMemo.addAll(data);
    deleteCheckedMemo.forEach(
      (element) {
        trashViewItemInvisible(element['id']);
      },
    );
    deleteCheckedMemo.value = [];
  }

  //trashView에서 선택한 아이템 영구삭제.
  trashViewCheckedMemoHardDelete() async {
    final data = await MemoHelper.getItemsByHardDeleted();
    print('Hard delete: ${data}');
    deleteCheckedMemo.addAll(data);
    deleteCheckedMemo.forEach(
      (element) {
        deletItem(element['id']);
      },
    );
    deleteCheckedMemo.value = [];
  }

  //선택된 메모 복구.
  trashViewCheckedMenoRecover() async {
    final data = await MemoHelper.getDeleteCheckedItem();
    print('edited: ${data}');
    deleteCheckedMemo.addAll(data);
    deleteCheckedMemo.forEach(
      (element) {
        trashViewItemRecover(element['id']);
      },
    );
    deleteCheckedMemo.value = [];
  }

  //DB PART
  dbPartHere() {
    dbBookMark = '8';
  }

  //새로고침.
  //MemoHelper 에서 아이템을 추가하거나 업데이트하면 실행됨.
  //최상단의 memo RxList 를 db 의 데이터를 가져온 data 내부 변수로 저장함.
  //실질적 db 데이터인 data = ui 에 표시되기 위한 데이터 List 인 memo.

  //infinitiScroll updata로 역할 변경.
  //initKeyList의 마지막 인덱스의 데이터를 가져와 넣어줌. //추가 업데이트로 문제점 발견.
  //1차 수정 기능을 아래 refreshMemoInit으로 바꾸고 해당 기능은 리뉴얼함.
  refreshMemo() async {
    final data = await MemoHelper.getItems();
    memo.value = data;
    //empty check for home
    homeEmptyCheck();
    // memo.value = [];
    // currentKeyList.forEach((element) async{
    //   final data = await MemoHelper.getItemsByDate(element);
    //   memo.addAll(data);
    // });
  }

  //삭제된 아이템 가져오기.
  refreshDeletedMemo() async {
    final data = await MemoHelper.getDeletedItem();
    deletedMemo.value = data;
    print('deleted item: ${deletedMemo}');
    //empty check for trash
    trashEmptyCheck();
  }

  //최초 로그인시 메모 데이터. 가장 최근 날짜의 데이터만 가져옴.
  refreshMemoInit() async {
    // minusValue.value = 1;
    await firstInitGetDataKey();
    print('refresh key: ${initKeyList}');
    final data = await MemoHelper.getItemsByDate(initKeyList.last);
    //메모가 중복으로 add 되는걸 막기 위해 우선 비우기.
    memo.value = [];
    memo.addAll(data);
    memo.forEach((element) {
      if (currentKeyList.contains(element['createdAt'])) {
        null;
      } else {
        currentKeyList.add(element['createdAt']);
      }
    });
    print('currentKEy: ${currentKeyList}');
    // isLoading.value = false;
    goToDown();
    print('refresh data: ${data}');
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

  //정해진 포맷의 날짜를 받아올 RxString
  RxString selectedDay = ''.obs;

  //tile view 에서 날짜를 클릭해서 검색할때.
  refreshMemoByDateTile(RxString selectedDay) async {
    //yyyy + mm + dd 로 포맷 맞추기.
    // final date = CurrentYear.toString() + CurrentMonthMM.toString() + CurrentDay.toString();
    final data = await MemoHelper.getItemsByDate(selectedDay.value);
    memo.value = data;
    isLoading.value = false;
    print('memo refreshed by date $data');
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
    data.forEach(
      (element) {
        //isDeleted 거르기.
        if (element['isDeleted'] == 1) {
          null;
        } else {
          firstCheckValue.add(element);
        }
      },
    );
    // print('memo refreshed by date ${firstCheckValue}');
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
    // memoTileAnimationController.forward();
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

  Future<void> updateItemForEditCheckClear(int id, int isEditChecked) async {
    await MemoHelper.updateItemForEdit(id, 0);
    refreshMemo();
  }

  Future<void> updateItemForDeletedCheckClear(
      int id, int isDeletedChecked) async {
    await MemoHelper.updateItemForDelete(id, 0);
    refreshMemo();
  }

  Future<void> updateItemForEditCheckItemColorControll(
      int id, int color) async {
    await MemoHelper.updateItemForEditItemColor(id, color);
    refreshMemo();
  }

  //D
  //쓰레기통으로 보내기.
  void itemToTrash(int id) async {
    final data = await MemoHelper.getItem(id);
    await MemoHelper.updateItemForFirstCheck(id, 0);
    await MemoHelper.itemToTrashDB(id);
    //날짜표시줄 리프래쉬.
    await firstRefresh(data[0]['createdAt']);
    refreshMemo();
  }

  //날짜표시줄 리프래쉬.
  //아이템 휴지통으로 옮길때, 휴지통에서 복구할때 호출됨.
  var dataListForFirstRefresh = [].obs;

  firstRefresh(String date) async {
    final data = await MemoHelper.getItemsByDateToFirstCheck(date);
    // dataListForFirstRefresh.addAll(data);
    data.forEach(
      (element) {
        //isDeleted 거르기.
        if (element['isDeleted'] == 1) {
          null;
        } else {
          //걸러진 아이템만(휴지통에 없는) 위의 리스트에 넣기.
          dataListForFirstRefresh.add(element);
        }
      },
    );
    //리스트의 첫번째 아이템이 화면에 보이는 날짜 내의 첫 아이템이므로 isFirst 를 1로 업데이트.
    MemoHelper.updateItemForFirstCheck(dataListForFirstRefresh.first['id'], 1);
    dataListForFirstRefresh.clear();
  }

  //아이템 복구할때, firstRefresh 직전에 호출됨.
  firstRefreshForRecover(String date) async {
    final data = await MemoHelper.getItemsByDateToFirstCheck(date);
    //여기서는 모든 아이템의 firstCheck를 일단 해제시킴.
    //이후에 firstRefresh가 호출되며 정상적으로 ui 그려줌.
    data.forEach((element) {
      MemoHelper.updateItemForFirstCheck(element['id'], 0);
    });
    firstRefresh(date);
  }

  //trash View에 있는 아이템 표먼적 삭제.
  void trashViewItemInvisible(int id) async {
    await MemoHelper.trashViewItemInvisibleDB(id);
    refreshDeletedMemo();
  }

  //메모 복구.
  void trashViewItemRecover(int id) async {
    final data = await MemoHelper.getItem(id);
    await MemoHelper.itemRecover(id);
    //복구될때 날짜표시줄 리프래쉬.
    await firstRefreshForRecover(data[0]['createdAt']);
    refreshMemo();
    refreshDeletedMemo();
  }

  //그 날의 첫번째 메모는 위에 날짜표시줄이 표기되는데, 그런 날짜표시줄이 표기된 아이템을 지우면 표시줄도 같이 지워짐.
  //이러한 문제를 해결하기 위한 과정이 필요함.
  void deletItem(int id) async {
    //item 삭제 전 삭제할 item의 데이터를 가져옴.
    //가져온 데이터의 isFirst가 false라면, 바로 삭제하고.
    //ifFirst가 true라면, 삭제와 동시에 다음 순번의 메모의 isFirst를 true로 만듦.
    // final dataForCheck = await MemoHelper.getItem(id);
    // final dataForCheckToDateList = await MemoHelper.getItemsByDateToFirstCheck(
    //     dataForCheck[0]['createdAt']);
    // if (dataForCheck[0]['isFirst'] == 0) {
    //   print('dataForCheck: ${dataForCheck}');
    //
    // } else if (dataForCheckToDateList.length == 1) {
    //   //해당 날짜에 isFirst이자 그 메모 하나 뿐이라면, 그냥 삭제.
    //   await MemoHelper.deleteItem(dataForCheck[0]['id']);
    // } else {
    //   //해당 날짜에 메모 데이터가 둘 이상이라는 대전제 추가.
    //   //ifFirst가 true라면, dataForCheck의 createdAt으로 날짜로 메모조회 메소드를 실행->
    //   //해당 날짜의 메모들중 dataForCheck의 id와 일치하는 아이템의 다음 순번 아이템의 index를 구함->
    //   //해당 index의 아이템의 isFirst를 1로 만들고 dataForCheck와 일치한 id의 아이템은 삭제.
    //   //isFirst가 true인 메모는 항상 0번 인덱스이므로, 우리가 구할 그 아이템의 인덱스는 항상 1임.
    //   print('dataForCTDG: ${dataForCheckToDateList[1]}');
    //   await MemoHelper.deleteItem(dataForCheck[0]['id']);
    //   await MemoHelper.updateItemForFirstCheck(
    //       dataForCheckToDateList[1]['id'], 1);
    // }
    await MemoHelper.deleteItem(id);
    refreshMemo();
  }

  //bottom sheet part.
  bottomSheetPartHere() {
    bottomSheetBookMark = '9';
  }

  //바텀시트 키보드 오버플로우를 방지하기 위한 ViewInsets.

  //search bar
  TextEditingController searchBarController = TextEditingController();

  //월별로 데이터 가져오기.
  RxList eventRaw = [].obs;
  RxList keyColorValue = [].obs;
  RxList sameKeyColorValueList = [].obs;
  RxList colorValueRaw = [].obs;
  RxList keys = [].obs;

  RxString keyValue = ''.obs;

  //eventhsHash 를 그대로 두면 내용이 겹쳐 타일이 이상하게 표기되는 오류가 있음.
  tileClear() {
    eventsHash.clear();
    eventRaw.value = [];
    keyColorValue.value = [];
    sameKeyColorValueList.value = [];
    colorValueRaw.value = [];
    keys.value = [];
    keyValue.value = '';
  }

  //타일 뷰 들어가기 전에 호출.
  //타일에 들어갈 데이터를 정제하는 과정.
  getTiles() async {
    await tileClear();
    //tile 구현 스텝 1. MM 단위로 데이터 가져오기.
    await getCurrentMonthMM();
    print('currentMM : ${CurrentMM.value}');
    final data = await MemoHelper.getItemsByDateMM(CurrentMM.value);

    //tile 구현 스텝 2. Raw 데이터 넣어주기.
    eventRaw.value = data;
    print('tile data: ${data}');
    //tile 구현 스텝 3. forEach 사용해서 map 형태인 eventHash 에 eventRaw 의 알맞은 key value 넣기.

    eventRaw.forEach(
      (element) {
        // print('element: ${element}');
        //white 타일은 존재하지 않기 때문에 colorValue 가 white 면 eventsHash 에 추가하지 않도록 함.
        //deleted 된 메모도 마찬가지로 보이지 않게끔 함.
        if (element['isDeleted'] != 1 || element['colorValue'] != 4294967295) {
          print('now element: ${element}');
          print('now element is Deleted: ${element['isDeleted']}');
          //키를 만들어야 하기 때문에 우선 데이터 삽입.
          eventsHashRaw['${element['createdAt'].toString()}'] = [
            '${element['colorValue'].toString()}'
          ];
        } else {
          null;
        }
      },
    );
    isLoading.value = false;
    //키 표시 및 선언.
    //해당 키가 곧 데이터를 보유한 날짜이므로, 비어있는 날짜 UI구현을 위해서도 사용됨.
    //calander의 dayBuilder의 day가 keys에 포함되어있지 않다면 빈 날짜로 표시.
    keys.value = eventsHashRaw.keys.toList();
    print('event Hash Keys = $keys');
    print('event Hash raw = $eventsHashRaw');

    keys.forEach(
      (key) async {
        print('key: ${key}');
        //2023NN key 로 일별 데이터 조회.
        final dateData = await MemoHelper.getItemsByDateToColor(key);
        print('dateData: ${dateData}');

        //조회된 일별 데이터로 forEach 사용.
        dateData.forEach(
          (dateData) {
            print(dateData['createdAt']);
            print(dateData['colorValue']);
            print('eventHashRaw: ${eventsHash}');
            //이쪽에서도 white, deletedItem 걸러주기.
            if (dateData['isDeleted'] == 1 ||
                dateData['colorValue'] == 4294967295) {
              null;
            } else if (eventsHash.containsKey(dateData['createdAt']) == true &&
                dateData['isDeleted'] != 1) {
              //같은 key 의 데이터가 존재하면 map 을 생성하는게 아니라 이미 있던 맵에 colorValue add.
              print('same obj');
              //null check 위해 사전에 선언한 list 에 데이터 먼저 넣어주기.
              //아래를 거쳐와서 이미 첫번째 colorValue는 들어가있음.
              sameKeyColorValueList.add(dateData['colorValue']);
              //완성된 데이터 리스트를 toString, 그리고 []를 제거하여 이벤트 해쉬에 삽입.
              eventsHash[dateData['createdAt']] = [
                sameKeyColorValueList
                    .toString()
                    .replaceAll('[', '')
                    .replaceAll(']', '')
              ];
              print('eventRaw2:${sameKeyColorValueList}');
              print('same hash: ${eventsHash}');
              // eventsHashRaw[dateData['createdAt']] = [].addAll(dateData);
            } else {
              //같은 Key 의 데이터가 존재하지 않으면 평소대로 map 생성.
              //위에서 대체되지 않도록 same value 상태를 상정하고 미리 초기 데이터 넣어두기.
              sameKeyColorValueList.add(dateData['colorValue']);
              keyColorValue.add(dateData['colorValue']);
              eventsHash[dateData['createdAt']] = [
                keyColorValue.toString().replaceAll('[', '').replaceAll(']', '')
              ];
            }
            print('eventHashRaw final: ${eventsHash}');
          },
        );
        sameKeyColorValueList.clear();
        keyColorValue.clear();
      },
    );
  } //getTiles

  //월별로 가져온 메모 데이터. 이벤트 표시를 위해 사용됨.

  // late List<Map<DateTime, List<Event>>> events;
  final Map<String, List<dynamic>> eventsHash = {};

  final Map<String, List<dynamic>> eventsHashRaw = {};

  //해당 포맷(yyyy-mm-dd)의 데이터가 존재하지 않으면 [] 을 리턴시켜 null error 방지.
  //tile 구현 스텝 4. 그렇게 완성된 eventsHash 의 첫 객체를 DateTime 포맷에 맞추어 인식시켜 타일 구현.
  List<dynamic> getEvents(DateTime day) {
    if (eventsHash[DateFormat('yyyyMMdd').format(day)] != null) {
      print(
          'eventHash to Load: ${eventsHash[DateFormat('yyyyMMdd').format(day)]}');
      return eventsHash[DateFormat('yyyyMMdd').format(day)]!;
    } else {
      //해당 날짜에 해당하는 데이터가 없다면 미표기. 이거 없으면 다 표시되는 버그가 생김.
      return [];
    }
    // return events[day] ?? [];
  }

  var yyyyMM = ''.obs;
  var yyyyMMddList = [].obs;
  var dd = 1.obs;

  //데이터 없는 날 조회.
  getNonMemoDays() {
    getCurrentYear();
    getCurrentMonthMM();
    yyyyMM.value = CurrentYyyy.value.toString() + CurrentMM.value.toString();
    if (CurrentMM.value % 2 == 1) {}
  }

  //컨트롤러 생성 및 삽입시 초기에 실행.
  //
  //최초 1회 컨트롤러 init시 모든 데이터 날짜 키 가져오기.
  RxList initDataList = [].obs;
  RxList initKeyList = [].obs;
  final Map<String, List<dynamic>> initKeyRaw = {};

  //위의 getTiles와 동일한 메커니즘.
  //다만 getTiles는 현재 달에 해당되는 데이터만 가져오고, 이건 모든 데이터를 가져옴.
  //최적화를 위해 이것도 달별로 가져올까 고민중. 아직은 보류.
  firstInitGetDataKey() async {
    final data = await MemoHelper.getItemsCreatedAt();
    initDataList.value = data;
    initDataList.forEach((element) {
      initKeyRaw[element['createdAt']] = [element['id']];
    });
    //모든 데이터에서 날짜 키 정보만 추산한 initKeyList는 infinityScroll 기능을 위해 쓰임.
    //스크롤을 위로 올릴때마다 initKeyList의 -1 index의 데이터를 가져와 memo list에 add 하는 식.
    print('data::: ${data}');
    initKeyList.value = initKeyRaw.keys.toList();
    print('initKeyList: ${initKeyList}');
  }

  //현재는 미사용.
  //스크롤을 맨 위로 올렸을때 아이템 가져오기.
  RxInt minusValue = 1.obs;

  //현재는 미사용.
  addPatchData() async {
    //minusValue를 증가시켜 계속 올려도 데이터 인덱스를 찾을수 있도록 함.
    //다만 minusValue가 데이터의 총 인덱스보다 높아지면 에러가 뜨기에, 조건을 추가.
    if (minusValue.value == initKeyList.length) {
      minusValue.value = initKeyList.length;
    } else {
      minusValue++;
    }
    final prevDataLenght = initKeyList.length.toInt() - minusValue.value;
    final prevDataLenghtToCheck = initKeyList[prevDataLenght];
    final data = await MemoHelper.getItemsByDate(initKeyList[prevDataLenght]);
    //리스트의 첫번째에 데이터 삽입.
    //중복 add를 방지하기 위한 장치
    //memo 리스트의 첫번째 아이템의 createdAt과 add할 데이터의 createdAt이 같으면 add 안됨.
    if (memo[0]['createdAt'] == initKeyList[prevDataLenght]) {
      print('has no more');
      null;
    } else {
      currentKeyList.value = initKeyList;
      memo.insertAll(0, data);
    }
    //
    // print('prevL: ${prevDataLenght}');
    print('prevLC: ${prevDataLenghtToCheck}');
    // print('prev data: ${data}');
    // print('memo0: ${memo[0]['createdAt']}');
  }

  //animation part.
  animationPartHere() {
    animationBookMark = '10';
  }

  RxDouble memoTilePosition = 0.0.obs;
  RxDouble editModeCheckBoxX = 1.0.obs;
  RxDouble editModeCheckBoxY = 1.0.obs;

  RxInt editModeCheckBoxXInt = 1.obs;
  RxInt editModeCheckBoxYInt = 1.obs;

  var isMemoTileShake = false.obs;
  var isMemoCreated = false.obs;

  var memoCreatedTween = Tween<Offset>(
    begin: Offset(0.0, 1.0),
    end: Offset.zero,
  );

  //왼쪽 스와이프, 에딧모드 진입시 애니메이션.
  editModeInitAnimation() {
    memoTileAnimationController.forward();

    Future.delayed(
      Duration(milliseconds: 300),
      () {
        memoTileAnimationController.reverse();
      },
    );
    Future.delayed(
      Duration(milliseconds: 300),
      () {
        isEditMode.value = true;
        isMemoTileShake.value = true;
        Future.delayed(Duration(milliseconds: 100), () {
          editModeCheckBoxX.value = 30.toDouble();
          editModeCheckBoxY.value = 30.toDouble();
        });
      },
    );
  }

  //editModeDone에 포함될, 에딧모드 종료시 애니메이션.
  modeDoneAnimation() {
    memoTileAnimationController.forward();

    Future.delayed(
      Duration(milliseconds: 200),
      () {
        memoTileAnimationController.reverse();
      },
    );
    Future.delayed(
      Duration(milliseconds: 1),
      () {
        isEditMode.value = false;
        isMemoTileShake.value = false;
        Future.delayed(
          Duration(milliseconds: 1),
          () {
            editModeCheckBoxX.value = 1.toDouble();
            editModeCheckBoxY.value = 1.toDouble();
          },
        );
      },
    );
  }

  //컨트롤 페이지 넘어간 후 컨테이너들 사이즈 커지는 애니메이션.
  //container size
  RxBool controllPageContainerAnimationOn = false.obs;

  RxDouble controllPageLongContainerX = 34.0.obs;
  RxDouble controllPageLongContainerY = 34.0.obs;

  RxDouble controllPageLongContainerVerticalLine = 10.0.obs;

  RxDouble controllPageLongContainerSubBox = 10.0.obs;

  RxDouble controllPageShortContainerX = 40.0.obs;
  RxDouble controllPageShortContainerY = 40.0.obs;

  RxDouble controllPageContainerOpacity = 0.6.obs;

  //text size.
  RxDouble controllPageTextSize = 0.0.obs;
  RxDouble controllPageIconSize = 0.0.obs;

  //컨트롤뷰 나갈때 애니메이션. 오버플로우 방지를 위해 딱히 딜레이를 주지 않음.
  escapeFromControlViewAnimation() {
    print('escape from control view');
    controllPageContainerAnimationOn.value = false;

    controllPageLongContainerX.value = Get.width * 0.7;
    controllPageLongContainerY.value = Get.height * 0.10;

    controllPageTextSize.value = 1;
    controllPageIconSize.value = 1;

    controllPageLongContainerVerticalLine.value = 10;

    controllPageShortContainerX.value = Get.width * 0.2;
    controllPageShortContainerY.value = Get.height * 0.11;
  }

  //컨트롤뷰 진입시 애니메이션.
  //특정 컨테이너 내부의 크기값들은 딜레이를 나누어 오버플로우를 방지함.
  initToControlViewAnimation() {
    print('control view init');
    controllPageContainerAnimationOn.value = true;

    Future.delayed(
      Duration(milliseconds: 100),
      () {
        controllPageContainerOpacity.value = 1.0;
        //UI 한 라인의 X 길이 값의 총합은 width 의 90프로여야함.
        controllPageLongContainerX.value = Get.width * 0.9;
        controllPageLongContainerY.value = Get.height * 0.2;

        controllPageLongContainerVerticalLine.value = Get.height * 0.12;
        controllPageLongContainerSubBox.value = 55;

        //UI 한 라인의 X 길이 값의 총합은 width 의 90프로여야함.
        //0.4(Tags) + 0.4(DeletedMemo) + 0.1(SizedBox)
        controllPageShortContainerX.value = Get.width * 0.4;
        controllPageShortContainerY.value = Get.height * 0.17;
      },
    );

    //text, icon 같은 컨테이너 내부의 요소들.
    //컨테이너보다 늦게 커지도록 하여 오버플로우 방지.
    Future.delayed(Duration(milliseconds: 300), () {
      controllPageTextSize.value = 15;
      controllPageIconSize.value = 30;
    });
  }

  late final memoTileAnimationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 500),
    animationBehavior: AnimationBehavior.normal,
  );

  //여기서 db 를 init 하고 고정적으로 불러와야 할 값들을 가져옴.
  //초기에 불러와야 할 값들 : ui 에 표시될 날짜들, 메모 기본 색상 등.
  @override
  void onInit() async {
    super.onInit();

    await getScreenSize();
    await escapeFromControlViewAnimation();
    await MemoHelper.db();
    await getDefaultColor();
    await themeInit();
    await getCurrentYear();
    await getCurrentMonthMM();
    await getCurrentDay();
    await getCurrentDayOf();
    await getDayColor();
    await getCurrentMonthMMM();
    await getTiles();
    await tagInit();
    await firstInitGetDataKey();
    await refreshMemo();

    goToDown();

    //처음 한번 새로고침으로 메모 가져오기.
    // refreshMemoInit();

    //디바이스 테마 확인 디버그.
    print('is device theme dark: ${isDeviceThemeDark}');

    //테마 리스너

    //스크롤 리스너
    try {
      scrollController.value.addListener(() async {
        //아래로 내리기 버튼 활성화 감지를 위한 조건문.
        //현재 오프셋이 스크롤 컨트롤러 최대값보다 적다면 버튼을 활성화시킴.
        if (scrollController.value.offset <
            scrollController.value.position.maxScrollExtent) {
          goToDownButtonDontShow.value = false;
          // print('${goToDownButtonDontShow.value}');
        } else {
          goToDownButtonDontShow.value = true;
        }
        //offset이 0보다 낮아지면(화면이 위로 오버스크롤되면) 데이터 불러오기.
        // if (-100 >= scrollController.value.offset) {
        //   memoLenght.value += 10;
        //   refreshMemo();
        //   // await firstInitGetDataKey();
        //   // addPatchData();
        //   // print('sc');
        // }
        if (scrollController.value.offset >=
            scrollController.value.position.maxScrollExtent) {
          isScrollMax.value = true;
        } else {
          isScrollMax.value = false;
        }
      });
    } catch (e, s) {
      print(s);
    }

    //페이지 리스너.
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
