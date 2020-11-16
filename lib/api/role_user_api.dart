import 'package:flutter_admin/utils/http_util.dart';

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
