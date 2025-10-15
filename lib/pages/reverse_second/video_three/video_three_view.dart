import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../main.dart';
import '../custom_video_player.dart';
import 'video_three_logic.dart';

class VideoThreeWidget extends GetView<VideoThreeLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: AppBar(
        title: Text(controller.title),
        actions: [
          Visibility(
              visible: controller.createdVideoPath != null,
              child: Text(
                'Re-election',
                style:
                TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
              ).marginOnly(right: 20).gestures(onTap: () {
                controller.pickVideo();
              }))
        ],
      ),
      body: GetBuilder<VideoThreeLogic>(builder: (_) {
        return SafeArea(
            bottom: false,
            child: controller.createdVideoPath == null
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
                      videoPath: controller.createdVideoPath!)),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: <Widget>[
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
                    controller.assemblingVideo();
                  }),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom,
                  )
                ].toColumn(),
              ).decorated(color: Colors.white)
            ].toColumn());
      }),
    );
  }
}
