import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/add_post_screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/discovery_screen/discovery_screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/home_screen/home_screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/profile_screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/search_screen/search_screen.dart';

class BottomNavigationBarComponent extends StatefulWidget {
  const BottomNavigationBarComponent({super.key});

  @override
  State<BottomNavigationBarComponent> createState() =>
      _BottomNavigationBarComponentState();
}

class _BottomNavigationBarComponentState
    extends State<BottomNavigationBarComponent> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const DiscoveryScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var text = context.localizations;

    return Scaffold(
        body: _screens[_currentIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed action here
            Get.to(() => AddPostScreen());
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  activeIcon: const Icon(Icons.home),
                  icon: const Icon(Icons.home_outlined),
                  label: text.home),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.compass_calibration_outlined),
                  activeIcon: const Icon(Icons.compass_calibration),
                  label: text.discovery),
              BottomNavigationBarItem(
                  activeIcon: const Icon(Icons.search),
                  icon: const Icon(Icons.search_outlined),
                  label: text.search),
              BottomNavigationBarItem(
                  activeIcon: const Icon(Icons.person),
                  icon: const Icon(Icons.person_outline),
                  label: text.profile),
            ]));
  }
}
