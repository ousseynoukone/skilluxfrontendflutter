import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/core/api_service/response_data_structure.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
class UserRepository {
  final APIService _apiService = Get.find();
  final Logger _logger = Logger();

  var cursorUser = "0";
  var limitUser = 20;
  bool hasMoreUser = false;
  final RxList<User> users = <User>[].obs;
  String username = "";

  reinititalizeParams() {
    cursorUser = "0";
    hasMoreUser = false;
    users.value = [];
  }

  Future<void> searchUsers(String username) async {
    this.username = username;
    if (username.isNotEmpty) {
      String path = "basic/search-users/$username/$limitUser/0";
      List<User> userList = [];
      users.clear();  // Clear existing users before new search

      ApiResponse response = await _apiService.getRequest(path);
      if (response.statusCode == 200) {
        bool hasMore = response.body["hasMore"];

        for (var user in response.body["users"]) {
          User fetchUser = User.fromBody(user);  
          userList.add(fetchUser);
        }

        if (userList.isNotEmpty) {
          users.addAll(userList);  
        }

        if (hasMore) {
          String nextCursor = response.body["nextCursor"];
          cursorUser = nextCursor;
          hasMoreUser = hasMore;
        } else {
          hasMoreUser = false;  // Explicitly set false when no more results
          cursorUser = "0";     // Reset cursor when no more results
        }
      } else {
        _logger.e(response.message);
      }
    } else {
      users.clear();
      hasMoreUser = false;  // Reset pagination when clearing
      cursorUser = "0";     // Reset cursor when clearing
    }
  }

  Future<void> loadMoreUser() async {
    if (hasMoreUser) {
      String path = "basic/search-users/$username/$limitUser/$cursorUser";
      ApiResponse response = await _apiService.getRequest(path);

      if (response.statusCode == 200) {
        List<User> userList = [];

        for (var user in response.body["users"]) {
          User fetchUser = User.fromBody(user);  
          userList.add(fetchUser);
        }
        
        hasMoreUser = response.body["hasMore"];
        String nextCursor = response.body["nextCursor"] ?? '0';
        cursorUser = nextCursor;

        if (userList.isNotEmpty) {
          users.addAll(userList);  // No need for return statement
        }
      } else {
        _logger.e(response.message);
      }
    }
  }
}