import 'package:flutter_admin/utils/httpUtil.dart';

class RoleApi {
  static list(data) {
    return HttpUtil.post('/role/list', data: data);
  }
  static page(data) {
    return HttpUtil.post('/role/page', data: data);
  }
  static getById(data) {
    return HttpUtil.post('/role/getById', data: data);
  }
  static saveOrUpdate(data) {
    return HttpUtil.post('/role/saveOrUpdate', data: data);
  }
  static removeByIds(data){
    return HttpUtil.post('/role/removeByIds', data: data);
  }
}
