import 'package:cry/utils/http_util.dart';

class DictItemApi {
  static all() {
    return HttpUtil.get('/dictItem/all');
  }
  static list(data){
    return HttpUtil.post('/dictItem/list',data: data);
  }
}
