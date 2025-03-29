import 'package:cry/model.dart';
import 'package:cry/utils.dart';

/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description: 文章api


class ArticleApi {
  static Future<ResponseBodyApi> page(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/article/page', data: data);
    return responseBodyApi;
  }

  static Future<ResponseBodyApi> save(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/article/save', data: data);
    return responseBodyApi;
  }

  static Future<ResponseBodyApi> audit(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/article/audit', data: data);
    return responseBodyApi;
  }

  static Future<ResponseBodyApi> public(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/article/public', data: data);
    return responseBodyApi;
  }

  static Future<ResponseBodyApi> removeByIds(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/article/removeByIds', data: data);
    return responseBodyApi;
  }
}
