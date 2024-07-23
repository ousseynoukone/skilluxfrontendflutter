import 'package:hive/hive.dart';
import 'package:skilluxfrontendflutter/models/internal_hive_models/post/binary_image.dart';
import 'package:skilluxfrontendflutter/models/internal_hive_models/settings/setting.dart';
import 'package:skilluxfrontendflutter/models/internal_hive_models/states/app_config_state.dart';
import 'package:skilluxfrontendflutter/models/internal_hive_models/tokens/token.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';

registerHiveAdapter() {
  Hive.registerAdapter(AppConfigStateAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(SettingAdapter());
  Hive.registerAdapter(TokenAdapter());
  Hive.registerAdapter(BinaryImageAdapter());
  Hive.registerAdapter(PostAdapter());

}
