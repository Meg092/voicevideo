import 'package:easy_video_editor/easy_video_editor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

import '../../service/utils.dart';

class VideoSixLogic extends GetxController {

  String title = Get.arguments;

  String? selectedVideoPath;

  int speed = 2;
  RxInt speedIndex = 2.obs;

  bool isCreating = false;

  Future<void> pickVideo() async {
    try {
      selectedVideoPath = null;
      update();
      final XFile? video =
      await ImagePicker().pickVideo(source: ImageSource.gallery);
      if (video != null) {
        selectedVideoPath = video.path;
        update();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error picking video: $e');
    }
  }

  Future<void> speedVideo() async {
    if (selectedVideoPath == null) {
      Fluttertoast.showToast(msg: 'Nothing to Create video');
      return;
    }
    if (isCreating) {
      return;
    }
    isCreating = true;
    showLoadingDialog(Get.context!);
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final editor = VideoEditorBuilder(videoPath: selectedVideoPath!)
          .crop(aspectRatio: VideoAspectRatio.ratio16x9)..speed(speed: speed.toDouble());
      final result = await editor.export();
      if (result != null) {
        final saveResult = await ImageGallerySaver.saveFile(result);
        if (saveResult != null) {
          Fluttertoast.showToast(msg: 'Video saved successfully');
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    } finally {
      isCreating = false;
      hideLoadingDialog(Get.context!);
    }
  }

}
