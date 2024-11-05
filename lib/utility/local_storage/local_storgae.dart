import 'package:get_storage/get_storage.dart';

class LocalStorage {
  /// Write
  void saveLanguageToDisk(langusage) async {
    await GetStorage().write('lang', langusage);
  }

  /// Read
   get languageSelected async {
    return await GetStorage().read('lang');
  }
}
