import 'package:flutter_admin/models/responseBodyApi.dart';
import 'package:flutter_admin/utils/httpUtil.dart';

class ImageApi {
  static Future<ResponseBodyApi> upload(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/image/upload', data: data);
    return responseBodyApi;
  }
}
