import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skilluxfrontendflutter/config/constant/constant.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';
import 'package:skilluxfrontendflutter/core/utils/response_data_structure.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';

class APIService {
  final Logger _logger = Logger();
  final HiveUserPersistence _hiveUserPersistence = HiveUserPersistence();
  String? token = "";

  Future<void> addTokenHeader() async {
    User _user = await _hiveUserPersistence.readUser();
    token = _user.token ?? "";
  }


  APIService() {
    addTokenHeader();
  }

  Future<ApiResponse> getRequest(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = Uri.parse(BASE_URL + path);
      final response = await http.get(
        uri.replace(queryParameters: queryParameters),
        headers: {'authorization': 'Bearer $token'},
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
      final uri = Uri.parse(BASE_URL + path);
      final response = await http.post(
        uri.replace(queryParameters: queryParameters),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      _logger.e(e.toString());
      return ApiResponse(
          statusCode: 500, body: {'error': 'Internal Server Error'});
    }
  }

  Future<ApiResponse> putRequest(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = Uri.parse(BASE_URL + path);
      final response = await http.put(
        uri.replace(queryParameters: queryParameters),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      _logger.e(e.toString());
      return ApiResponse(
          statusCode: 500, body: {'error': 'Internal Server Error'});
    }
  }

  Future<ApiResponse> patchRequest(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = Uri.parse(BASE_URL + path);
      final response = await http.patch(
        uri.replace(queryParameters: queryParameters),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      _logger.e(e.toString());
      return ApiResponse(
          statusCode: 500, body: {'error': 'Internal Server Error'});
    }
  }

  Future<ApiResponse> deleteRequest(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = Uri.parse(BASE_URL + path);
      final response = await http.delete(
        uri.replace(queryParameters: queryParameters),
        headers: {'authorization': 'Bearer $token'},
      );
      return _handleResponse(response);
    } catch (e) {
      _logger.e(e.toString());
      return ApiResponse(
          statusCode: 500, body: {'error': 'Internal Server Error'});
    }
  }

  ApiResponse _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final body = jsonDecode(response.body);
    return ApiResponse(statusCode: statusCode ?? 0, body: body);
  }
}
