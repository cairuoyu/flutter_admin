import 'package:flutter_admin/models/responeBodyApi.dart';
import 'package:flutter_admin/utils/httpUtil.dart';

class VideoApi {
  static Future<ResponeBodyApi> upload(data) async {
    ResponeBodyApi responeBodyApi = await HttpUtil.post('/video/upload', data: data);
    return responeBodyApi;
  }
}
