class UserLoginDto {
  final String username;
  final String password;
  final String? email;

  UserLoginDto({required this.username, required this.password, required this.email});

    // Method to convert UserRegisterDto object to JSON
  Map<String, dynamic> toBody() {
    return {
      'username': username,
      'password': password,
      'email': email,
    };
  }

  // Static method to create UserRegisterDto object from JSON
  static UserLoginDto fromBody(Map<String, dynamic> json) {
    return UserLoginDto(
      username: json['username'],
      password: json['password'],
      email: json['email'],
    );
  }
}
