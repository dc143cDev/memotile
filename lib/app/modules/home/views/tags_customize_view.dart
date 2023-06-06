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
          onPressed: () {
            Get.back();
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
