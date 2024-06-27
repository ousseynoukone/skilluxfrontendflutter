import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/config/constant/constant.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';
import 'package:skilluxfrontendflutter/models/internal_models/tokens/token.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:skilluxfrontendflutter/services/auh_services/helpers/helpers.dart';

class TokenManager extends GetxController {
  final Logger _logger = Logger();
  final HiveTokenPersistence _hiveTokenPersistence = Get.find();
  bool abortRequest = false;
  Token token = Token(
      accessToken: "",
      accessTokenExpire: "",
      refreshToken: "",
      refreshTokenExpire: "");
  final text = Get.context?.localizations;

  Future<void> initializeToken() async {
    abortRequest = false;
    try {
      if (token.accessToken.isEmpty) {
        Token? token = await _hiveTokenPersistence.readToken();
        this.token.accessToken = token?.accessToken ?? "";
        this.token.refreshToken = token?.refreshToken ?? "";
        this.token.accessTokenExpire = token?.accessTokenExpire ?? "";
        this.token.refreshTokenExpire = token?.refreshTokenExpire ?? "";
      }
    } catch (e) {
      _logger.e("Error initializing token: $e");
    }
  }

  reinitializeToken() {
    token = Token(
        accessToken: "",
        accessTokenExpire: "",
        refreshToken: "",
        refreshTokenExpire: "");
  }

  Future<void> refreshTokenIfNeeded() async {
    await initializeToken();
    if (token.accessToken.isNotEmpty) {
      final accessTokenExpirationDate = DateTime.parse(token.accessTokenExpire);
      final refreshTokenExpirationDate =
          DateTime.parse(token.refreshTokenExpire);

      if (DateTime.now().isAfter(refreshTokenExpirationDate)) {
        abortRequest = true;

        await localLogout();
      } else {
        if (DateTime.now().isAfter(accessTokenExpirationDate)) {
          await _refreshToken(token);
        }
      }
    }
  }

  Future<void> _refreshToken(Token token) async {
    _logger.w("Refresh Token ran ! ");
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

        this.token = newToken;
      } else {
        abortRequest = true;
        await localLogout();
        Get.snackbar(text!.alert, text!.reconnectMessage,
            snackPosition: SnackPosition.BOTTOM);
        throw Exception('Failed to refresh token');
      }
    } catch (e) {
      _logger.e(e.toString());
      abortRequest = true;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
