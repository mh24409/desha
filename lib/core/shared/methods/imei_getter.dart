import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<String> getIMEI() async {
  var deviceInfo = DeviceInfoPlugin();
  String id = '';
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    id = androidInfo.id;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    id = iosInfo.identifierForVendor! + iosInfo.utsname.machine;
  }
  return id;
}
