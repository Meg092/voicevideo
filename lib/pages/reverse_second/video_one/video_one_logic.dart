
import 'package:easy_video_editor/easy_video_editor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reverse_sound/pages/reverse_second/reverse_text_field.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:video_compress/video_compress.dart';

class VideoOneLogic extends GetxController {
  String title = Get.arguments;

  String? selectedVideoPath;

  int startTimeMS = 100;
  int endTimeMS = 200;
  int durationMS = 0;
  bool isCreating = false;

  Future<void> pickVideo() async {
    try {
      startTimeMS = 100;
      endTimeMS = 200;
      durationMS = 0;
      selectedVideoPath = null;
      update();
      final XFile? video =
          await ImagePicker().pickVideo(source: ImageSource.gallery);
      if (video != null) {
        selectedVideoPath = video.path;
        final MediaInfo mediaInfo =
            await VideoCompress.getMediaInfo(video.path);
        durationMS = (mediaInfo.duration ?? 0).toInt();
        update();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error picking video: $e');
    }
  }

  editStartEndMS({bool isStart = true}) async {
    String value = '';
    Get.dialog(AlertDialog(
      title: Text(isStart ? 'Start location' : 'End location',textAlign: TextAlign.center,),
      content: Container(
        width: 300,
        height: 50,
        child: ReverseTextField(
            value: value,
            isInteger: true,
            onChange: (v) {
              value = v;
            }),
      ).decorated(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[300]!)),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () {
            if (value.isEmpty) {
              Fluttertoast.showToast(msg: 'Please enter a value');
            } else {
              if (isStart) {
                startTimeMS = int.parse(value);
              } else {
                endTimeMS = int.parse(value);
              }
              update();
            }
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  Future<void> cropVideo() async {
    if (selectedVideoPath == null) {
      Fluttertoast.showToast(msg: 'Please select a video');
      return;
    }
    if (startTimeMS + endTimeMS >= durationMS) {
      Fluttertoast.showToast(msg: 'Please select a valid time range');
      return;
    }
    if (startTimeMS == 0 && endTimeMS == 0) {
      Fluttertoast.showToast(msg: 'Please select a time range');
      return;
    }
    if (isCreating) {
      return;
    }
    isCreating = true;

    try {
      final editor = VideoEditorBuilder(videoPath: selectedVideoPath!).trim(startTimeMs: startTimeMS, endTimeMs: endTimeMS);
      final result = await editor.export();
      if (result != null) {
        final saveResult = await ImageGallerySaver.saveFile(result);
        if (saveResult != null) {
          Fluttertoast.showToast(msg: 'Video saved successfully');
        }
      } else {
        Fluttertoast.showToast(msg: 'Error exporting video, please select a different time range');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    } finally {
      isCreating = false;
    }
  }
}
