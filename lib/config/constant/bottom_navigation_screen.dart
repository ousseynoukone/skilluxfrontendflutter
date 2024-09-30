  import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/presentations/features/discovery_screen/discovery_screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/home_screen/home_screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/profile_screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/search_screen/search_screen.dart';

final List<Widget> bnScreensList = [
    const HomeScreen(),
    const DiscoveryScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];