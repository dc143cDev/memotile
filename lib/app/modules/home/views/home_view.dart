import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:memotile/app/global/memo_tile_date.dart';
import 'package:memotile/app/global/palette.dart';
import 'package:memotile/app/modules/home/views/control_view.dart';

import '../../../global/horizontal_line.dart';
import '../../../global/memo_tile.dart';
import '../../../global/memo_tile_tag.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    //바텀시트 키보드 오버플로우 방지용.
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    //서치 탭 바텀시트.
    openSearchSheet() async {
      //검색버튼을 누르는 순간에 클리어를 두면 앱바 ui에 반영되지 않기에 바텀시트를 불러올때 클리어를 둠.
      controller.searchBarController.clear();
      if (controller.tagModeOn.value == true) {
        controller.refreshMemoByColor(controller.colorValue.value);
      }
      Get.bottomSheet(
        enterBottomSheetDuration: Duration(milliseconds: 200),
        exitBottomSheetDuration: Duration(milliseconds: 200),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        backgroundColor: controller.isDarkModeOn.value == true
            ? backgroundDark
            : backgroundLight,
        elevation: 0,
        isScrollControlled: true,
        SizedBox(
          //바텀시트 키보드 오버플로우 방지.
          height: controller.height / 2 + bottomInset,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 13,
              ),
              Center(
                child: SizedBox(
                  width: 50,
                  height: 5,
                  child: Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        color: controller.isDarkModeOn.value == true
                            ? subDark
                            : subLight,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 12, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tags'.tr,
                      style: TextStyle(),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/tags');
                      },
                      child: Text(
                        'Customizing'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: controller.isDarkModeOn.value == true
                              ? iconDark
                              : iconLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(13, 3, 13, 13),
                child: SizedBox(
                  height: 78,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 48,
                            width: 48,
                            child: MaterialButton(
                              onPressed: () async {
                                await controller.getRedRed();
                                controller.nowTag.value = 'red';
                                controller.tagButtonClicked();
                                controller.refreshMemoByColor(
                                  controller.colorValue.value,
                                );
                                Get.back();
                              },
                              color: Color(controller.redredValue),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(controller.tag.read('red')),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 48,
                            width: 48,
                            child: MaterialButton(
                              onPressed: () async {
                                await controller.getBlue();
                                controller.nowTag.value = 'blue';
                                controller.tagButtonClicked();
                                controller.refreshMemoByColor(
                                    controller.colorValue.value);
                                Get.back();
                              },
                              color: Color(controller.blueValue),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(controller.tag.read('blue')),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 48,
                            width: 48,
                            child: MaterialButton(
                              onPressed: () {
                                controller.getAqua();
                                controller.nowTag.value = 'aqua';
                                controller.tagButtonClicked();
                                controller.refreshMemoByColor(
                                    controller.colorValue.value);
                                Get.back();
                              },
                              color: Color(controller.aquaValue),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(controller.tag.read('aqua')),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 48,
                            width: 48,
                            child: MaterialButton(
                              onPressed: () {
                                controller.getGreen();
                                controller.nowTag.value = 'green';
                                controller.tagButtonClicked();
                                controller.refreshMemoByColor(
                                    controller.colorValue.value);
                                Get.back();
                              },
                              color: Color(controller.greenValue),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(controller.tag.read('green')),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 48,
                            width: 48,
                            child: MaterialButton(
                              onPressed: () {
                                controller.getPink();
                                controller.nowTag.value = 'pink';
                                controller.tagButtonClicked();
                                controller.refreshMemoByColor(
                                  controller.colorValue.value,
                                );
                                Get.back();
                              },
                              color: Color(controller.pinkValue),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(controller.tag.read('pink')),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 48,
                            width: 48,
                            child: MaterialButton(
                              onPressed: () {
                                controller.getOrange();
                                controller.nowTag.value = 'orange';
                                controller.tagButtonClicked();
                                controller.refreshMemoByColor(
                                    controller.colorValue.value);
                                Get.back();
                              },
                              color: Color(controller.orangeValue),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(controller.tag.read('orange')),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 48,
                            width: 48,
                            child: MaterialButton(
                              onPressed: () {
                                controller.getPurple();
                                controller.nowTag.value = 'purple';
                                controller.tagButtonClicked();
                                controller.refreshMemoByColor(
                                    controller.colorValue.value);
                                Get.back();
                              },
                              color: Color(controller.purpleValue),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(controller.tag.read('purple')),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 48,
                            width: 48,
                            child: MaterialButton(
                              onPressed: () {
                                controller.getMustard();
                                controller.nowTag.value = 'mustard';
                                controller.tagButtonClicked();
                                controller.refreshMemoByColor(
                                    controller.colorValue.value);
                                Get.back();
                              },
                              color: Color(controller.mustardValue),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(controller.tag.read('mustard')),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
              HorizontalLine(),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    'Searching'.tr,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: controller.isDarkModeOn.value == true
                        ? subDark
                        : subLight,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Obx(
                            () => TextFormField(
                              focusNode: controller.searchTextFocus,
                              controller: controller.searchBarController,
                              maxLength: 8,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    await controller.searchButtonClicked();
                                    await controller.refreshMemoByContent(
                                      controller.searchBarController.text,
                                    );
                                    controller.memoController.clear();
                                    // controller.searchBarController.clear();
                                    //여기에 클리어를 두면 앱바 ui 수정에 반영되지 않음.
                                    // controller.searchBarController.clear();
                                    Get.back();
                                  },
                                  icon: Icon(Icons.search_rounded),
                                ),
                                counterText: '',
                                //힌트텍스트는 포커스 잡혀있을땐 보이지 않게끔.
                                hintText:
                                    controller.searchTextFocus.hasFocus == true
                                        ? ''
                                        : 'Search here'.tr,
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: controller.isDarkModeOn.value == true
                                      ? iconDark
                                      : iconLight,
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (String text) async {
                                //콘텐츠 검색기능 사용시 태그 검색모드 해제
                                controller.tagModeOn.value = false;
                                controller.searchModeOn.value = false;
                                controller.refreshMemoByContent(text);
                              },
                              onTapOutside: (P) {
                                // 태그 검색모드 활성화된 상태라면 바깥 쪽을 터치해도 태그 검색모드가 해제되지 않도록 함.
                                if (controller.tagModeOn.value == false) {
                                  controller.refreshMemo();
                                }
                                controller.memoController.clear();
                                controller.searchBarController.clear();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );
    }

    //Empty UI
    final emptyUI = Obx(
      () => SizedBox(
        width: controller.width.value * 0.5,
        height: controller.height.value * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: controller.width.value * 0.35,
              height: controller.height.value * 0.05,
              decoration: BoxDecoration(
                color:
                    controller.isDarkModeOn.value == true ? subDark : subLight,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      'Memo is Empty'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: controller.isDarkModeOn.value == true
                            ? backgroundDark
                            : backgroundLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: controller.width.value * 0.2,
              height: controller.height.value * 0.05,
              decoration: BoxDecoration(
                color:
                    controller.isDarkModeOn.value == true ? subDark : subLight,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 3,
                  ),
                  Expanded(
                    child: Icon(
                      Icons.warning,
                      color: controller.isDarkModeOn.value == true
                          ? backgroundDark
                          : backgroundLight,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '~!@',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: controller.isDarkModeOn.value == true
                            ? backgroundDark
                            : backgroundLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: controller.width.value * 0.5,
              height: controller.height.value * 0.13,
              decoration: BoxDecoration(
                color:
                    controller.isDarkModeOn.value == true ? subDark : subLight,
                borderRadius: BorderRadius.circular(15),
              ),
              child: controller.tagModeOn.value == true
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              'Can not found Memo'.tr,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: controller.isDarkModeOn.value == true
                                    ? backgroundDark
                                    : backgroundLight,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Row(
                            children: [
                              Text(
                                'Tagged in '.tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: controller.isDarkModeOn.value == true
                                      ? backgroundDark
                                      : backgroundLight,
                                ),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Text(
                            controller.tag.read(controller.nowTag.value),
                            style: TextStyle(
                                color: Color(controller.colorValue.value),
                                fontWeight: FontWeight.bold),
                          )),
                        ],
                      ),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Text(
                            'Please get send button\nTo add Memo'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: controller.isDarkModeOn.value == true
                                  ? backgroundDark
                                  : backgroundLight,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );

    final emptyUISearchMode = Obx(
      () => SizedBox(
        width: controller.width.value * 0.5,
        height: controller.height.value * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: controller.width.value * 0.35,
              height: controller.height.value * 0.05,
              decoration: BoxDecoration(
                color:
                    controller.isDarkModeOn.value == true ? subDark : subLight,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      'Memo is Empty'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: controller.isDarkModeOn.value == true
                            ? backgroundDark
                            : backgroundLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: controller.width.value * 0.2,
              height: controller.height.value * 0.05,
              decoration: BoxDecoration(
                color:
                    controller.isDarkModeOn.value == true ? subDark : subLight,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 3,
                  ),
                  Expanded(
                    child: Icon(
                      Icons.search_rounded,
                      color: controller.isDarkModeOn.value == true
                          ? backgroundDark
                          : backgroundLight,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '~!@',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: controller.isDarkModeOn.value == true
                            ? backgroundDark
                            : backgroundLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: controller.width.value * 0.5,
              height: controller.height.value * 0.15,
              decoration: BoxDecoration(
                color:
                    controller.isDarkModeOn.value == true ? subDark : subLight,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'Can not found Memo'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: controller.isDarkModeOn.value == true
                              ? backgroundDark
                              : backgroundLight,
                        ),
                      ),
                    ),
                    Obx(
                      () => Expanded(
                        child: Text(
                          'Searched in '.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: controller.isDarkModeOn.value == true
                                ? backgroundDark
                                : backgroundLight,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      controller.searchBarController.text,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: controller.isDarkModeOn.value == true
                            ? backgroundDark
                            : backgroundLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );

    //화면 전체를 제스처 디텍터로 감싸주어 제스쳐 감지.
    final home = GestureDetector(
      //화면 * 0.2 범위 내에서 드래그가 시작되면 드래그 인지.
      onHorizontalDragStart: (ds) {
        if (ds.globalPosition.dx < controller.width * 0.3) {
          //에딧모드 드래그 시작.
          controller.dragStartForEditMode.value = true;
        }
        //화면 * 0.8 지점보다 큰 범위 내에서 드래그가 시작되면 드래그 인지.
        if (ds.globalPosition.dx > controller.width * 0.7) {
          //페이지변환 드래그 시작.
          controller.dragStartForPageSwipe.value = true;
        }
      },
      onHorizontalDragEnd: (de) async {
        //에딧모드 드래그가 시작되었고, 종료되는 지점이 화면 * 0.2 이상이라면, 에딧모드 작동 후 드래그 종료.
        if (de.velocity.pixelsPerSecond.dx > controller.width * 0.3 &&
            controller.dragStartForEditMode.value == true) {
          await controller.editModeInitAnimation();
          await controller.editModeDoneOne();
          controller.isOneEditMode.value = false;
          //textField 포커싱되어있으면 풀어주기.
          controller.textFocus.unfocus();
          //에딧모드 드래그 종료.
          controller.dragStartForEditMode.value = false;
        }
        //페이지변환 드래기그 시작되었고, 드래그 종료되는 지점이 화면 * 0.8 지점 이하라면, 페이지 변환 후 드래그 종료.
        if (de.velocity.pixelsPerSecond.dx < controller.width * 0.7 &&
            controller.dragStartForPageSwipe.value == true) {
          //textField 포커싱되어있으면 풀어주기.
          controller.textFocus.unfocus();
          controller.getTiles();
          controller.pageController.animateToPage(
            1,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
          //컨트롤 페이지로 넘어갈때 에딧모드 해제. 자연스러운 해제를 위해 딜레이 주기.
          controller.editModeDone();
          controller.editModeDoneOne();

          Future.delayed(
            Duration(milliseconds: 100),
            () {
              controller.isEditMode.value = false;
              controller.isOneEditMode.value = false;
            },
          );
          //드래그 종료.
          controller.dragStartForPageSwipe.value = false;
        }
      },
      // onPanUpdate: (i) {
      //   //왼쪽에서 오른쪽으로 스와이프시 에딧모드.
      //   if (i.delta.dx >= 0.1) {
      //     controller.editModeInitAnimation();
      //   }
      // },
      onTap: () {
        //어느 화면이나 눌렀을때 텍스트 필드를 내리기 위해 Gesture Detector 감싸주기.
        controller.textFocus.unfocus();
        controller.searchTextFocus.unfocus();
      },
      child: Stack(
        children: [
          Scaffold(
            floatingActionButton: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(
                    () => FloatingActionButton(
                      heroTag: true,
                      backgroundColor: controller.isDarkModeOn.value == true ? subDark : subLight,
                      child: controller.isEditMode.value == true ||
                              controller.isOneEditMode.value == true ||
                              controller.searchModeOn.value == true ||
                              controller.tagModeOn.value == true
                          ? Icon(
                              Icons.close,
                              color: controller.isDarkModeOn.value == true
                                  ? iconDark
                                  : iconLight,
                            )
                          : Icon(
                              Icons.search_rounded,
                              color: controller.isDarkModeOn.value == true
                                  ? iconDark
                                  : iconLight,
                            ),
                      onPressed: () async {
                        if (controller.isEditMode.value == true ||
                            controller.isOneEditMode.value == true ||
                            controller.searchModeOn.value == true ||
                            controller.tagModeOn.value == true) {
                          //에딧모드 종료시 실행되는 메소드.
                          await controller.editModeDone();
                          await controller.editModeDoneOne();

                          Future.delayed(Duration(milliseconds: 200), () {
                            controller.defaultModeOn();
                          });
                        } else {
                          // controller.isEditMode.value = true;
                          openSearchSheet();
                        }
                      },
                    ),
                  ),

                  //스크롤 컨트롤러 offset이 맨 아래가 아니라면 아래로 내리기 버튼을 활성화함.
                  controller.goToDownButtonDontShow.value == true
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Align(
                            alignment: Alignment(1, 1),
                            child: Obx(
                              () => FloatingActionButton(
                                backgroundColor:
                                    controller.isDarkModeOn.value == true
                                        ? subDark
                                        : subLight,
                                child: Icon(
                                  Icons.arrow_downward_sharp,
                                  color: controller.isDarkModeOn.value == true
                                      ? iconDark
                                      : iconLight,
                                ),
                                onPressed: () {
                                  controller.goToDown();
                                },
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 0,
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              elevation: 0,
              centerTitle: false,
              scrolledUnderElevation: 0,
              // backgroundColor: Colors.white.withOpacity(0.9),
              backgroundColor: Colors.transparent,
              //타이틀도 leading 과 같이 모드 가변형 ui.
              // title: appBarTitle,
              title: Obx(
                () => controller.tagModeOn == true ||
                        controller.searchModeOn == true
                    ? Row(
                        children: [
                          controller.searchModeOn.value == true
                              ? Text(
                                  //서치모드
                                  controller.searchBarController.text,
                                  style: TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              : Text(
                                  //태그모드
                                  controller.tag.read(controller.nowTag.value),
                                  style: TextStyle(
                                    color: Color(controller.colorValue.value),
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                          IconButton(
                            onPressed: () {
                              controller.defaultModeOn();
                              controller.refreshMemo();
                            },
                            icon: Icon(
                              Icons.close,
                              size: 30,
                              color: controller.isDarkModeOn.value == true
                                  ? iconDark
                                  : iconLight,
                            ),
                          ),
                        ],
                      )
                    //디폴트 모드 or 날짜모드.
                    : controller.dateModeOn.value == true
                        ? Row(
                            children: [
                              Text(
                                //요일
                                controller.selectedDay.value,
                                style: TextStyle(
                                  // color: Colors.black,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.defaultModeOn();
                                  controller.refreshMemo();
                                },
                                icon: Icon(
                                  Icons.close,
                                  size: 30,
                                  color: controller.isDarkModeOn.value == true
                                      ? iconDark
                                      : iconLight,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            //디폴트 모드 타이틀. 로고.
                            'MOTOMEE',
                            style: TextStyle(
                              // color: Color(controller.ssDayColorValue.value),
                              fontSize: 27,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
              ),
            ),
            extendBodyBehindAppBar: true,
            bottomNavigationBar: Obx(
              () => Padding(
                //키보드 가리기 방지.
                padding: MediaQuery.of(context).viewInsets,
                child: Form(
                  key: this.key,
                  child: BottomAppBar(
                    height: controller.isEditMode.value == true ||
                            controller.isOneEditMode.value == true
                        ? controller.height.value * 0.23
                        : controller.height.value * 0.12,
                    elevation: 0,
                    shadowColor: controller.isDarkModeOn.value == true
                        ? shadowDark
                        : shadowLight,
                    surfaceTintColor: null,
                    color: controller.isDarkModeOn.value == true
                        ? subDark
                        : subLight,
                    child: controller.isEditMode.value == true ||
                            controller.isOneEditMode.value == true
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  children: controller.tagModeOn.value == true
                                      ? []
                                      : [
                                          Expanded(
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: [
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        height: controller.width * 0.1,
                                                        width: controller.width * 0.1,
                                                        child: MaterialButton(
                                                          onPressed: () async {
                                                            await controller
                                                                .getRedRed();
                                                            controller
                                                                .editModeItemColorFill(
                                                                    controller
                                                                        .colorValue
                                                                        .value);
                                                          },
                                                          color: Color(
                                                              controller
                                                                  .redredValue),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(controller.tag
                                                          .read('red')),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        height: controller.width * 0.1,
                                                        width: controller.width * 0.1,
                                                        child: MaterialButton(
                                                          onPressed: () async {
                                                            await controller
                                                                .getBlue();
                                                            controller
                                                                .editModeItemColorFill(
                                                                    controller
                                                                        .colorValue
                                                                        .value);
                                                          },
                                                          color: Color(
                                                              controller
                                                                  .blueValue),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(controller.tag
                                                          .read('blue')),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        height: controller.width * 0.1,
                                                        width: controller.width * 0.1,
                                                        child: MaterialButton(
                                                          onPressed: () async {
                                                            await controller
                                                                .getAqua();
                                                            controller
                                                                .editModeItemColorFill(
                                                                    controller
                                                                        .colorValue
                                                                        .value);
                                                          },
                                                          color: Color(
                                                              controller
                                                                  .aquaValue),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(controller.tag
                                                          .read('aqua')),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        height: controller.width * 0.1,
                                                        width: controller.width * 0.1,
                                                        child: MaterialButton(
                                                          onPressed: () async {
                                                            await controller
                                                                .getGreen();
                                                            controller
                                                                .editModeItemColorFill(
                                                                    controller
                                                                        .colorValue
                                                                        .value);
                                                          },
                                                          color: Color(
                                                              controller
                                                                  .greenValue),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(controller.tag
                                                          .read('green')),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        height: controller.width * 0.1,
                                                        width: controller.width * 0.1,
                                                        child: MaterialButton(
                                                          onPressed: () async {
                                                            await controller
                                                                .getPink();
                                                            controller
                                                                .editModeItemColorFill(
                                                                    controller
                                                                        .colorValue
                                                                        .value);
                                                          },
                                                          color: Color(
                                                              controller
                                                                  .pinkValue),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(controller.tag
                                                          .read('pink')),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        height: controller.width * 0.1,
                                                        width: controller.width * 0.1,
                                                        child: MaterialButton(
                                                          onPressed: () async {
                                                            await controller
                                                                .getOrange();
                                                            controller
                                                                .editModeItemColorFill(
                                                                    controller
                                                                        .colorValue
                                                                        .value);
                                                          },
                                                          color: Color(
                                                              controller
                                                                  .orangeValue),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(controller.tag
                                                          .read('orange')),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        height: controller.width * 0.1,
                                                        width: controller.width * 0.1,
                                                        child: MaterialButton(
                                                          onPressed: () async {
                                                            await controller
                                                                .getPurple();
                                                            controller
                                                                .editModeItemColorFill(
                                                                    controller
                                                                        .colorValue
                                                                        .value);
                                                          },
                                                          color: Color(
                                                              controller
                                                                  .purpleValue),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(controller.tag
                                                          .read('purple')),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        height: controller.width * 0.1,
                                                        width: controller.width * 0.1,
                                                        child: MaterialButton(
                                                          onPressed: () async {
                                                            await controller
                                                                .getMustard();
                                                            controller
                                                                .editModeItemColorFill(
                                                                    controller
                                                                        .colorValue
                                                                        .value);
                                                          },
                                                          color: Color(controller
                                                              .mustardValue),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        controller.tag
                                                            .read('mustard'),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(
                                          //       left: 0,
                                          //       top: 5,
                                          //       right: 14,
                                          //       bottom: 5),
                                          //   child: IconButton(
                                          //     icon: Icon(
                                          //       Icons.delete,
                                          //       color: Colors.red,
                                          //     ),
                                          //     onPressed: () {
                                          //
                                          //     },
                                          //   ),
                                          // ),
                                        ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: controller.isOneEditMode.value == true
                                    ? [
                                        ElevatedButton(
                                          onPressed: () {
                                            controller.editModeItemDelete();
                                            controller.isOneEditMode.value =
                                                false;
                                            controller.refreshMemo();
                                          },
                                          child: Text(
                                            'Delete Memo'.tr,
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ]
                                    : [
                                        ElevatedButton(
                                          onPressed: () {
                                            controller.editModeDone();
                                            controller.refreshMemo();
                                          },
                                          child: Text(
                                            'Check Clear'.tr,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            controller.editModeItemDelete();
                                            controller.refreshMemo();
                                          },
                                          child: Text(
                                            'Delete Checked Memo'.tr,
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                              ),
                            ],
                          )
                        : Row(
                            //디폴트모드 인서트.
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Container(
                                    child: Obx(
                                      () => TextFormField(
                                        key: this.key,
                                        focusNode: controller.textFocus,
                                        controller: controller.memoController,
                                        maxLength: 500,
                                        cursorColor:
                                            controller.isDarkModeOn.value ==
                                                    true
                                                ? iconDark
                                                : iconLight,
                                        decoration: InputDecoration(
                                          counterText: '',
                                          border: InputBorder.none,
                                          focusColor:
                                              controller.isDarkModeOn.value ==
                                                      true
                                                  ? subDark
                                                  : subLight,
                                          //힌트 텍스트는 포커스 잡혀있지 않을때만.
                                          hintText:
                                              controller.textFocus.hasFocus ==
                                                      true
                                                  ? ''
                                                  : 'Insert here'.tr,
                                          hintStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                controller.isDarkModeOn.value ==
                                                        true
                                                    ? iconDark
                                                    : shadowLight,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, top: 5, right: 14, bottom: 5),
                                child: IconButton(
                                  //+ 버튼
                                  //눌렀을 때 addItem 메소드 실행
                                  //->TextField 의 Text, 현재 시간, colorValue 의 값을 db 에 insert
                                  onPressed: () async {
                                    //dateTime 데이터는 원래 '' 이므로 해당 값을 가져와주는 메소드를 먼저 실행.
                                    //공백 입력 방지.
                                    if (controller.memoController.text
                                            .toString() !=
                                        '') {
                                      await controller.getDefaultColor();
                                      await controller.getCurrentDay();
                                      await controller.getCurrentMonthMM();
                                      await controller.getCurrentYear();
                                      await controller.getCurrentDayDetail();
                                      await controller.getCurrentDate();
                                      //실물기기 에러포인트.
                                      await controller.firstCheckByDate();
                                      controller.addItem();
                                      //스크롤 아래로 내리기.
                                      controller.goToDown();
                                      //TextField 초기화.
                                      controller.memoController.clear();
                                      //defaultModeOn
                                      controller.defaultModeOn();
                                      //debug.
                                      print(controller.colorValue.value
                                          .toString());
                                      print(controller.CurrentDayDetail.value
                                          .toString());
                                    } else {
                                      Get.snackbar(
                                        'The content is empty!'.tr,
                                        'Please add some content'.tr,
                                        duration: Duration(milliseconds: 1000),
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    Icons.send_rounded,
                                    color: controller.isDarkModeOn.value == true
                                        ? iconDark
                                        : iconLight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
            body: Obx(
              () => Stack(
                children: [
                  //FAB 우측하단 바텀앱바와 옆 페이지 연결하는 부위.
                  //sub.
                  Align(
                    alignment: Alignment(1.0, 1.0),
                    child: Container(
                      width: controller.width * 0.09,
                      height: controller.height * 0.082,
                      color: controller.isDarkModeOn.value == true
                          ? subDark
                          : subLight,
                    ),
                  ),
                  //backgound.
                  Align(
                    alignment: Alignment(1.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25),
                        ),
                        color: controller.isDarkModeOn.value == true
                            ? backgroundDark
                            : backgroundLight,
                      ),
                      width: controller.width * 0.09,
                      height: controller.height * 0.082,
                    ),
                  ),
                  SafeArea(
                    //아무런 메모가 없을 경우 나오는 화면.
                    //메모의 갯수가 삭제된 메모의 갯수와 같거나(모두 쓰레기통에 있는 경우)
                    //또는 메모가 아예 비어있다면, empty화면을 표기함. 자세한 동작원리는 컨트롤러에.
                    child: controller.memo.isEmpty == true ||
                            controller
                                    .isDeletedMemoLenghtSameWithNormalMemoLenght
                                    .value ==
                                true
                        ? Column(
                            children: [
                              Expanded(
                                child: controller.searchTextFocus.hasFocus ==
                                            true ||
                                        controller.searchModeOn.value == true
                                    //searchMode empty.
                                    ? Center(
                                        child: emptyUISearchMode,
                                      )
                                    //default empty.
                                    : Center(
                                        child: emptyUI,
                                      ),
                              ),

                              //textField. empty 상태일때 굳이 필요 없다고 판단.
                            ],
                          )
                        : Column(
                            children: [
                              Expanded(
                                child: Obx(
                                  () => Padding(
                                    //스크롤 맨 아래에 닿았을때 메모가 화면과 닿아보이면 가독성 떨어짐.
                                    //그렇다고 항상 패딩값을 주면 메모 스크롤될때 해당 패딩값만큼 배경색 틈이 생김.
                                    //따라서 스크롤 벨류 읽어서 맨 아래에 닿았을때만 패딩 주기.
                                    padding: EdgeInsets.only(
                                        bottom:
                                            controller.isScrollMax.value == true
                                                ? 10
                                                : 0),
                                    child: controller.tagModeOn.value == true
                                        //모드에 따라 다른 tile UI를 빌드함.
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            reverse: false,
                                            //아이템이 화면을 다 채우지 않아도 스크롤되도록 함.
                                            physics:
                                                AlwaysScrollableScrollPhysics(),
                                            controller: controller
                                                .scrollController.value,
                                            itemCount: controller.memo.length,
                                            itemBuilder: (context, index) {
                                              return MemoTileTag(
                                                //memo_tile ui 에 들어갈 각 객체를 index 와 column 값을 넣어 구성.
                                                id: controller.memo[index]
                                                    ['id'],
                                                text: controller.memo[index]
                                                    ['content'],
                                                isEditChecked:
                                                    controller.memo[index]
                                                        ['isEditChecked'],
                                                date: controller.memo[index]
                                                    ['dateData'],
                                                isDeleted: controller
                                                    .memo[index]['isDeleted'],
                                                colorValue: controller
                                                    .memo[index]['colorValue'],
                                              );
                                            },
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            reverse: false,
                                            //아이템이 화면을 다 채우지 않아도 스크롤되도록 함.
                                            physics:
                                                AlwaysScrollableScrollPhysics(),
                                            controller: controller
                                                .scrollController.value,
                                            itemCount: controller.memo.length,
                                            itemBuilder: (context, index) {
                                              return controller
                                                          .dateModeOn.value ==
                                                      true
                                                  ? MemoTileDate(
                                                      id: controller.memo[index]
                                                          ['id'],
                                                      text:
                                                          controller.memo[index]
                                                              ['content'],
                                                      createdAt:
                                                          controller.memo[index]
                                                              ['createdAt'],
                                                      isEditChecked:
                                                          controller.memo[index]
                                                              ['isEditChecked'],
                                                      date:
                                                          controller.memo[index]
                                                              ['dateData'],
                                                      isDeleted:
                                                          controller.memo[index]
                                                              ['isDeleted'],
                                                      colorValue:
                                                          controller.memo[index]
                                                              ['colorValue'],
                                                    )
                                                  : MemoTile(
                                                      //memo_tile ui 에 들어갈 각 객체를 index 와 column 값을 넣어 구성.
                                                      id: controller.memo[index]
                                                          ['id'],
                                                      text:
                                                          controller.memo[index]
                                                              ['content'],
                                                      createdAt:
                                                          controller.memo[index]
                                                              ['createdAt'],
                                                      isEditChecked:
                                                          controller.memo[index]
                                                              ['isEditChecked'],
                                                      isEditing:
                                                          controller.memo[index]
                                                              ['isEditing'],
                                                      date:
                                                          controller.memo[index]
                                                              ['dateData'],
                                                      isFirst:
                                                          controller.memo[index]
                                                              ['isFirst'],
                                                      isDeleted:
                                                          controller.memo[index]
                                                              ['isDeleted'],
                                                      colorValue:
                                                          controller.memo[index]
                                                              ['colorValue'],
                                                    );
                                            },
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
          //넘어가기 버튼과 그를 감싸는 ui들.
          Obx(
            () => Stack(
              children: [
                //위에 장식
                Positioned(
                  bottom: controller.height * 0.87,
                  left: controller.width * 0.91,
                  child: Container(
                    width: controller.width * 0.09,
                    height: controller.height * 0.082,
                    color: controller.isDarkModeOn.value == true
                        ? subDark
                        : subLight,
                  ),
                ),
                Positioned(
                  bottom: controller.height * 0.88,
                  left: controller.width * 0.91,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                      ),
                      color: controller.isDarkModeOn.value == true
                          ? backgroundDark
                          : backgroundLight,
                    ),
                    width: controller.width * 0.09,
                    height: controller.height * 0.082,
                  ),
                ),
                //아래 장식
                Positioned(
                  bottom: controller.height * 0.72,
                  left: controller.width * 0.91,
                  child: Container(
                    width: controller.width * 0.09,
                    height: controller.height * 0.082,
                    color: controller.isDarkModeOn.value == true
                        ? subDark
                        : subLight,
                  ),
                ),
                Positioned(
                  bottom: controller.height * 0.72,
                  left: controller.width * 0.91,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                      ),
                      color: controller.isDarkModeOn.value == true
                          ? backgroundDark
                          : backgroundLight,
                    ),
                    width: controller.width * 0.09,
                    height: controller.height * 0.082,
                  ),
                ),
                Positioned(
                  //넘어가기 버튼 뒤에 컨테이너.
                  bottom: controller.height * 0.8,
                  left: controller.width * 0.83,
                  child: Obx(
                    () => Container(
                      width: controller.height * 0.1,
                      height: controller.height * 0.08,
                      decoration: BoxDecoration(
                        color: controller.isDarkModeOn.value == true
                            ? subDark
                            : subLight,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: controller.isDarkModeOn.value == true
                                      ? shadowDark
                                      : shadowLight,
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(0, 5),
                                )
                              ],
                            ),
                            child: Container(
                              width: controller.width.value * 0.1 + 3,
                              height: controller.width.value * 0.1,
                              decoration: BoxDecoration(
                                color: controller.isDarkModeOn.value == true
                                    ? backgroundDark
                                    : backgroundLight,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Material(
                                borderRadius: BorderRadius.circular(15),
                                child: IconButton(
                                  onPressed: () async {
                                    //타일 데이터 가져오기.
                                    await controller.getTiles();
                                    //textField 포커싱되어있으면 풀어주기.
                                    controller.textFocus.unfocus();
                                    controller.pageController.animateToPage(1,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeIn);
                                    //컨트롤 페이지로 넘어갈때 에딧모드 해제. 자연스러운 해제를 위해 딜레이 주기.
                                    controller.editModeDone();
                                    await controller.editModeDoneOne();
                                    Future.delayed(
                                      Duration(milliseconds: 200),
                                      () {
                                        controller.isEditMode.value = false;
                                        controller.isOneEditMode.value = false;
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios_new_outlined,
                                    color: controller.isDarkModeOn.value == true
                                        ? iconDark
                                        : iconLight,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    //최종 빌드될 리턴.
    return PageView(
      onPageChanged: (int) async {
        //이벤트 마커 타일 가져오기.
        await controller.getTiles();
        if (controller.controllPageContainerAnimationOn.value == false) {
          await controller.initToControlViewAnimation();
        } else if (controller.controllPageContainerAnimationOn.value == true) {
          controller.escapeFromControlViewAnimation();
          //메모 상태 한번 리프레쉬하여 리커버 등 상태변화시 ui 다시 그려주기.
          //이걸 안해주면 데이터상으로 firstRefresh가 되어도 ui에 그려지진 않음.
          Future.delayed(Duration(milliseconds: 1), () {
            // controller.refreshMemo();
            controller.goToDown();
          });
        }
        controller.CurrentMonthForTile.value = controller.CurrentMonthMMM.value;
      },
      physics: ClampingScrollPhysics(),
      controller: controller.pageController,
      children: [
        home,
        //컨트롤뷰는 네비게이션 되는게 아니라 사전에 불러와진 뷰를 넘기는것 뿐.
        ControlView(),
      ],
    );
  }

//타일뷰 바텀시트.
//사용하지 않는 코드지만 동작원리 복습을 위해 주석으로 남겨둠.
// openTileSheet() async {
//   //모드 초기화를 위해 메모 리프레쉬.
//   await controller.refreshMemo();
//   await controller.defaultModeOn();
//   //Tile View 로 넘어가기 전에 memoForEvent 에 월별로 가져온 데이터 넣기.
//   await controller.getTiles();
//   await controller.goToDown();
//   //CurrentMonthForTile 의 초기 값은 '' 이므로 평소에는 타이틀에 아무 값도 나오지 않음.
//   controller.CurrentMonthForTile.value = controller.CurrentMonthMMM.value;
//   Get.bottomSheet(
//     enterBottomSheetDuration: Duration(milliseconds: 200),
//     exitBottomSheetDuration: Duration(milliseconds: 200),
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//     backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
//     elevation: 0,
//     SafeArea(
//       child: SizedBox(
//         height: 440,
//         width: double.infinity,
//         child: Column(
//           children: [
//             SizedBox(
//               height: 13,
//             ),
//             Center(
//               child: SizedBox(
//                 width: 50,
//                 height: 5,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey,
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 16,
//             ),
//             Expanded(
//               flex: 1,
//               child: Obx(
//                 () => Text(
//                   controller.CurrentMonthForTile.value,
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20),
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 9,
//               child: TableCalendar(
//                 calendarBuilders: CalendarBuilders(
//                     //마커 타일 빌더.
//                     //context 와 날짜(년월일시분초까지 다 표시되는 버전), event(List)를 넘겨줄수 있음.
//                     markerBuilder: (context, day, events) {
//                   //events 의 원형은 [ 단일객체 ] (length == 1) 이기때문에 두번 걸러 리스트화 해야함.
//                   //to String,
//                   String eventToString = events.toString();
//                   //jsonDecode from String to List.
//                   List stringEventToList = jsonDecode(eventToString);
//                   if (events.isNotEmpty == true) {
//                     return Center(
//                       child: MarKerTile(
//                         date: '',
//                         event: DateFormat('dd').format(day),
//                         //그렇게 리스트화된 colorValue 객체 중 하나를 ui에 넣어주기.
//                         colorList: stringEventToList,
//                         color: stringEventToList.last,
//                       ),
//                     );
//                   }
//                   return null;
//                 }),
//                 calendarStyle: CalendarStyle(
//                   markerDecoration: BoxDecoration(
//                     color: Colors.red,
//                   ),
//                 ),
//                 headerStyle: HeaderStyle(
//                   titleTextStyle: TextStyle(color: Colors.white),
//                   titleCentered: true,
//                   leftChevronVisible: false,
//                   rightChevronVisible: false,
//                   formatButtonVisible: false,
//                 ),
//                 eventLoader: (day) {
//                   return controller.getEvents(day);
//                 },
//                 focusedDay: DateTime.now(),
//                 firstDay: DateTime(2010, 5, 1),
//                 lastDay: DateTime(2033, 12, 31),
//                 onDaySelected:
//                     (DateTime selectedDay, DateTime focusedDay) async {
//                   //DB 검색 용이성을 위해 미리 지정된 포맷으로 selectedDay 반환.
//                   await controller.goToTop();
//                   controller.selectedDay.value =
//                       DateFormat("yyyyMMdd").format(selectedDay);
//                   print('$selectedDay is selected');
//                   print('$focusedDay is focused');
//                   print(controller.selectedDay);
//                   controller.refreshMemoByDateTile(controller.selectedDay);
//                   controller.dateButtonClicked();
//                   controller.goToDown();
//                   Get.back();
//                 },
//                 onPageChanged: (day) {
//                   //페이지 전환할때마다 값을 지금이 몇월인지 값 넘겨주기.
//                   controller.CurrentMonthForTile.value =
//                       DateFormat('MMM').format(day);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
}
