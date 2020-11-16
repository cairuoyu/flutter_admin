import 'package:flutter_admin/models/response_body_api.dart';
import 'package:flutter_admin/utils/http_util.dart';

class ImageApi {
  static Future<ResponseBodyApi> upload(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/image/upload', data: data);
    return responseBodyApi;
  }
}
