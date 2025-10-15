
import 'package:easy_video_editor/easy_video_editor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';


class VideoFourLogic extends GetxController {

  String title = Get.arguments;

  String? selectedVideoPath;

  bool isCreating = false;

  String compress = '';

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

  Future<void> compressVideo() async {
    if (selectedVideoPath == null) {
      Fluttertoast.showToast(msg: 'Please select a video');
      return;
    }
    if (compress.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter a compression value');
      return;
    }
    double compressNumber = double.parse(compress);
    if (compressNumber < 0 || compressNumber > 1) {
      Fluttertoast.showToast(msg: 'Invalid compression value');
      return;
    }
    if (isCreating) {
      return;
    }
    isCreating = true;
    try {

      var resolution = VideoResolution.p360;
      if (compressNumber > 0 && compressNumber < 0.2) {
        resolution = VideoResolution.p360;
      } else if (compressNumber >= 0.2 && compressNumber < 0.4) {
        resolution = VideoResolution.p480;
      } else if (compressNumber >= 0.4 && compressNumber < 0.6) {
        resolution = VideoResolution.p720;
      } else if (compressNumber >= 0.6 && compressNumber < 0.8) {
        resolution = VideoResolution.p1080;
      } else if (compressNumber >= 0.8 && compressNumber <= 1) {
        resolution = VideoResolution.p2160;
      }
      final editor = VideoEditorBuilder(videoPath: selectedVideoPath!)
          .crop(aspectRatio: VideoAspectRatio.ratio16x9)..compress(resolution: resolution);
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
    }
  }

}
