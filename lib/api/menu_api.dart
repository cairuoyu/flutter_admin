import 'package:cry/model/page_model.dart';
import 'package:cry/model/request_body_api.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:cry/utils/http_util.dart';
import 'package:flutter_admin/models/menu.dart';

class MenuApi {
  static Future<ResponseBodyApi> listFlutterAdmin() async {
    return list(RequestBodyApi(page:PageModel(),params: Menu(subsystemId: '1').toMap()).toMap());
  }

  static Future<ResponseBodyApi> list(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/menu/list', data: data);
    return responseBodyApi;
  }

  static Future<ResponseBodyApi> saveOrUpdate(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/menu/saveOrUpdate', data: data);
    return responseBodyApi;
  }

  static removeByIds(data) {
    return HttpUtil.post('/menu/removeByIds', data: data);
  }
}
