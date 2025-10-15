import 'package:get/get.dart';

import 'reverse_third_logic.dart';

class ReverseThirdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReverseThirdLogic());
  }
}