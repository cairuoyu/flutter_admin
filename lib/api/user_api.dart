/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/model/response_body_api.dart';
import 'package:cry/utils/http_util.dart';

class UserApi {
  static Future<ResponseBodyApi> register(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/user/register', data: data, requestToken: false);
    return responseBodyApi;
  }

  static Future<ResponseBodyApi> login(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/user/login', data: data, requestToken: false);
    return responseBodyApi;
  }
}
