import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_sound/pages/reverse_first/reverse_first_view.dart';
import 'package:reverse_sound/pages/reverse_second/reverse_second_view.dart';
import 'package:reverse_sound/pages/reverse_third/reverse_third_view.dart';

import 'reverse_tab_logic.dart';

class ReverseTabWidget extends GetView<ReverseTabLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [
          ReverseFirstWidget(),
          ReverseSecondWidget(),
          ReverseThirdWidget()
        ],
      ),
      bottomNavigationBar: Obx(()=>_navRBars()),
    );
  }

  Widget _navRBars() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/item0Grey.png',width: 22,height: 22,fit: BoxFit.cover,),
          activeIcon:Image.asset('assets/item0Light.png',width: 22,height: 22,fit: BoxFit.cover,),
          label: 'Reverse sound',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/item1Grey.png',width: 22,height: 22,fit: BoxFit.cover,),
          activeIcon:Image.asset('assets/item1Light.png',width: 22,height: 22,fit: BoxFit.cover,),
          label: 'Video production',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/item2Grey.png',width: 22,height: 22,fit: BoxFit.cover,),
          activeIcon:Image.asset('assets/item2Light.png',width: 22,height: 22,fit: BoxFit.cover,),
          label: 'Setting',
        ),
      ],
      currentIndex: controller.currentIndex.value,
      onTap: (index) {
        controller.currentIndex.value = index;
        controller.pageController.jumpToPage(index);
      },
    );
  }
}
