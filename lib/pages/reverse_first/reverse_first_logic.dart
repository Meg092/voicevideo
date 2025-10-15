import 'dart:async';
import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:file_saver/file_saver.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:reverse_sound/pages/service/permission_manager.dart';

class ReverseFirstLogic extends GetxController {
  final AudioRecorder audioRecorder = AudioRecorder();
  bool isRecording = false;
  bool hasRecorded = false;
  String? audioPath;

  final AudioPlayer audioPlayer = AudioPlayer();
  double _playbackSpeed = 1.0;

  late AudioSession audioSession;

  Timer? _timer;
  int timeInSeconds = 0;
  RxString time = '00:00:00'.obs;

  Future<void> _initAudioSession() async {
    audioSession = await AudioSession.instance;
    await audioSession.configure(const AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.defaultMode,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
  }


  void _setupAudioPlayerListeners() {
    audioPlayer.playbackEventStream.listen((event) {

    });
  }

  Future<void> startRecording() async {
    if (!await PermissionManager.getMicrophoneStoragePermission()) {
      return;
    }
    audioPath = null;
    await audioPlayer.stop();
    startTimer();
    update();
    try {
      if (await audioRecorder.hasPermission()) {
        final directory = await getTemporaryDirectory();
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final filePath = '${directory.path}/recording_$timestamp.m4a';

        await audioRecorder.start(
          const RecordConfig(
            encoder: AudioEncoder.aacLc,
            bitRate: 128000,
            sampleRate: 44100,
          ),
          path: filePath,
        );

        isRecording = true;
        hasRecorded = false;

        update();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Recording failed to start:$e');
    }
  }

  Future<void> stopRecording() async {
    stopTimer();
    try {
      final path = await audioRecorder.stop();
      isRecording = false;
      hasRecorded = true;
      audioPath = path;
      update();

      if (audioPath != null) {
        await audioPlayer.setAudioSource(
          AudioSource.uri(Uri.file(audioPath!)),
        );
      }
    } catch (e) {
      print('Recording stop failed:$e');
    }
  }


  Future<void> toggleDirection({bool isReverse = false,int index = 0}) async {
    await audioPlayer.stop();
    _playbackSpeed = isReverse ? -1.0 : 1.0;
    await audioPlayer.setSpeed(_playbackSpeed);
    await audioPlayer.play();

  }

  void saveAudio() async {
    if (audioPath != null) {
      final file = File(audioPath!);
      final bytes = await file.readAsBytes();
      await FileSaver.instance.saveAs(
          name: 'audio_${DateTime.now().millisecondsSinceEpoch}.m4a',
          bytes: bytes,
          fileExtension: 'm4a',
          includeExtension: false,
          mimeType: MimeType.aac);
    }
  }

  startTimer() {
    timeInSeconds = 0;
    time.value = '00:00:00';
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeInSeconds++;
      time.value = formatTime(Duration(seconds: timeInSeconds));
    });
  }

  stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours.remainder(60));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _initAudioSession();
    _setupAudioPlayerListeners();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    audioRecorder.dispose();
    audioPlayer.dispose();
    stopTimer();
    super.onClose();
  }
}
