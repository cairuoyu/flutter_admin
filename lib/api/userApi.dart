import 'package:flutter_admin/models/responeBodyApi.dart';
import 'package:flutter_admin/utils/httpUtil.dart';

class UserApi {
  static Future<ResponeBodyApi> register(data) async {
    ResponeBodyApi responeBodyApi = await HttpUtil.post('/user/register', data: data, requestToken: false);
    return responeBodyApi;
  }

  static Future<ResponeBodyApi> login(data) async {
    // String basic = 'Basic ' + base64.encode(utf8.encode('$login:$pwd'));
    ResponeBodyApi responeBodyApi = await HttpUtil.post('/user/login', data: data, requestToken: false);
    return responeBodyApi;
  }
}
