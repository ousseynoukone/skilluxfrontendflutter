import 'package:dio/dio.dart';
import 'package:skilluxfrontendflutter/config/constant/constant.dart';
import 'package:skilluxfrontendflutter/core/utils/response_data_structure.dart';

class APIService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: BASE_URL,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  final String? token = "";


  Future<ApiResponse> getRequest(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,}) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options?.copyWith(
          headers: {'HttpHeaders.authorizationHeader': "Bearer $token"},
        ),
      );
      return ApiResponse(
        statusCode: response.statusCode ?? 0,
        body: response.data,
      );
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse> postRequest(String path,{ data , queryParameters , Options? options}) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options?.copyWith(
          headers: {'HttpHeaders.authorizationHeader': "Bearer $token"},
        ),
      );
      return ApiResponse(
        statusCode: response.statusCode ?? 0,
        body: response.data,
      );
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse> putRequest(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,}) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options?.copyWith(
          headers: {'HttpHeaders.authorizationHeader': "Bearer $token"},
        ),
      );
      return ApiResponse(
        statusCode: response.statusCode ?? 0,
        body: response.data,
      );
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse> patchRequest(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options?.copyWith(
          headers: {'HttpHeaders.authorizationHeader': "Bearer $token"},
        ),
      );
      return ApiResponse(
        statusCode: response.statusCode ?? 0,
        body: response.data,
      );
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse> deleteRequest(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options?.copyWith(
          headers: {'HttpHeaders.authorizationHeader': "Bearer $token"},
        ),
  
      );
      return ApiResponse(
        statusCode: response.statusCode ?? 0,
        body: response.data,
      );
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  ApiResponse _handleError(DioException error) {
    final statusCode = error.response?.statusCode ?? 0;
    final errorMessage = error.response?.data['error'] ?? 'Unknown error';
    return ApiResponse(statusCode: statusCode, body: {'error': errorMessage});
  }
}
