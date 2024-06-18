import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
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
    var text = context.localizations;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // remove back button in appbar.
          bottom: TabBar(
            labelColor: context.textTheme.bodyLarge?.color,
            unselectedLabelColor: ColorsTheme.grey,
            indicatorColor: ColorsTheme.primary,
            tabs: [
              Tab(text: text.login),
              Tab(text: text.register),
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
