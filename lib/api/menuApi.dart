import 'package:flutter_admin/models/responseBodyApi.dart';
import 'package:flutter_admin/utils/httpUtil.dart';

class MenuApi {
  static Future<ResponseBodyApi> list(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/menu/list', data: data);
    return responseBodyApi;
  }

  static Future<ResponseBodyApi> saveOrUpdate(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/menu/saveOrUpdate', data: data);
    return responseBodyApi;
  }
  
  static removeByIds(data){
    return HttpUtil.post('/menu/removeByIds', data: data);
  }
}
