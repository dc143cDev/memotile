import 'package:get/get.dart';

import '../controllers/memo_calendar_controller.dart';

class MemoCalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MemoCalendarController>(
      () => MemoCalendarController(),
    );
  }
}
