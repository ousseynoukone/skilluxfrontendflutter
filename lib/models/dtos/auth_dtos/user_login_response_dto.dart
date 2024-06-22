import 'package:skilluxfrontendflutter/models/user/user.dart';

class UserLoginResponseDto {
  String token;
  String expire;
  User user;

  UserLoginResponseDto(
      {required this.token, required this.expire, required this.user});

  // Static method to create UserLoginResponseDto object from JSON
  static UserLoginResponseDto fromBody(Map<String, dynamic> json) {
    User user = User.fromBody(json['user']);
    return UserLoginResponseDto(
        token: json['token'], expire: json['expire'], user: user);
  }
}
