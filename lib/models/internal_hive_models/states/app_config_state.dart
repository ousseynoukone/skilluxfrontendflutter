import 'package:hive/hive.dart';

part 'app_config_state.g.dart';

@HiveType(typeId: 1)
class AppConfigState {
  @HiveField(0)
  bool? isUserLogged;
  @HiveField(1)
  bool? isUserTagsPreferenceSaved;

  @HiveField(2)
  bool? isAppFirstLaunch;

  AppConfigState({
    this.isAppFirstLaunch = true,
    this.isUserLogged = false,
    this.isUserTagsPreferenceSaved = false,
  });
}
