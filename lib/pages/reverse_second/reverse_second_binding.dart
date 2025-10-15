import 'package:get/get.dart';

import 'reverse_second_logic.dart';

class ReverseSecondBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReverseSecondLogic());
  }
}