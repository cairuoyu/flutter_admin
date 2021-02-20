import 'package:cry/model/response_body_api.dart';
import 'package:cry/utils/http_util.dart';

class SAreaAgeGenderApi {
  static Future<ResponseBodyApi> list({data}) {
    return HttpUtil.post('/sAreaAgeGender/list', data: data );
  }
}
