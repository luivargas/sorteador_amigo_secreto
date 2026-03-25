import 'package:shared_preferences/shared_preferences.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/device/device_info.dart';

class AuthDB {
  static const _keyEmail = 'auth_email';
  static const _keyToken = 'auth_token';
  static const _keyDeviceName = 'device_name';
  static const _keyDevicePlatform = 'device_platform';
  static const _keyDeviceModel = 'device_model';
  static const _keyDeviceId = 'device_id';

  final SharedPreferencesWithCache prefs;

  AuthDB(this.prefs);

  // ── Email ─────────────────────────────────────────────────────────────────

  String? get email => prefs.getString(_keyEmail);

  Future<void> saveEmail(String value) => prefs.setString(_keyEmail, value);

  // ── Token ─────────────────────────────────────────────────────────────────

  String? get token => prefs.getString(_keyToken);

  Future<void> saveToken(String value) => prefs.setString(_keyToken, value);

  // ── Device ────────────────────────────────────────────────────────────────

  DeviceData? get device {
    final name = prefs.getString(_keyDeviceName);
    final platform = prefs.getString(_keyDevicePlatform);
    final model = prefs.getString(_keyDeviceModel);
    if (name == null || platform == null || model == null) return null;
    return DeviceData(
      name: name,
      platform: platform,
      model: model,
      deviceId: prefs.getString(_keyDeviceId),
    );
  }

  Future<void> saveDevice(DeviceData data) async {
    await prefs.setString(_keyDeviceName, data.name);
    await prefs.setString(_keyDevicePlatform, data.platform);
    await prefs.setString(_keyDeviceModel, data.model);
    if (data.deviceId != null) {
      await prefs.setString(_keyDeviceId, data.deviceId!);
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  bool get isAuthenticated => email != null && token != null;

  Future<void> clear() async {
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyToken);
    await prefs.remove(_keyDeviceName);
    await prefs.remove(_keyDevicePlatform);
    await prefs.remove(_keyDeviceModel);
    await prefs.remove(_keyDeviceId);
  }
}
