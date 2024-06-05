class UserRegisterDto {
  final String username;
  final String fullName;
  final String password;
  final String birth;
  final String email;

  UserRegisterDto({
    required this.username,
    required this.fullName,
    required this.password,
    required this.birth,
    required this.email,
  });

  // Method to convert UserRegisterDto object to JSON
  Map<String, dynamic> toBody() {
    return {
      'username': username,
      'fullName': fullName,
      'password': password,
      'birth': birth,
      'email': email,
    };
  }

  // Static method to create UserRegisterDto object from JSON
  static UserRegisterDto fromBody(Map<String, dynamic> json) {
    return UserRegisterDto(
      username: json['username'],
      fullName: json['fullName'],
      password: json['password'],
      birth: json['birth'],
      email: json['email'],
    );
  }
}
