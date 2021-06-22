/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/model/response_body_api.dart';
import 'package:cry/utils/http_util.dart';

class MessageApi {
  static Future<ResponseBodyApi> replayPage(data) {
    return HttpUtil.post('/message/replayPage', data: data);
  }

  static Future<ResponseBodyApi> replayCommit(data) {
    return HttpUtil.post('/message/replayCommit', data: data);
  }

  static page(data) {
    return HttpUtil.post('/message/page', data: data);
  }


  static Future<ResponseBodyApi> removeByIds(data) {
    return HttpUtil.post('/message/removeByIds', data: data);
  }
  static Future<ResponseBodyApi> save(data) {
    return HttpUtil.post('/message/save', data: data);
  }
}
