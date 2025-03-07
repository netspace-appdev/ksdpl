

import 'package:get_storage/get_storage.dart';

class StorageService {
  static final GetStorage _storage = GetStorage();

  static const String USER_ID = "uid";
  static const String FIRST_NAME = "FIRST_NAME";
  static const String EMAIL = "EMAIL";
  static const String TOKEN = "TOKEN";
  static const String PHONE = "PHONE";
  static const String BANKER_ID = "BANKER_ID";
  static const String THEME_MODE = "THEME_MODE";
  static const String BANK_ID = "BANK_ID";


  static void put(String key, String value) {
    _storage.write(key, value);
  }
  static String? get(String key) {
    return _storage.read(key);
  }
  static clear() {
   _storage.erase();

  }
  static void delete(String key) {
     _storage.remove(key);
  }
}
