import 'package:flutter_admin/models/responeBodyApi.dart';
import 'package:flutter_admin/utils/httpUtil.dart';

class MenuDemoApi {
  static Future<ResponeBodyApi> list(data) async {
    ResponeBodyApi responeBodyApi = await HttpUtil.post('/menuDemo/list', data: data);
    return responeBodyApi;
  }

  static Future<ResponeBodyApi> saveOrUpdate(data) async {
    ResponeBodyApi responeBodyApi = await HttpUtil.post('/menuDemo/saveOrUpdate', data: data);
    return responeBodyApi;
  }
  
  static removeByIds(data){
    return HttpUtil.post('/menuDemo/removeByIds', data: data);
  }
}
