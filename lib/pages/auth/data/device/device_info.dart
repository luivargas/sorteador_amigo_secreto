import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class DeviceData {
  final String name;
  final String platform;
  final String model;
  final String? deviceId;

  DeviceData({
    required this.name,
    required this.platform,
    required this.model,
    this.deviceId,
  });

  Map<String, String> toMap() => {
        'name': name,
        'platform': platform,
        'model': model,
      };

  /// Formato enviado para a API no campo "device"
  String toDeviceString() =>
      '$platform | $model | $name${deviceId != null ? ' | $deviceId' : ''}';
}

class DeviceInfo {
  static final _plugin = DeviceInfoPlugin();

  static Future<DeviceData> collect() async {
    try {
      return switch (defaultTargetPlatform) {
        TargetPlatform.android => _fromAndroid(await _plugin.androidInfo),
        TargetPlatform.iOS => _fromIos(await _plugin.iosInfo),
        _ => DeviceData(
            name: 'Unknown',
            platform: defaultTargetPlatform.name,
            model: 'Unknown',
          ),
      };
    } on PlatformException {
      return DeviceData(
        name: 'Unknown',
        platform: defaultTargetPlatform.name,
        model: 'Unknown',
      );
    }
  }

  static DeviceData _fromAndroid(AndroidDeviceInfo info) => DeviceData(
        name: info.device,
        platform: 'Android ${info.version.release}',
        model: info.model,
        deviceId: info.id,
      );

  static DeviceData _fromIos(IosDeviceInfo info) => DeviceData(
        name: info.name,
        platform: '${info.systemName} ${info.systemVersion}',
        model: info.model,
        deviceId: info.identifierForVendor,
      );
}
