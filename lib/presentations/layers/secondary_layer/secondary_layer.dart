import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skilluxfrontendflutter/presentations/layers/secondary_layer/bottom_navigation_bar.dart';

class SecondaryLayer extends StatefulWidget {
  const SecondaryLayer({super.key});

  @override
  State<SecondaryLayer> createState() => _SecondaryLayerState();
}

class _SecondaryLayerState extends State<SecondaryLayer> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BottomNavigationBarComponent(),
    );
  }
}
