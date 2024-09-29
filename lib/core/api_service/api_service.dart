import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:skilluxfrontendflutter/config/constant/constant.dart';
import 'package:skilluxfrontendflutter/core/api_service/helpers/save_post_helper.dart';
import 'package:skilluxfrontendflutter/core/api_service/response_data_structure.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:path/path.dart' as paTH;
import 'package:skilluxfrontendflutter/models/post/post.dart';

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

      if (!_tokenManager.abortRequest) {
        final uri = Uri.parse(BASE_URL + path)
            .replace(queryParameters: queryParameters);
        final response = await http.get(
          uri,
          headers: _setHeadersToken(),
        );
        return _handleResponse(response);
      } else {
        return const ApiResponse(
            statusCode: 401, body: {'error': 'Refresh Token Expired'});
      }
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
      if (!_tokenManager.abortRequest) {
        final uri = Uri.parse(BASE_URL + path)
            .replace(queryParameters: queryParameters);
        final response = await http.post(
          uri,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            ..._setHeadersToken(),
          },
          body: data == null ? null : jsonEncode(data),
        );
        return _handleResponse(response);
      } else {
        return const ApiResponse(
            statusCode: 401, body: {'error': 'Refresh Token Expired'});
      }
    } catch (e) {
      _logger.e(e.toString());
      return const ApiResponse(
          statusCode: 500, body: {'error': 'Internal Server Error'});
    }
  }

  Future<ApiResponse> multipartsPostSendRequest(String path, Post post) async {
    var errorMessage = "";

    try {
      await _tokenManager.refreshTokenIfNeeded();
      if (!_tokenManager.abortRequest) {
        final uri = Uri.parse(BASE_URL + path);

        List<XFile> imagesFiles = post.content.xFileMediaList;
        _logger.w(imagesFiles.length);
        // Create a multipart request
        var request = http.MultipartRequest('POST', uri);
        // Setting header
        request.headers.addAll({
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json',
          ..._setHeadersToken(),
        });

        if (post.headerImageIMG != null) {
          //Isolating coverImage
          XFile coverImageFile = imagesFiles.removeAt(0);

          request.files
              .add(await createMultipartFile(coverImageFile, "coverImage"));
        }

        // Add others  image file
        for (var imageFile in imagesFiles) {
          // Add the file to the request
          request.files.add(await createMultipartFile(imageFile, "medias"));
        }

        // Add post to the request
        request.fields.addAll(buildRequestFieldsForPost(post));

        var streamedResponse = await request.send();

        // Read the response body
        final responseBody = await streamedResponse.stream.bytesToString();

        var responseJson = jsonDecode(responseBody);

        if (streamedResponse.statusCode != 201) {
          return ApiResponse(
              statusCode: streamedResponse.statusCode,
              message: responseJson["error"]);
        }

        return ApiResponse(
            statusCode: streamedResponse.statusCode,
            message: streamedResponse.reasonPhrase);
      } else {
        return const ApiResponse(
            statusCode: 401, body: {'error': 'Refresh Token Expired'});
      }
    } catch (e) {
      _logger.d(e);
      return ApiResponse(
          message: e.toString(),
          statusCode: 500,
          body: {'error': 'Internal Server Error'});
    }
  }

  Future<ApiResponse> singleMediaPostRequest(
      String path, XFile media, String fieldName) async {
    try {
      await _tokenManager.refreshTokenIfNeeded();
      if (!_tokenManager.abortRequest) {
        final uri = Uri.parse(BASE_URL + path);

        // Create a multipart request
        var request = http.MultipartRequest('POST', uri);
        // Setting header
        request.headers.addAll({
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json',
          ..._setHeadersToken(),
        });

        //Isolating coverImage
        request.files.add(await createMultipartFile(media, fieldName));

        var streamedResponse = await request.send();

        // Read the response body
        final responseBody = await streamedResponse.stream.bytesToString();

        // If the response is JSON, you can decode it
        final responseJson = jsonDecode(responseBody);

        if (streamedResponse.statusCode != 201) {
          _logger.e(responseJson);
        }

        return ApiResponse(
            statusCode: streamedResponse.statusCode,
            message: streamedResponse.reasonPhrase);
      } else {
        return const ApiResponse(
            statusCode: 401, body: {'error': 'Refresh Token Expired'});
      }
    } catch (e) {
      _logger.e(e.toString());
      return ApiResponse(
          message: e.toString(),
          statusCode: 500,
          body: {'error': 'Internal Server Error'});
    }
  }

  Future<ApiResponse> putRequest(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      await _tokenManager.refreshTokenIfNeeded();

      if (!_tokenManager.abortRequest) {
        final uri = Uri.parse(BASE_URL + path)
            .replace(queryParameters: queryParameters);
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
      } else {
        return const ApiResponse(
            statusCode: 401, body: {'error': 'Refresh Token Expired'});
      }
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

      if (!_tokenManager.abortRequest) {
        final uri = Uri.parse(BASE_URL + path)
            .replace(queryParameters: queryParameters);
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
      } else {
        return const ApiResponse(
            statusCode: 401, body: {'error': 'Refresh Token Expired'});
      }
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

      if (!_tokenManager.abortRequest) {
        final uri = Uri.parse(BASE_URL + path)
            .replace(queryParameters: queryParameters);
        final response = await http.delete(
          uri,
          headers: _setHeadersToken(),
          body: jsonEncode(data),
        );
        return _handleResponse(response);
      } else {
        return const ApiResponse(
            statusCode: 401, body: {'error': 'Refresh Token Expired'});
      }
    } catch (e) {
      _logger.e(e.toString());
      return const ApiResponse(
          statusCode: 500, body: {'error': 'Internal Server Error'});
    }
  }

  Map<String, String> _setHeadersToken() {
    return {'authorization': 'Bearer ${_tokenManager.token.accessToken}'};
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