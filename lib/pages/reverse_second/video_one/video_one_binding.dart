import 'package:get/get.dart';

import 'video_one_logic.dart';

class VideoOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VideoOneLogic());
  }
}