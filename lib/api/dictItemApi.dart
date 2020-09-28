import 'package:flutter_admin/models/responseBodyApi.dart';
import 'package:flutter_admin/utils/httpUtil.dart';

class DictItemApi {
  static Future<ResponseBodyApi> all() async {
    return await HttpUtil.get('/dictItem/all');
  }
}
