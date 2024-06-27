import 'package:hive/hive.dart';

part 'token.g.dart';

@HiveType(typeId: 4)
class Token {
  @HiveField(0)
  String accessToken;

  @HiveField(1)
  String refreshToken;

  @HiveField(2)
  String accessTokenExpire;

  @HiveField(3)
  String refreshTokenExpire;

  Token({
    required this.accessToken,
    required this.refreshToken,
    required this.accessTokenExpire,
    required this.refreshTokenExpire,
  });

  factory Token.fromBody(Map<String, dynamic> body) {
    return Token(
      accessToken: body["access_token"],
      refreshToken: body["refresh_token"],
      refreshTokenExpire: body["refresh_token_expire"],
      accessTokenExpire: body["access_token_expire"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "refresh_token": refreshToken,
    };
  }
}
