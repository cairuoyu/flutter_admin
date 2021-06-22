/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/model/response_body_api.dart';
import 'package:cry/utils/http_util.dart';

class DeptApi {
  static Future<ResponseBodyApi> list(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/dept/list', data: data);
    return responseBodyApi;
  }

  static Future<ResponseBodyApi> saveOrUpdate(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/dept/saveOrUpdate', data: data);
    return responseBodyApi;
  }

  static removeByIds(data) {
    return HttpUtil.post('/dept/removeByIds', data: data);
  }
}
