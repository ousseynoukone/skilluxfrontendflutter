import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:skilluxfrontendflutter/models/internal_models/settings/setting.dart';
import 'package:skilluxfrontendflutter/models/internal_models/states/app_config_state.dart';
import 'package:skilluxfrontendflutter/models/internal_models/tokens/token.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:logger/logger.dart';

class HiveUserPersistence extends GetxController {
  final String _userBox = 'userBox';
  final Logger _logger = Logger();
  var box ;  

    @override
  Future<void> onInit() async {
    box = await Hive.openBox(_userBox);
    super.onInit();
  }

  Future<void> saveUser(User user) async {
    await box.put('user', user);
  }

  Future<User?> readUser() async {
    final User? user = box.get('user');
    return user;
  }


  Future<void> deleteUser() async {
    await box.delete('user');
  }
}



class HiveTokenPersistence extends GetxController {
  final String _tokenBox = 'tokenBox';
  final Logger _logger = Logger();
  var box ;  

    @override
  Future<void> onInit() async {
    box = await Hive.openBox(_tokenBox);
    super.onInit();
  }

  Future<void> saveToken(Token token) async {
    await box.put('token', token);
  }

  Future<Token?> readToken() async {
    final Token? token = box.get('token');
    return token;
  }



  Future<void> deleteToken() async {
    await box.delete('token');
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

  Future<void> saveSettings(Setting settings) async {
    var box = await Hive.openBox(_settingsBoxName);
    await box.put('settings', settings);
  }

  Future<Setting?> readSettings() async {
    var box = await Hive.openBox(_settingsBoxName);
    final Setting? settings = box.get('settings');
    return settings;
  }

  Future<void> deleteSettings() async {
    var box = await Hive.openBox(_settingsBoxName);
    await box.delete('settings');
  }
}
