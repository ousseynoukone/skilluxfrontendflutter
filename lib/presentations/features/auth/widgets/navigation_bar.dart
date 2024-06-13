import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/presentations/features/auth/login.dart';
import 'package:skilluxfrontendflutter/presentations/features/auth/register.dart';

class TopNavigationBar extends StatefulWidget {
  const TopNavigationBar({Key? key}) : super(key: key);

  @override
  State<TopNavigationBar> createState() => _TopNavigationBarState();
}

class _TopNavigationBarState extends State<TopNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelColor: context.textTheme.bodyLarge?.color,
            unselectedLabelColor: ColorsTheme.grey,
            indicatorColor: ColorsTheme.primary,
            tabs: const [
              Tab(text: 'Login'),
              Tab(text: 'Register'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [Login(), Register()],
        ),
      ),
    );
  }
}
