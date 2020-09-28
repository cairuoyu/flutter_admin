import 'package:flutter_admin/models/responseBodyApi.dart';
import 'package:flutter_admin/utils/httpUtil.dart';

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
