import 'package:flutter_admin/models/responeBodyApi.dart';
import 'package:flutter_admin/utils/httpUtil.dart';

class MenuApi {
  static Future<ResponeBodyApi> list(data) async {
    ResponeBodyApi responeBodyApi = await HttpUtil.post('/menu/list', data: data);
    return responeBodyApi;
  }

  static Future<ResponeBodyApi> saveOrUpdate(data) async {
    ResponeBodyApi responeBodyApi = await HttpUtil.post('/menu/saveOrUpdate', data: data);
    return responeBodyApi;
  }
  
  static removeByIds(data){
    return HttpUtil.post('/menu/removeByIds', data: data);
  }
}
