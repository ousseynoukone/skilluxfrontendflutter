import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      color: ColorsTheme.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/imgs/smart.png'),
          ListTile(
            title: Text(context.localizations.learnFromOther),
            subtitle: Text(context.localizations.getSuggestionBased),
            titleTextStyle: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: ColorsTheme.white),
            subtitleTextStyle: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: ColorsTheme.white),
          )
        ],
      ),
    );
  }
}
