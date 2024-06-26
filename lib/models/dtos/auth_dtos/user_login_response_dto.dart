import 'package:skilluxfrontendflutter/models/user/user.dart';

class UserLoginResponseDto {
  String accessToken;
  String refreshToken;
  String accessTokenExpire;
  User user;
  

  UserLoginResponseDto(
      {required this.refreshToken, required this.accessToken, required this.accessTokenExpire, required this.user});

  // Static method to create UserLoginResponseDto object from JSON
  static UserLoginResponseDto fromBody(Map<String, dynamic> json) {
    User user = User.fromBody(json['user']);
    return UserLoginResponseDto(
        accessToken: json['access_token'], accessTokenExpire: json['access_token_expire'], user: user, refreshToken: json['refresh_token']);
  }
}
