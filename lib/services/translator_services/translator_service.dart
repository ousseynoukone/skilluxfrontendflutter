import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/models/tag/tag.dart';
import 'package:skilluxfrontendflutter/services/mainHelpers/helper.dart';
import 'package:translator/translator.dart';
import 'package:logger/logger.dart';

class TranslatorService extends GetxController {
  final Logger _logger = Logger();

  Future<String> translate(String? string, {lang = 'fr'}) async {
    if (string != null) {
      final translator = GoogleTranslator();
      try {
        var translation =
            await translator.translate(string, from: 'en', to: lang ?? 'fr');
        return translation.text;
      } catch (e) {
        _logger.e("Translation error: $e");
        return string;
      }
    } else {
      return "";
    }
  }

  Future<List<Tag>> translateTags(List<Tag> tags) async {
    if (await defaultLangage() == 'fr') {
      List<Tag> translatedTags = [];
      for (Tag tag in tags) {
        String translatedLibelle = await translate(tag.libelle);
        translatedTags
            .add(Tag(id: tag.id, score: tag.score, libelle: translatedLibelle));
      }
      return translatedTags;
    } else {
      return tags;
    }
  }
}
