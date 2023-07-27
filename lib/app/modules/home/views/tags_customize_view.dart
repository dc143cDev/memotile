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
        title: const Text(
          'Tags Customize',
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
                          Expanded(
                            flex: 7,
                            child: TextField(
                              maxLength: 10,
                              controller: controller.redredTagController,
                              decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                hintText: controller.tag.read('red'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.tag.write(
                                      'red',
                                      controller.redredTagController.text,
                                    );
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
                              maxLength: 10,
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
                                    controller.tag.write('blue',
                                        controller.blueTagController.text);
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
                                      color: Color(controller.aquaValue),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              maxLength: 10,
                              controller: controller.aquaTagController,
                              decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                hintText: controller.tag.read('aqua'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.tag.write('aqua',
                                        controller.aquaTagController.text);
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
                              controller: controller.greenTagController,
                              decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                hintText: controller.tag.read('green'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.tag.write('green',
                                        controller.greenTagController.text);
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
                              controller: controller.pinkTagController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: controller.tag.read('pink'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.tag.write('pink',
                                        controller.pinkTagController.text);
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
                              controller: controller.orangeTagController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: controller.tag.read('orange'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.tag.write('orange',
                                        controller.orangeTagController.text);
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
                              controller: controller.purpleTagController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: controller.tag.read('purple'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.tag.write('purple',
                                        controller.purpleTagController.text);
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
                              controller: controller.mustardTagController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: controller.tag.read('mustard'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.tag.write('mustard',
                                        controller.mustardTagController.text);
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
