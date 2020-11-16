import 'package:flutter_admin/models/response_body_api.dart';
import 'package:flutter_admin/utils/http_util.dart';

class FileApi {
  static Future<ResponseBodyApi> upload(data) async {
    return await HttpUtil.post('/file/upload', data: data);
  }
}
