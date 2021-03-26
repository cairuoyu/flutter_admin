import 'dart:io';

import 'package:cry/model/response_body_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_admin/constants/constant.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:get_storage/get_storage.dart';

class CryDioInterceptors extends InterceptorsWrapper {
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    String token = GetStorage().read(Constant.KEY_TOKEN);
    options.headers[HttpHeaders.authorizationHeader] = token;
    return super.onRequest(options, handler);
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('RESPONSE[${response.statusCode}] => PATH: ${response.realUri}');
    ResponseBodyApi responseBodyApi = ResponseBodyApi.fromMap(response.data);
    if (!responseBodyApi.success) {
      Utils.message(responseBodyApi.message);
    }
    return super.onResponse(response, handler);
  }
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('ERROR[${err.response?.statusCode}] => PATH: ${err.response.realUri}');
    print(err.toString());
    String message = '请求出错：' + err.toString();
    Utils.message(message);
    return super.onError(err, handler);
  }
}
