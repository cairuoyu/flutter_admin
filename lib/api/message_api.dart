import 'package:cry/model/response_body_api.dart';
import 'package:flutter_admin/utils/http_util.dart';

class MessageApi {
  static page(data) {
    return HttpUtil.post('/message/page', data: data);
  }

  static Future<ResponseBodyApi> save(data) {
    return HttpUtil.post('/message/save', data: data);
  }
}
