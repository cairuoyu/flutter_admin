/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/utils/http_util.dart';

class RoleUserApi {
  static saveBatch(data){
    return HttpUtil.post('/roleUser/saveBatch', data: data);
  }
  static removeBatch(data){
    return HttpUtil.post('/roleUser/removeBatch', data: data);
  }
  static removeByIds(data){
    return HttpUtil.post('/roleUser/removeByIds', data: data);
  }
}
