/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/model.dart';
import 'package:cry/utils.dart';

class UserInfoApi {
  static Future<ResponseBodyApi> page(data) {
    return HttpUtil.post('/userInfo/page', data: data);
  }

  static saveOrUpdate(data) {
    return HttpUtil.post('/userInfo/saveOrUpdate', data: data);
  }
}
