import 'package:flutter_admin/models/responeBodyApi.dart';
import 'package:flutter_admin/utils/httpUtil.dart';

class ImageApi {
  static Future<ResponeBodyApi> upload(data) async {
    ResponeBodyApi responeBodyApi = await HttpUtil.post('/image/upload', data: data);
    return responeBodyApi;
  }
}
