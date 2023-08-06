import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:memotile/app/modules/home/controllers/home_controller.dart';

import '../../../global/palette.dart';

class LocaleView extends GetView<HomeController> {
  const LocaleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          controller.isDarkModeOn.value == true ? subDark : subLight,
      appBar: AppBar(
        backgroundColor:
            controller.isDarkModeOn.value == true ? subDark : subLight,
        title: Text(
          'Fonts & Locale'.tr,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Languages'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: controller.height * 0.2,
              width: controller.width * 0.9,
              decoration: BoxDecoration(
                color: controller.isDarkModeOn.value == true
                    ? backgroundDark
                    : backgroundLight,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: InkWell(
                      onTap: () {
                        Get.updateLocale(Locale('ko', 'KR'));
                        controller.localeStroage.write('currentLocale', 'ko');
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '한국어',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Korean'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  //수평 라인.
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: controller.isDarkModeOn.value == true
                        ? subDark
                        : subLight,
                  ),
                  Expanded(
                    flex: 5,
                    child: InkWell(
                      onTap: () {
                        Get.updateLocale(Locale('en', 'US'));
                        controller.localeStroage.write('currentLocale', 'en');
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'English',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('English'),
                                ],
                              ),
                            ],
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
      ),
    );
  }
}
