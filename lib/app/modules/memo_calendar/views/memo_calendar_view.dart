import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../controllers/memo_calendar_controller.dart';

class MemoCalendarView extends GetView<MemoCalendarController> {
  const MemoCalendarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MemoCalendarView'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SfCalendar(),
      ),
    );
  }
}
