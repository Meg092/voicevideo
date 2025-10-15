import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../main.dart';
import '../custom_video_player.dart';
import 'video_six_logic.dart';

class VideoSixWidget extends GetView<VideoSixLogic> {
  Widget _item(int index) {
    final titles = ['-x2', '-x1', 'x2', 'x4', 'x8'];
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:
            controller.speedIndex.value == index ? Colors.red : Colors
                .grey[300]),
        alignment: Alignment.center,
        child: Text(
          titles[index],
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: controller.speedIndex.value == index
                  ? Colors.white
                  : const Color(0xff727272)),
        ),
      ).gestures(onTap: () {
        controller.speedIndex.value = index;
        switch (index) {
          case 0:
            controller.speed = -2;
            break;
          case 1:
            controller.speed = -1;
            break;
          case 2:
            controller.speed = 2;
            break;
          case 3:
            controller.speed = 4;
            break;
          case 4:
            controller.speed = 8;
            break;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoSixLogic>(builder: (_) {
      return Scaffold(
        backgroundColor: const Color(0xfff7f7f7),
        appBar: AppBar(
          title: Text(controller.title),
          actions: [
            Visibility(
                visible: controller.selectedVideoPath != null,
                child: Text(
                  'Re-election',
                  style:
                  TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                ).marginOnly(right: 20).gestures(onTap: () {
                  controller.pickVideo();
                }))
          ],
        ),
        body: SafeArea(
            bottom: false,
            child: controller.selectedVideoPath == null
                ? Center(
              child: Container(
                width: 260,
                height: 40,
                alignment: Alignment.center,
                child: const Text(
                  'Pick a video',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              )
                  .decorated(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(20))
                  .gestures(onTap: () {
                controller.pickVideo();
              }),
            )
                : <Widget>[
              Expanded(
                  child: CustomVideoPlayer(
                      videoPath: controller.selectedVideoPath!)),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: <Widget>[
                  const Text(
                    'Speed adjustment setting',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 54,
                    child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, mainAxisSpacing: 10),
                        itemCount: 5,
                        itemBuilder: (_, index) {
                          return _item(index);
                        }),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      'Render Export',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                      .decorated(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25))
                      .gestures(onTap: () {
                    controller.speedVideo();
                  }),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .padding
                        .bottom,
                  )
                ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
              ).decorated(color: Colors.white)
            ].toColumn()),
      );
    });
  }
}
