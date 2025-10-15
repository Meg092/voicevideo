import 'package:get/get.dart';

import 'reverse_first_logic.dart';

class ReverseFirstBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReverseFirstLogic());
  }
}