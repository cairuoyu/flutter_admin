/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:


import 'package:cry/utils/http_util.dart';

class DictApi {
  static map() {
    return HttpUtil.get('/dict/map');
  }

  static importExcel(data) {
    return HttpUtil.post('/dict/importExcel', data: data);
  }

  static exportExcel(data) {
    return HttpUtil.post('/dict/exportExcel', data: data);
  }

  static page(data) {
    return HttpUtil.post('/dict/page', data: data);
  }

  static saveOrUpdate(data) {
    return HttpUtil.post('/dict/saveOrUpdate', data: data);
  }

  static removeByIds(data) {
    return HttpUtil.post('/dict/removeByIds', data: data);
  }
}
