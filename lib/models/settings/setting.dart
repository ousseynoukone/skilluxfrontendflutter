import 'package:hive/hive.dart';

part 'setting.g.dart';

@HiveType(typeId: 3)
class Setting {
  @HiveField(0)
  bool? themeMode;

  @HiveField(1)
  String? lang;

  Setting({
    this.themeMode,
    this.lang,
  });
}
