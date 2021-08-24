/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/8/24
/// @version: 1.0
/// @description:

import 'package:cry/model/response_body_api.dart';
import 'package:cry/utils/http_util.dart';

class SettingDefaultTabApi {
  static Future<ResponseBodyApi> list() {
    return HttpUtil.post('/settingDefaultTab/list' );
  }
  static saveOrUpdate(data) {
    return HttpUtil.post('/settingDefaultTab/saveOrUpdate', data: data);
  }
  static removeByIds(data){
    return HttpUtil.post('/settingDefaultTab/removeByIds', data: data);
  }
}
