import 'package:flutter_admin/models/response_body_api.dart';
import 'package:flutter_admin/utils/http_util.dart';

class VideoApi {
  static Future<ResponseBodyApi> upload(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/video/upload', data: data);
    return responseBodyApi;
  }
}
