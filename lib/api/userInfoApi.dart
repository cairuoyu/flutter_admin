import 'package:flutter_admin/models/responeBodyApi.dart';
import 'package:flutter_admin/utils/httpUtil.dart';

class UserInfoApi {
  static Future<ResponeBodyApi> getCurrentUserInfo() {
    return HttpUtil.post('/userInfo/getCurrentUserInfo');
  }

  static saveOrUpdate(data) {
    return HttpUtil.post('/userInfo/saveOrUpdate', data: data);
  }
}
