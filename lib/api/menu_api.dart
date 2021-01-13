import 'package:cry/model/response_body_api.dart';
import 'package:cry/utils/http_util.dart';

class MenuApi {
  static Future<ResponseBodyApi> listAuth() async {
    return await HttpUtil.post('/menu/listAuth');
  }

  static Future<ResponseBodyApi> list(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/menu/list', data: data);
    return responseBodyApi;
  }

  static Future<ResponseBodyApi> saveOrUpdate(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/menu/saveOrUpdate', data: data);
    return responseBodyApi;
  }

  static removeByIds(data) {
    return HttpUtil.post('/menu/removeByIds', data: data);
  }
}
