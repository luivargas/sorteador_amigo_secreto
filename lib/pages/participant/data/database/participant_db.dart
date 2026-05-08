import 'package:shared_preferences/shared_preferences.dart';

class ParticipantDB {
  static const _keyDismissedWhatsappAlert = 'dismissed_whatsapp_alert';

  final SharedPreferencesWithCache prefs;

  ParticipantDB(this.prefs);

  bool isAlertDismissed(String groupCode) {
    final dismissed = prefs.getStringList(_keyDismissedWhatsappAlert) ?? [];
    return dismissed.contains(groupCode);
  }

  Future<void> dismissAlert(String groupCode) async {
    final dismissed = prefs.getStringList(_keyDismissedWhatsappAlert) ?? [];
    if (!dismissed.contains(groupCode)) {
      dismissed.add(groupCode);
      await prefs.setStringList(_keyDismissedWhatsappAlert, dismissed);
    }
  }
}
