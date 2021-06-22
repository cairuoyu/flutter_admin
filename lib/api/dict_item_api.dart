/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/utils/http_util.dart';

class DictItemApi {
  static all() {
    return HttpUtil.get('/dictItem/all');
  }
  static list(data){
    return HttpUtil.post('/dictItem/list',data: data);
  }
}
