import 'package:flutter_admin/models/responseBodyApi.dart';
import 'package:flutter_admin/utils/httpUtil.dart';

class DictItemApi {
  static all() {
    return HttpUtil.get('/dictItem/all');
  }
  static list(data){
    return HttpUtil.post('/dictItem/list',data: data);
  }
}
