import 'package:flutter_admin/models/responseBodyApi.dart';
import 'package:flutter_admin/utils/httpUtil.dart';

class DictApi {
  static Future<ResponseBodyApi> page(data) async {
    return await HttpUtil.post('/dict/page',data: data);
  }
}
