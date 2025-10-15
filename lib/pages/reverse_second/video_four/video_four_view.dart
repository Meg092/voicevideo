import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../main.dart';
import '../custom_video_player.dart';
import '../reverse_text_field.dart';
import 'video_four_logic.dart';

class VideoFourWidget extends GetView<VideoFourLogic> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoFourLogic>(builder: (_) {
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
                    'By adjusting the bitrate of the video, the size of the video file can be compressed, thereby reducing the file size. Note: Compression may result in a decrease in video quality.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: ReverseTextField(
                        value: controller.compress,
                        textAlign: TextAlign.center,
                        hintText: 'Enter the compression ratio, ranging from 0 to 1',
                        isNumber: true,
                        onChange: (v) {
                          controller.compress = v;
                        }),
                  ).decorated(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[300]!)),
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
                    controller.compressVideo();
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
