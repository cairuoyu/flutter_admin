import 'package:flutter_admin/utils/httpUtil.dart';

class UserInfoApi {
  static list(data) {
    return HttpUtil.post('/userInfo/list', data: data);
  }
  static page(data) {
    return HttpUtil.post('/userInfo/page', data: data);
  }
  static getById(data) {
    return HttpUtil.post('/userInfo/getById', data: data);
  }
  static saveOrUpdate(data) {
    return HttpUtil.post('/userInfo/saveOrUpdate', data: data);
  }
  static removeByIds(data){
    return HttpUtil.post('/userInfo/removeByIds', data: data);
  }
}
