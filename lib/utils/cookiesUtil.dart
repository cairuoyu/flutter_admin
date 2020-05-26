import 'package:universal_html/prefer_universal/html.dart';

class CookiesUtil {
  static set(String k, String v) {
    document.cookie = k + "=" + v;
  }

  static String get(String k) {
    List<String> list = document.cookie.split("; ");
    if (list.isEmpty) {
      return null;
    }
    String m = list.firstWhere((element) {
      return element.split("=").first == k;
    }, orElse: () {
      return null;
    });
    if (m != null) {
      return m.split("=")[1];
    }
    return null;
  }
}
