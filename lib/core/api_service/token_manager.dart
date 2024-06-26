import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/config/constant/constant.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';
import 'package:skilluxfrontendflutter/models/internal_models/tokens/token.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TokenManager extends GetxController {
  final Logger _logger = Logger();
  final HiveTokenPersistence _hiveTokenPersistence = Get.find();
  String token = "";

  @override
  Future<void> onInit() async {
    await initializeToken();
    super.onInit();
  }

  Future<void> initializeToken() async {
    try {
      Token? token = await _hiveTokenPersistence.readToken();
      this.token = token?.accessToken ?? "";
    } catch (e) {
      _logger.e("Error initializing token: $e");
      token = "";
    }
  }

  Future<void> refreshTokenIfNeeded() async {
    Token? token = await _hiveTokenPersistence.readToken();
    if (token != null) {
      final expirationDate = DateTime.parse(token.accessTokenExpire);

      if (DateTime.now().isAfter(expirationDate)) {
        await _refreshToken(token);
        await initializeToken();
      }
    }
  }

  Future<void> _refreshToken(Token token) async {
    _logger.d("Refresh Token ran ! ");
    try {
      final response = await http.post(
        Uri.parse('${BASE_URL}auth/refresh-token'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(token.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        Token newToken = Token.fromBody(data);

        // Update user with new token and expiration date
        await _hiveTokenPersistence.saveToken(newToken);
      } else {
        throw Exception('Failed to refresh token');
      }
    } catch (e) {
      _logger.e(e.toString());
    }
  }
}
