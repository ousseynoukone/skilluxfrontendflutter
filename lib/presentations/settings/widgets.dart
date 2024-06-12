import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/generale_stream_language.dart';
import 'package:skilluxfrontendflutter/l10n/l10n.dart';

class ChangeLanguage extends StatelessWidget {
  const ChangeLanguage({super.key, required this.selectedLocal});

  final Locale selectedLocal;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(context.localizations.language),
        Text(context.localizations.twoLanguages),
        ElevatedButton(
            onPressed: () {
              GeneraleStreamLanguage.languageStream.add(L10n.locals
                  .firstWhere((element) => element != selectedLocal));
            },
            child: Text(context.localizations.changeLanguage))
      ],
    );
  }
}
