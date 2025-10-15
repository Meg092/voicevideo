import 'package:easy_video_editor/easy_video_editor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reverse_sound/pages/service/utils.dart';

class VideoThreeLogic extends GetxController {

  String title = Get.arguments;

  bool isCreating = false;

  var selectedVideoPaths = <String>[];
  String? createdVideoPath;

  Future<void> pickVideo() async {
    try {
      final List<XFile>? videos = await ImagePicker().pickMultiVideo(
        limit: 5
      );
      if (videos != null && videos.isNotEmpty) {
        if (videos.length < 2) {
          Fluttertoast.showToast(msg: 'Minimum video count reached');
          return;
        }
        if (videos.length >= 5) {
          Fluttertoast.showToast(msg: 'Maximum video count reached');
          return;
        }
        selectedVideoPaths = videos.map((e) => e.path).toList();
        showLoadingDialog(Get.context!);
        await Future.delayed(const Duration(milliseconds: 500));
        try {
          final otherVideoPaths = selectedVideoPaths.sublist(1);
          final editor = VideoEditorBuilder(videoPath: selectedVideoPaths.first)
              .crop(aspectRatio: VideoAspectRatio.ratio16x9)..merge(otherVideoPaths: otherVideoPaths);
          final result = await editor.export();
          if (result != null) {
            createdVideoPath = result;
            update();
          }
        } catch (e) {
          Fluttertoast.showToast(msg: '$e');
        } finally {
          hideLoadingDialog(Get.context!);
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error picking video: $e');
    }
  }

  Future<void> assemblingVideo() async {
    if (createdVideoPath == null) {
      Fluttertoast.showToast(msg: 'Nothing to Create video');
      return;
    }
    if (isCreating) {
      return;
    }
    isCreating = true;
    try {
      final saveResult = await ImageGallerySaver.saveFile(createdVideoPath!);
      if (saveResult != null) {
        Fluttertoast.showToast(msg: 'Video saved successfully');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    } finally {
      isCreating = false;
    }
  }

}
