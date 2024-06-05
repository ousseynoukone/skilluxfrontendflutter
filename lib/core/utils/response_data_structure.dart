class ApiResponse {
  final int statusCode;
  final String? message;
  final dynamic body;

  const ApiResponse({
    required this.statusCode,
    this.message,
    this.body,
  });

  // Factory method to create an ApiResponse from JSON
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      body: json['body'],
    );
  }

  // Convert ApiResponse to JSON
  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'body': body,
    };
  }
}
