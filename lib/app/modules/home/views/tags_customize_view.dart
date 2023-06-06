import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text(''),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  TextField(
                    controller: controller.redTagController,
                    decoration: InputDecoration(
                      hintText: controller.tag.read('red'),
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.tag.write('red', controller.redTagController.text);
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
