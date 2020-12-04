import 'package:cry/utils/http_util.dart';

class RoleMenuApi {
  static save(data){
    return HttpUtil.post('/roleMenu/save', data: data);
  }
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
