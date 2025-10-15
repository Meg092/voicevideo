import 'package:get/get.dart';

import 'reverse_entrance_logic.dart';

class ReverseEntranceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      ReverseEntranceLogic(),
      permanent: true,
    );
  }
}
