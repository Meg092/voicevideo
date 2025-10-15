import 'package:get/get.dart';
import 'package:reverse_sound/pages/reverse_first/reverse_first_logic.dart';
import 'package:reverse_sound/pages/reverse_second/reverse_second_logic.dart';

import '../reverse_third/reverse_third_logic.dart';
import 'reverse_tab_logic.dart';

class ReverseTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReverseTabLogic());
    Get.lazyPut(() => ReverseFirstLogic());
    Get.lazyPut(() => ReverseSecondLogic());
    Get.lazyPut(() => ReverseThirdLogic());
  }
}