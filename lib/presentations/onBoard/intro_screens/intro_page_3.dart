import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      color: ColorsTheme.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/imgs/share.png'),
          ListTile(
            title: Text(context.localizations.shareYourKnowledge),
            subtitle: Text(context.localizations.postTutorial),
            titleTextStyle: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: ColorsTheme.white),
            subtitleTextStyle: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: ColorsTheme.white),
          )
        ],
      ),
    );
  }
}
