import 'package:flutter_admin/models/responseBodyApi.dart';
import 'package:flutter_admin/utils/httpUtil.dart';

class FileApi {
  static Future<ResponseBodyApi> upload(data) async {
    return await HttpUtil.post('/file/upload', data: data);
  }
}
