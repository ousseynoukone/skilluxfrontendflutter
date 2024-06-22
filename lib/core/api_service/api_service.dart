import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:skilluxfrontendflutter/config/constant/constant.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';
import 'package:skilluxfrontendflutter/core/utils/response_data_structure.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';

class APIService {
  final Logger _logger = Logger();
  final HiveUserPersistence _hiveUserPersistence = Get.find();
  String? token = "";

  Future<void> _initializeToken() async {
    try {
      var user = await _hiveUserPersistence.readUser();
      token = user?.token ?? "";
    } catch (e) {
      _logger.e("Error initializing token: $e");
      token = "";
    }
  }

  Map<String, String> _setHeadersToken() {
    return {'authorization': 'Bearer $token'};
  }

  Future<ApiResponse> getRequest(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    await _ensureTokenIsReady();
    try {
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
    await _ensureTokenIsReady();
    try {
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
    await _ensureTokenIsReady();
    try {
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
    await _ensureTokenIsReady();
    try {
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
    await _ensureTokenIsReady();
    try {
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

  Future<void> _ensureTokenIsReady() async {
    await _initializeToken();
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
