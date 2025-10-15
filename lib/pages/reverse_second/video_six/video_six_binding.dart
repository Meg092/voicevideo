import 'package:get/get.dart';

import 'video_six_logic.dart';

class VideoSixBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VideoSixLogic());
  }
}