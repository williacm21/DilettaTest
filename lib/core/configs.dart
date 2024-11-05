import 'dart:convert';

import 'package:app_set_id/app_set_id.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Configs {
  static final Configs _instance = Configs.internal();

  factory Configs() => _instance;

  Configs.internal();

  static String appVersion = '';
  static String deviceID = '';

  Future<void> init() async {
    final packageInfo = await PackageInfo.fromPlatform();
    appVersion = '${packageInfo.version}+${packageInfo.buildNumber}';
    deviceID = await _getId();
  }

  static String _decode(String input) {
    final base64Decode = base64.decode(input);
    final utf8Decode = utf8.decode(base64Decode);

    return utf8Decode;
  }

  Future<String> _getId() async {
    String? id = await AppSetId().getIdentifier();
    return id ?? 'unknow';
  }
}
