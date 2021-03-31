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

  static Future<ResponseBodyApi> save(data) {
    return HttpUtil.post('/message/save', data: data);
  }
}
