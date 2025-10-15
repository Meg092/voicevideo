import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'reverse_second_logic.dart';

class ReverseSecondWidget extends GetView<ReverseSecondLogic> {
  Widget _item(int index) {
    final titles = [
      "Video clipping",
      "Video splicing",
      "Video compression",
      "Video speed"
    ];
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: <Widget>[
        Image.asset(
          'assets/img$index.png',
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(titles[index], textAlign: TextAlign.center),
      ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
    ).decorated(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: 1,
              offset: const Offset(0, 3))
        ]).gestures(onTap: () {
      switch (index) {
        case 0:
          Get.toNamed('/videoOne',arguments: titles[index]);
          break;
        case 1:
          Get.toNamed('/videoThree',arguments: titles[index]);
          break;
        case 2:
          Get.toNamed('/videoFour',arguments: titles[index]);
          break;
        case 3:
          Get.toNamed('/videoSix',arguments: titles[index]);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Video production'),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
              child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: <Widget>[
              Image.asset(
                'assets/icon5.png',
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 20,
              ),
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 103 / 140),
                  itemCount: 4,
                  itemBuilder: (_, index) {
                    return _item(index);
                  })
            ].toColumn(),
          ).marginAll(15)),
        ).decorated(
            gradient: const LinearGradient(
                colors: [Color(0xfffffbe6), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0.7])));
  }
}
