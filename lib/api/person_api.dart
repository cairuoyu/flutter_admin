import 'package:cry/utils/http_util.dart';

class PersonApi {
  static list(data) {
    return HttpUtil.post('/person/list', data: data);
  }
  static page(data) {
    return HttpUtil.post('/person/page', data: data);
  }
  static getById(data) {
    return HttpUtil.post('/person/getById', data: data);
  }
  static saveOrUpdate(data) {
    return HttpUtil.post('/person/saveOrUpdate', data: data);
  }
  static removeByIds(data){
    return HttpUtil.post('/person/removeByIds', data: data);
  }
}
