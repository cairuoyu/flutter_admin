import 'package:flutter_admin/utils/httpUtil.dart';

class RoleMenuApi {
  static saveBatch(data){
    return HttpUtil.post('/roleMenu/saveBatch', data: data);
  }
  static removeBatch(data){
    return HttpUtil.post('/roleMenu/removeBatch', data: data);
  }
  static removeByIds(data){
    return HttpUtil.post('/roleMenu/removeByIds', data: data);
  }
}
