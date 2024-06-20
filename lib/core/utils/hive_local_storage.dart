import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:skilluxfrontendflutter/models/states/app_config_state.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:logger/logger.dart';

class HiveUserPersistence {
  final String _userBox = 'userBox';
  final Logger _logger = Logger();

  Future<void> saveUser(User user) async {
    var box = await Hive.openBox(_userBox);
    await box.put('user', user);
  }

  Future<User?> readUser() async {
    var box = await Hive.openBox(_userBox);
    final User? user = box.get('user');
    return user;
  }

  Future<void> deleteUser() async {
    var box = await Hive.openBox(_userBox);
    await box.delete('user');
  }
}


class HiveAppStatePersistence {
  final String _stateBox = 'stateBox';

  Future<void> saveState(AppConfigState state) async {
    var box = await Hive.openBox(_stateBox);
    await box.put('appConfigState', state);
  }

  Future<AppConfigState> readState() async {
    var box = await Hive.openBox(_stateBox);
    final AppConfigState state = box.get('appConfigState') ?? AppConfigState();
    return state;
  }

  Future<void> deleteState() async {
    var box = await Hive.openBox(_stateBox);
    await box.delete('appConfigState');
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
