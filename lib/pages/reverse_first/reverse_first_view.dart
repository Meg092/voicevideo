import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'reverse_first_logic.dart';

class ReverseFirstWidget extends GetView<ReverseFirstLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Reverse sound'),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: GetBuilder<ReverseFirstLogic>(
                init: ReverseFirstLogic(),
                builder: (_) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: <Widget>[
                      Image.asset(
                        'assets/icon0.png',
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() {
                        return Text(
                          controller.time.value,
                          style: const TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 38),
                        );
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      <Widget>[
                        Visibility(
                            visible: controller.audioPath != null,
                            child: Image.asset(
                              'assets/icon1.png',
                              fit: BoxFit.cover,
                            ).gestures(onTap: () {
                              controller.toggleDirection();
                            })),
                        Image.asset(
                          'assets/icon${controller.isRecording ? 4 : 3}.png',
                          fit: BoxFit.cover,
                        ).gestures(onTap: () {
                          controller.isRecording
                              ? controller.stopRecording()
                              : controller.startRecording();
                        }),
                        Visibility(
                          visible: controller.audioPath != null,
                          child: Image.asset(
                            'assets/icon2.png',
                            fit: BoxFit.cover,
                          ).gestures(onTap: () {
                            controller.toggleDirection(isReverse: true);
                          }),
                        )
                      ]
                          .toRow(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween)
                          .marginSymmetric(horizontal: 80),
                      const SizedBox(
                        height: 40,
                      ),
                      Visibility(
                          visible: controller.audioPath != null,
                          child: Container(
                            width: 278,
                            height: 50,
                            alignment: Alignment.center,
                            child: const Text(
                              'Save audio file',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                              .decorated(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(25))
                              .gestures(onTap: () {
                            controller.saveAudio();
                          }))
                    ].toColumn(),
                  );
                })),
      ).decorated(
          gradient: const LinearGradient(
              colors: [Color(0xffe6f4ff), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0.7])),
    );
  }
}
