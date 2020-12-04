import 'package:cry/model/response_body_api.dart';
import 'package:cry/utils/http_util.dart';

class MenuDemoApi {
  static Future<ResponseBodyApi> list(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/menuDemo/list', data: data);
    return responseBodyApi;
  }

  static Future<ResponseBodyApi> saveOrUpdate(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/menuDemo/saveOrUpdate', data: data);
    return responseBodyApi;
  }
  
  static removeByIds(data){
    return HttpUtil.post('/menuDemo/removeByIds', data: data);
  }
}
