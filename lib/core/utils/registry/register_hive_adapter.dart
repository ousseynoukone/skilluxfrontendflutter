import 'package:hive/hive.dart';
import 'package:skilluxfrontendflutter/models/internal_models/settings/setting.dart';
import 'package:skilluxfrontendflutter/models/internal_models/states/app_config_state.dart';
import 'package:skilluxfrontendflutter/models/internal_models/tokens/token.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';

registerHiveAdapter() {
  Hive.registerAdapter(AppConfigStateAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(SettingAdapter());
  Hive.registerAdapter(TokenAdapter());

}
