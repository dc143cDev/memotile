import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';

class TagsCustomizeView extends GetView<HomeController> {
  const TagsCustomizeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          //Get.back 으로 나가면 바텀시트에는 태그 이름이 바로 반영되지 않기에 홈으로 이동.
          onPressed: () {
            Get.toNamed('/home');
          },
          icon: Icon(Icons.close),
        ),
        title: const Text(
          'Tags Customize',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
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
                      width: 380,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
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
                                      color: Colors.red,
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
                              controller: controller.redTagController,
                              decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                hintText: controller.tag.read('red'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.tag.write('red',
                                        controller.redTagController.text);
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
                      width: 380,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
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
                                      color: Colors.teal,
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
                              controller: controller.tealTagController,
                              decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                hintText:
                                    controller.tag.read('teal').toString() == ''
                                        ? 'teal'
                                        : controller.tag.read('teal'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.tag.write('teal',
                                        controller.tealTagController.text);
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
                      width: 380,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
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
                                      color: Color(0xfff28b81),
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
                              controller: controller.lightPinkTagController,
                              decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                hintText: controller.tag.read('lightPink'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.tag.write('lightPink',
                                        controller.lightPinkTagController.text);
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
                      width: 380,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
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
                                      color: Color(0xfffbf476),
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
                              controller: controller.yellowTagController,
                              decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                hintText: controller.tag.read('yellow'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.tag.write('yellow',
                                        controller.yellowTagController.text);
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
                      width: 380,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
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
                                      color: Color(0xffcdff90),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              controller: controller.lightGreenTagController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: controller.tag.read('lightGreen'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.tag.write(
                                        'lightGreen',
                                        controller
                                            .lightGreenTagController.text);
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
                      width: 380,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
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
                                      color: Color(0xffa7feeb),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              controller: controller.turquoiseTagController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: controller.tag.read('turquoise'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.tag.write('turquoise',
                                        controller.turquoiseTagController.text);
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
                      width: 380,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
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
                                      color: Color(0xffcbf0f8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              controller: controller.lightCyanTagController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: controller.tag.read('lightCyan'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.tag.write('lightCyan',
                                        controller.lightCyanTagController.text);
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
                      width: 380,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
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
                                      color: Color(0xffafcbfa),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              controller: controller.lightBlueTagController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: controller.tag.read('lightBlue'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.tag.write('lightBlue',
                                        controller.lightBlueTagController.text);
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
                      width: 380,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
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
                                      color: Color(0xffd7aefc),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              controller: controller.plumTagController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: controller.tag.read('plum'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.tag.write('plum',
                                        controller.plumTagController.text);
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
