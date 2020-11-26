import 'package:cry/model/response_body_api.dart';
import 'package:flutter_admin/utils/http_util.dart';

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
