import 'package:flutter_admin/models/responeBodyApi.dart';
import 'package:flutter_admin/utils/httpUtil.dart';

class FileApi {
  static Future<ResponeBodyApi> upload(data) async {
    return await HttpUtil.post('/file/upload', data: data);
  }
}
