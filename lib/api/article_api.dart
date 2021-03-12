import 'package:cry/model/response_body_api.dart';
import 'package:cry/utils/http_util.dart';

class ArticleApi {
  static Future<ResponseBodyApi> page(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/article/page', data: data);
    return responseBodyApi;
  }

  static Future<ResponseBodyApi> save(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/article/save', data: data);
    return responseBodyApi;
  }
}
