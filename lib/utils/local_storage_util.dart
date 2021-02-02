import 'package:get_storage/get_storage.dart';

class LocalStorageUtil {
  static set(String k, String v) {
    GetStorage().write(k, v);
  }

  static String get(String k) {
    return GetStorage().read(k);
  }
}
