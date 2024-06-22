class UserLoginResponseDto {
  final int id;
  String token;
  String expire;

  UserLoginResponseDto({
    required this.id,
    required this.token,
    required this.expire,
  });

  // Static method to create UserLoginResponseDto object from JSON
  static UserLoginResponseDto fromBody(Map<String, dynamic> json) {
    return UserLoginResponseDto(
      id: json['id'],
      token: json['token'],
      expire: json['expire'],
    );
  }
}
