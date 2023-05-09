import 'package:get/get.dart';

import '../controllers/tile_controller.dart';

class TileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TileController>(
      () => TileController(),
    );
  }
}
