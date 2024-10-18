import 'package:eventflux/eventflux.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/config/constant/constant.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/core/api_service/token_manager.dart';

class NotificationSse {
  final Logger _logger = Logger();
  final APIService _apiService = Get.find();
  final TokenManager _tokenManager = Get.find();
   RxInt notificationCount = 0.obs; 

  connectToTheStream() async {
    // Checking if token need to be refershed before making the request
    await _tokenManager.refreshTokenIfNeeded();
    // If the process of refreshing the token did not work out , request is aborted
    if (_tokenManager.abortRequest) {
      return;
    }

    // Connect and start the magic!
    EventFlux.instance.connect(
      header: _apiService.setHeadersToken(),
      EventFluxConnectionType.get,
      '${BASE_URL}basic/sse-notifications',
      files: [
        /// Optional, If you want to send multipart files with the request
      ],
      multipartRequest:
          false, // Optional, By default, it will be considered as normal request, but if the files are provided or this flag is true, it will be considered as multipart request
      onSuccessCallback: (EventFluxResponse? response) {
        response?.stream?.listen((data) {
          // Assuming data.data is a string that can be converted to an int
          try {
            // Convert the data to an int and assign it
            notificationCount.value =
                int.parse(data.data.toString());
          } catch (e) {
            _logger.w('Error converting data to int: $e');
          }
        });
      },
      onError: (oops) {
        // Oops! Time to handle those little hiccups.
        // You can also choose to disconnect here
      },
      autoReconnect: true, // Keep the party going, automatically!
      reconnectConfig: ReconnectConfig(
          mode: ReconnectMode.linear, // or exponential,
          interval: const Duration(seconds: 5),
          // reconnectHeader: () async {
          //   /// If you want to send custom headers during reconnect which are different from the initial connection
          //   /// If you don't want to send any headers, you can skip this, initial headers will be used

          //   // Your async code to refresh or fetch headers
          //   // For example, fetching a new access token:
          //   String newAccessToken = await fetchNewAccessToken();
          //   return {
          //     'Authorization': 'Bearer $newAccessToken',
          //     'Accept': 'text/event-stream',
          //   };
          // },
          maxAttempts: 5, // or -1 for infinite,
          onReconnect: () {
            // Things to execute when reconnect happens
            // FYI: for network changes, the `onReconnect` will not be called.
            // It will only be called when the connection is interupted by the server and eventflux is trying to reconnect.
          }),
    );
  }
}
