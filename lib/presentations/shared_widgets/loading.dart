import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/skillux.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({super.key});

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Container(
            alignment: const Alignment(0, 0),
            child: const Skillux(heightDivider: 4, widthDivider: 2)),
      ),
    );
  }
}
