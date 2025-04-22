import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveUserData(String deviceId, List<String> moods) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('device_id', deviceId);
    await prefs.setStringList('selected_moods', moods);
  }

  static Future<String?> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('device_id');
  }

  static Future<List<String>?> getSelectedMoods() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('selected_moods');
  }

    Future<List<String>> _loadSelectedMoods() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('selected_moods') ?? [];
  }
  
}
