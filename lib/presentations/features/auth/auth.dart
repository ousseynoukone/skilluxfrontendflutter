import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/button.widgets.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/skillux.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    var _text = context.localizations;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                  alignment: const Alignment(0, 1),
                  child: const Skillux(heightDivider: 4, widthDivider: 2)),
              ListTile(
                title: Text(_text.stayEngaged, style: textTheme.titleMedium),
                subtitle: Text(_text.participateActively,
                    style: textTheme.bodyMedium),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
