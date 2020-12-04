import 'package:cry/model/response_body_api.dart';
import 'package:cry/utils/http_util.dart';

class FileApi {
  static Future<ResponseBodyApi> upload(data) async {
    return await HttpUtil.post('/file/upload', data: data);
  }
}
