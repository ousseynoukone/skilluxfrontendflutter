import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/presentations/features/auth/login.dart';
import 'package:skilluxfrontendflutter/presentations/features/auth/register.dart';
import 'package:skilluxfrontendflutter/presentations/features/auth/widgets/navigation_bar/navigation_bar_controller.dart';

class TopNavigationBar extends StatefulWidget {
  const TopNavigationBar({super.key});

  @override
  State<TopNavigationBar> createState() => _TopNavigationBarState();
}

class _TopNavigationBarState extends State<TopNavigationBar>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final NavigationBarController _navigationBarController = Get.find();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    listenRegisterState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void listenRegisterState() {
    // Listen to changes in index using obs
    _navigationBarController.index.listen((newIndex) {
      _tabController.index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 1,

          automaticallyImplyLeading: false, // remove back button in appbar.
          bottom: TabBar(
            controller: _tabController,
            labelColor: context.textTheme.bodyLarge?.color,
            unselectedLabelColor: ColorsTheme.grey,
            indicatorColor: ColorsTheme.primary,
            tabs: [
              Tab(text: text.login),
              Tab(text: text.register),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [Login(), Register()],
        ),
      ),
    );
  }
}
