import 'package:flutter_admin/models/responeBodyApi.dart';
import 'package:flutter_admin/utils/httpUtil.dart';

class DictItemApi {
  static Future<ResponeBodyApi> all() async {
    return await HttpUtil.get('/dictItem/all');
  }
}
