import 'package:flutter_admin/models/responseBodyApi.dart';
import 'package:flutter_admin/utils/httpUtil.dart';

class DictApi {
  static map() {
    return HttpUtil.get('/dict/map');
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
