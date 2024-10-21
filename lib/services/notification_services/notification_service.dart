import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/core/api_service/response_data_structure.dart';
import 'package:skilluxfrontendflutter/models/notification/notification.dart';

class NotificationService extends GetxController {
  final APIService _apiService = Get.find();
  final Logger _logger = Logger();

  // Variables for pagination
  final _limitNotification = 10;
  bool _hasMoreNotification = false;
  String _cursorNotifications = "";
  List<NotificationModel> notifications = <NotificationModel>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    getNotifications();
    super.onInit();
  }

  getNotifications() async {
    String path = 'basic/notifications/$_limitNotification/0';
    isLoading.value = true;

    ApiResponse response = await _apiService.getRequest(path);
    if (response.statusCode == 200) {
      notifications.clear();

      for (var notification in response.body["userNotifications"]) {
        NotificationModel newNotification =
            NotificationModel.fromBody(notification);
        notifications.add(newNotification);
      }
      _hasMoreNotification = response.body["hasMore"];

      if (_hasMoreNotification) {
        String nextCursor = response.body["nextCursor"];
        _cursorNotifications = nextCursor;
      }
    } else {
      _logger.e(response.message);
    }
        isLoading.value = false;

  }

  loadMoreNotifications() async {
    if (_hasMoreNotification) {
      String path =
          "basic/notifications/$_limitNotification/$_cursorNotifications";
      ApiResponse response = await _apiService.getRequest(path);

      if (response.statusCode == 200) {
        _hasMoreNotification = response.body["hasMore"];
        List<NotificationModel> notificationsList = [];

        for (var notification in response.body["userNotifications"]) {
          notificationsList.add(NotificationModel.fromBody(notification));
        }

        if (notificationsList.isNotEmpty) {
          notifications.addAll(notificationsList);
        }

        String nextCursor = response.body["nextCursor"] ?? '0';
        _cursorNotifications = nextCursor;
      } else {
        _logger.e(response.message);
      }
    }
  }
}
