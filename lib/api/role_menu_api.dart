/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/utils.dart';

class RoleMenuApi {
  static saveBatch(data){
    return HttpUtil.post('/roleMenu/saveBatch', data: data);
  }
}
