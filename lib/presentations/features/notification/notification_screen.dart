import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/core/api_service/token_manager.dart';
import 'package:skilluxfrontendflutter/models/notification/grouped_notification.dart';
import 'package:skilluxfrontendflutter/presentations/features/notification/widgets/notification_component.dart';
import 'package:skilluxfrontendflutter/services/notification_services/notification_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationService _notificationService =
      Get.put(NotificationService());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _notificationService.loadMoreNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;

    return Scaffold(
      appBar: AppBar(title: Text(text.notification)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(() {
          if (_notificationService.groupedNotifications.isEmpty) {
            return Center(child: Text(text.noNotification));
          }
          if (_notificationService.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: _notificationService.groupedNotifications.length + 1,
            itemBuilder: (context, index) {
              if (index < _notificationService.groupedNotifications.length) {
                GroupedNotification groupedNotification =
                    _notificationService.groupedNotifications[index];

                return NotificationComponent(
                    groupedNotification: groupedNotification);
              }
              return null;
            },
          );
        }),
      ),
    );
  }
}
