/// @author: cairuoyu
/// @Copyright: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/model/response_body_api.dart';
import 'package:cry/utils/http_util.dart';

class UserInfoApi {
  static Future<ResponseBodyApi> page(data) {
    return HttpUtil.post('/userInfo/page', data: data);
  }

  static Future<ResponseBodyApi> getCurrentUserInfo() {
    return HttpUtil.post('/userInfo/getCurrentUserInfo');
  }

  static saveOrUpdate(data) {
    return HttpUtil.post('/userInfo/saveOrUpdate', data: data);
  }
}
