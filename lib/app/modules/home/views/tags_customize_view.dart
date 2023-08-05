import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:memotile/app/modules/home/controllers/home_controller.dart';

import '../../../global/palette.dart';

class TagsCustomizeView extends GetView<HomeController> {
  const TagsCustomizeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          controller.isDarkModeOn.value == true ? subDark : subLight,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor:
            controller.isDarkModeOn.value == true ? subDark : subLight,
        title: Text(
          'Tags Customize'.tr,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Container(
                      height: controller.height.value * 0.1,
                      decoration: BoxDecoration(
                        color: controller.isDarkModeOn.value == true
                            ? backgroundDark
                            : backgroundLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Stack(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: controller.height.value * 0.05,
                                    height: controller.height.value * 0.05,
                                    child: MaterialButton(
                                      splashColor: Colors.transparent,
                                      onPressed: () {},
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      color: Color(controller.redredValue),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //반복되는 UI이기에 코드 해설은 레드에 몰아서 설명함.
                          Expanded(
                            flex: 7,
                            child: TextField(
                              //최대길이 제한.
                              maxLength: 8,
                              focusNode: controller.redTagFocusNode,
                              controller: controller.redTagController,
                              decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                hintText: controller.tag.read('red'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    //값이 비어있을때 저장 버튼 누르면 기본값으로.
                                    if(controller.redTagController.text.isEmpty){
                                      controller.tag.write(
                                        'red',
                                        'red',
                                      );
                                    }else controller.tag.write(
                                      'red',
                                      controller.redTagController.text,
                                    );
                                    controller.redTagFocusNode.unfocus();
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: controller.height.value * 0.1,
                      decoration: BoxDecoration(
                        color: controller.isDarkModeOn.value == true
                            ? backgroundDark
                            : backgroundLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Stack(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: MaterialButton(
                                      splashColor: Colors.transparent,
                                      onPressed: () {},
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      color: Color(controller.blueValue),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              maxLength: 8,
                              focusNode: controller.blueTagFocusNode,
                              controller: controller.blueTagController,
                              decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                hintText:
                                    controller.tag.read('blue').toString() == ''
                                        ? 'blue'
                                        : controller.tag.read('blue'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    if(controller.blueTagController.text.isEmpty){
                                      controller.tag.write(
                                        'blue',
                                        'blue',
                                      );
                                    }else controller.tag.write(
                                      'blue',
                                      controller.blueTagController.text,
                                    );
                                    controller.blueTagFocusNode.unfocus();
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: controller.height.value * 0.1,
                      decoration: BoxDecoration(
                        color: controller.isDarkModeOn.value == true
                            ? backgroundDark
                            : backgroundLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Stack(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: MaterialButton(
                                      splashColor: Colors.transparent,
                                      onPressed: () {},
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      color: Color(
                                        controller.aquaValue,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              maxLength: 8,
                              focusNode: controller.aquaTagFocusNode,
                              controller: controller.aquaTagController,
                              decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                hintText: controller.tag.read('aqua'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    if(controller.aquaTagController.text.isEmpty){
                                      controller.tag.write(
                                        'aqua',
                                        'aqua',
                                      );
                                    }else controller.tag.write(
                                      'aqua',
                                      controller.aquaTagController.text,
                                    );
                                    controller.aquaTagFocusNode.unfocus();
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: controller.height.value * 0.1,
                      decoration: BoxDecoration(
                        color: controller.isDarkModeOn.value == true
                            ? backgroundDark
                            : backgroundLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Stack(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: MaterialButton(
                                      splashColor: Colors.transparent,
                                      onPressed: () {},
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      color: Color(controller.greenValue),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              maxLength: 8,
                              focusNode: controller.greenTagFocusNode,
                              controller: controller.greenTagController,
                              decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                hintText: controller.tag.read('green'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    if(controller.greenTagController.text.isEmpty){
                                      controller.tag.write(
                                        'green',
                                        'green',
                                      );
                                    }else controller.tag.write(
                                      'green',
                                      controller.greenTagController.text,
                                    );
                                    controller.greenTagFocusNode.unfocus();
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: controller.height.value * 0.1,
                      decoration: BoxDecoration(
                        color: controller.isDarkModeOn.value == true
                            ? backgroundDark
                            : backgroundLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Stack(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: MaterialButton(
                                      splashColor: Colors.transparent,
                                      onPressed: () {},
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      color: Color(controller.pinkValue),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              maxLength: 8,
                              focusNode: controller.pinkTagFocusNode,
                              controller: controller.pinkTagController,
                              decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                hintText: controller.tag.read('pink'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    if(controller.pinkTagController.text.isEmpty){
                                      controller.tag.write(
                                        'pink',
                                        'pink',
                                      );
                                    }else controller.tag.write(
                                      'pink',
                                      controller.pinkTagController.text,
                                    );
                                    controller.pinkTagFocusNode.unfocus();
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: controller.height.value * 0.1,
                      decoration: BoxDecoration(
                        color: controller.isDarkModeOn.value == true
                            ? backgroundDark
                            : backgroundLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Stack(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: MaterialButton(
                                      splashColor: Colors.transparent,
                                      onPressed: () {},
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      color: Color(controller.orangeValue),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              maxLength: 8,
                              focusNode: controller.orangeTagFocusNode,
                              controller: controller.orangeTagController,
                              decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                hintText: controller.tag.read('orange'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    if(controller.orangeTagController.text.isEmpty){
                                      controller.tag.write(
                                        'orange',
                                        'orange',
                                      );
                                    }else controller.tag.write(
                                      'orange',
                                      controller.orangeTagController.text,
                                    );
                                    controller.orangeTagFocusNode.unfocus();
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: controller.height.value * 0.1,
                      decoration: BoxDecoration(
                        color: controller.isDarkModeOn.value == true
                            ? backgroundDark
                            : backgroundLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Stack(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: MaterialButton(
                                      splashColor: Colors.transparent,
                                      onPressed: () {},
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      color: Color(controller.purpleValue),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              maxLength: 8,
                              focusNode: controller.purpleTagFocusNode,
                              controller: controller.purpleTagController,
                              decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                hintText: controller.tag.read('purple'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    if(controller.purpleTagController.text.isEmpty){
                                      controller.tag.write(
                                        'purple',
                                        'purple',
                                      );
                                    }else  controller.tag.write('purple',
                                        controller.purpleTagController.text);
                                    controller.purpleTagFocusNode.unfocus();
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: controller.height.value * 0.1,
                      decoration: BoxDecoration(
                        color: controller.isDarkModeOn.value == true
                            ? backgroundDark
                            : backgroundLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Stack(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: MaterialButton(
                                      splashColor: Colors.transparent,
                                      onPressed: () {},
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      color: Color(controller.mustardValue),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              maxLength: 8,
                              focusNode: controller.mustardTagFocusNode,
                              controller: controller.mustardTagController,
                              decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                hintText: controller.tag.read('mustard'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    if(controller.mustardTagController.text.isEmpty){
                                      controller.tag.write(
                                        'mustard',
                                        'mustard',
                                      );
                                    }else controller.tag.write(
                                      'mustard',
                                      controller.mustardTagController.text,
                                    );
                                    controller.mustardTagFocusNode.unfocus();
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
