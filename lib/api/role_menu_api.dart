import 'package:cry/utils/http_util.dart';

class RoleMenuApi {
  static saveBatch(data){
    return HttpUtil.post('/roleMenu/saveBatch', data: data);
  }
}
