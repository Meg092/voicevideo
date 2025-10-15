import 'package:get/get.dart';

import 'video_four_logic.dart';

class VideoFourBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VideoFourLogic());
  }
}