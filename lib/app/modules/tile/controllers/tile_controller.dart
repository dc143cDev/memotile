import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TileController extends GetxController {

  Map<DateTime, List<Event>> events = {
    DateTime.utc(2023,6,11) : [Event('1234')]
  };

  List<Event> getEvents(DateTime day){
    return events[day] ?? [];
  }

  RxString selectedDay = ''.obs;

  var selectedDay2 = DateFormat("yyyyMMdd").format(DateTime.now());


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class Event{
  String title;

  Event(this.title);
}
