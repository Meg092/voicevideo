import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  static Future<bool> getAlbum() async {
    final status = await Permission.photos.request();
    if (status.isGranted) {
      return true;
    } else {
      showPermissionDialog(
        "Permission Denied",
        "Please grant album permission to use this feature.",
      );
      return false;
    }
  }

  static Future<bool> getMicrophoneStoragePermission() async {
    final status = await [
      Permission.microphone,
      Permission.storage,
    ].request();
    if (status[Permission.microphone]?.isGranted == true  && status[Permission.storage]?.isGranted == true) {
      return true;
    } else {
      showPermissionDialog(
        "Permission Denied",
        "Please grant microphone and storage permission to use this feature.",
      );
      return false;
    }
  }

  static Future<bool> getStoragePermission() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    } else {
      showPermissionDialog(
        "Permission Denied",
        "Please grant storage permission to use this feature.",
      );
      return false;
    }
  }

  static showPermissionDialog(String title, String content) {
    Get.dialog(AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          child: const Text('Open Settings'),
          onPressed: () {
            openAppSettings();
          },
        ),
      ],
    ));
  }
}
