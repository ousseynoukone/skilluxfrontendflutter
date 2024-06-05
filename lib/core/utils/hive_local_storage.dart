import 'package:hive/hive.dart';
import 'package:skilluxfrontendflutter/models/user.dart';

class HiveUserPersistence {
  final  String _userBoxName = 'userBox';

  Future<void> saveUser(User user) async {
    var box = await Hive.openBox(_userBoxName);
    await box.put('user', user);
  }

  Future<User> readUser() async {
    var box = await Hive.openBox(_userBoxName);
    final User user = box.get('user');
    return user;
  }

  Future<void> deleteUser() async {
    var box = await Hive.openBox(_userBoxName);
    await box.delete('user');
  }


}

class HiveSettingsPersistence {
  final String _settingsBoxName = 'settingsBox';

  Future<void> saveSettings(Map<String, dynamic> settings) async {
    var box = await Hive.openBox(_settingsBoxName);
    await box.put('settings', settings);
  }

  Future<Map<String, dynamic>?> readSettings() async {
    var box = await Hive.openBox(_settingsBoxName);
    final Map<String, dynamic>? settings = box.get('settings');
    return settings;
  }

  Future<void> deleteSettings() async {
    var box = await Hive.openBox(_settingsBoxName);
    await box.delete('settings');
  }

}
