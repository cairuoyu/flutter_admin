import 'package:flutter_admin/utils/http_util.dart';

class RoleApi {
  static getMenu(data) {
    return HttpUtil.post('/role/getMenu', data: data);
  }
  static getUnSelectedMenu(data) {
    return HttpUtil.post('/role/getUnSelectedMenu', data: data);
  }
  static getSelectedMenu(data) {
    return HttpUtil.post('/role/getSelectedMenu', data: data);
  }
  static getUnSelectedUserInfo(data) {
    return HttpUtil.post('/role/getUnSelectedUserInfo', data: data);
  }
  static getSelectedUserInfo(data) {
    return HttpUtil.post('/role/getSelectedUserInfo', data: data);
  }
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
