import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_sound/pages/reverse_second/custom_video_player.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:video_player/video_player.dart';

import '../../../main.dart';
import 'video_one_logic.dart';

class VideoOneWidget extends GetView<VideoOneLogic> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoOneLogic>(builder: (_) {
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
                  <Widget>[
                    const Text(
                      'Total duration',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '${controller.durationMS}ms',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ].toRow(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween),
                  Divider(
                    height: 25,
                    color: Colors.grey[300],
                  ),
                  <Widget>[
                    const Text(
                      'Start location',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '${controller.startTimeMS}ms',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: const Text(
                        'Mark position',
                        style:
                        TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    )
                        .decorated(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(14))
                        .gestures(onTap: () {
                      controller.editStartEndMS();
                    })
                  ].toRow(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween),
                  const SizedBox(
                    height: 15,
                  ),
                  <Widget>[
                    const Text(
                      'End location',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '${controller.endTimeMS}ms',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: const Text(
                        'Mark position',
                        style:
                        TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    )
                        .decorated(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(14))
                        .gestures(onTap: () {
                      controller.editStartEndMS(isStart: false);
                    })
                  ].toRow(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween),
                  Divider(
                    height: 50,
                    color: Colors.grey[300],
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
                    controller.cropVideo();
                  }),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .padding
                        .bottom,
                  )
                ].toColumn(),
              ).decorated(color: Colors.white)
            ].toColumn()),
      );
    });
  }
}
