import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reverse_sound/pages/reverse_entrance/reverse_entrance_binding.dart';
import 'package:reverse_sound/pages/reverse_entrance/reverse_entrance_view.dart';
import 'package:reverse_sound/pages/reverse_first/reverse_first_binding.dart';
import 'package:reverse_sound/pages/reverse_first/reverse_first_view.dart';
import 'package:reverse_sound/pages/reverse_second/reverse_second_binding.dart';
import 'package:reverse_sound/pages/reverse_second/reverse_second_view.dart';
import 'package:reverse_sound/pages/reverse_second/video_four/video_four_binding.dart';
import 'package:reverse_sound/pages/reverse_second/video_four/video_four_view.dart';
import 'package:reverse_sound/pages/reverse_second/video_one/video_one_binding.dart';
import 'package:reverse_sound/pages/reverse_second/video_one/video_one_view.dart';
import 'package:reverse_sound/pages/reverse_second/video_second_player.dart';
import 'package:reverse_sound/pages/reverse_second/video_six/video_six_binding.dart';
import 'package:reverse_sound/pages/reverse_second/video_six/video_six_view.dart';
import 'package:reverse_sound/pages/reverse_second/video_three/video_three_binding.dart';
import 'package:reverse_sound/pages/reverse_second/video_three/video_three_view.dart';
import 'package:reverse_sound/pages/reverse_tab/reverse_tab_binding.dart';
import 'package:reverse_sound/pages/reverse_tab/reverse_tab_view.dart';
import 'package:reverse_sound/pages/reverse_third/reverse_third_binding.dart';
import 'package:reverse_sound/pages/reverse_third/reverse_third_view.dart';

Color primaryColor = Colors.black;
Color bgColor = Colors.white;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: VoiceVideo,
      initialRoute: '/',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          foregroundColor: Colors.black,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          selectedItemColor: Colors.black,
          selectedLabelStyle:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          elevation: 0,
          backgroundColor: const Color(0xfff8f8f8),
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> VoiceVideo = [
  GetPage(name: '/', page: () => ReverseEntranceView(), binding: ReverseEntranceBinding()),
  GetPage(name: '/reverseTab', page: () => ReverseTabWidget(), binding: ReverseTabBinding()),
  GetPage(name: '/reverseFirst', page: () => ReverseFirstWidget(), binding: ReverseFirstBinding()),
  GetPage(name: '/reverseSecond', page: () => ReverseSecondWidget(), binding: ReverseSecondBinding()),
  GetPage(name: '/videoPlayer', page: () => VideoSecondPlayer()),
  GetPage(name: '/reverseThird', page: () => ReverseThirdWidget(), binding: ReverseThirdBinding()),
  GetPage(name: '/videoOne', page: () => VideoOneWidget(), binding: VideoOneBinding()),
  GetPage(name: '/videoThree', page: () => VideoThreeWidget(), binding: VideoThreeBinding()),
  GetPage(name: '/videoFour', page: () => VideoFourWidget(), binding: VideoFourBinding()),
  GetPage(name: '/videoSix', page: () => VideoSixWidget(), binding: VideoSixBinding()),
];