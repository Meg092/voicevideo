import 'package:get/get.dart';

import 'video_three_logic.dart';

class VideoThreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VideoThreeLogic());
  }
}