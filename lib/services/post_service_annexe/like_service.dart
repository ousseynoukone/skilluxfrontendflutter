import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/core/api_service/response_data_structure.dart';



class LikeService{
    final APIService _apiService = APIService();
  final Logger _logger = Logger();
  
   Future<bool> likePost(int postId) async {
    String path = 'basic/posts/vote/$postId';

    try {
      ApiResponse response = await _apiService.postRequest(path);

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      _logger.e(e);
    }

    return false;
  }

  Future<bool> unLikePost(int postId) async {
    String path = 'basic/posts/unvote/$postId';

    try {
      ApiResponse response = await _apiService.postRequest(path);

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      _logger.e(e);
    }

    return false;
  }
}