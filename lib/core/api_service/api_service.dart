import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:skilluxfrontendflutter/config/constant/constant.dart';
import 'package:skilluxfrontendflutter/core/api_service/response_data_structure.dart';
import 'package:logger/logger.dart';
import 'dart:convert';

import 'token_manager.dart';

class APIService {
  final Logger _logger = Logger();
  final TokenManager _tokenManager = Get.find();

  Future<ApiResponse> getRequest(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      await _tokenManager.refreshTokenIfNeeded();
      final uri =
          Uri.parse(BASE_URL + path).replace(queryParameters: queryParameters);
      final response = await http.get(
        uri,
        headers: _setHeadersToken(),
      );
      return _handleResponse(response);
    } catch (e) {
      _logger.e(e.toString());
      return const ApiResponse(
          statusCode: 500, body: {'error': 'Internal Server Error'});
    }
  }

  Future<ApiResponse> postRequest(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      await _tokenManager.refreshTokenIfNeeded();
      final uri =
          Uri.parse(BASE_URL + path).replace(queryParameters: queryParameters);
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          ..._setHeadersToken(),
        },
        body: jsonEncode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      _logger.e(e.toString());
      return const ApiResponse(
          statusCode: 500, body: {'error': 'Internal Server Error'});
    }
  }

  Future<ApiResponse> putRequest(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      await _tokenManager.refreshTokenIfNeeded();
      final uri =
          Uri.parse(BASE_URL + path).replace(queryParameters: queryParameters);
      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          ..._setHeadersToken(),
        },
        body: jsonEncode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      _logger.e(e.toString());
      return const ApiResponse(
          statusCode: 500, body: {'error': 'Internal Server Error'});
    }
  }

  Future<ApiResponse> patchRequest(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      await _tokenManager.refreshTokenIfNeeded();
      final uri =
          Uri.parse(BASE_URL + path).replace(queryParameters: queryParameters);
      final response = await http.patch(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          ..._setHeadersToken(),
        },
        body: jsonEncode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      _logger.e(e.toString());
      return const ApiResponse(
          statusCode: 500, body: {'error': 'Internal Server Error'});
    }
  }

  Future<ApiResponse> deleteRequest(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      await _tokenManager.refreshTokenIfNeeded();
      final uri =
          Uri.parse(BASE_URL + path).replace(queryParameters: queryParameters);
      final response = await http.delete(
        uri,
        headers: _setHeadersToken(),
        body: jsonEncode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      _logger.e(e.toString());
      return const ApiResponse(
          statusCode: 500, body: {'error': 'Internal Server Error'});
    }
  }

  Map<String, String> _setHeadersToken() {
    return {'authorization': 'Bearer ${_tokenManager.token}'};
  }

  ApiResponse _handleResponse(http.Response response) {
    try {
      final statusCode = response.statusCode;
      final body = jsonDecode(response.body);

      return ApiResponse(statusCode: statusCode, body: body);
    } catch (e) {
      _logger.e("Error parsing response: $e");
      return const ApiResponse(
          statusCode: 500, body: {'error': 'Internal Server Error'});
    }
  }
}
