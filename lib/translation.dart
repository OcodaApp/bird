import 'package:get/get.dart';
import 'utility/langs/en.dart';
import 'utility/langs/ar.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ar': ar,
      };
}
