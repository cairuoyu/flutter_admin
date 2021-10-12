/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'dart:io';

import 'package:cry/cry.dart';
import 'package:cry/cry_dialog.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:cry/utils/cry_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_admin/constants/constant.dart';
import 'package:flutter_admin/constants/response_code_constant.dart';
import 'package:flutter_admin/utils/store_util.dart';
import 'package:flutter_admin/utils/utils.dart';

class CryDioInterceptors extends InterceptorsWrapper {
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    String? token = StoreUtil.read(Constant.KEY_TOKEN);
    if (token != null) {
      options.headers[HttpHeaders.authorizationHeader] = token;
    }
    CryUtils.loading();
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    CryUtils.loaded();
    print('RESPONSE[${response.statusCode}] => PATH: ${response.realUri}');
    ResponseBodyApi responseBodyApi = ResponseBodyApi.fromMap(response.data);
    if (responseBodyApi.code == ResponseCodeConstant.SESSION_EXPIRE_CODE) {
      cryConfirm(Cry.context, responseBodyApi.message!, (_) {
        Utils.logout();
        Cry.pushNamedAndRemove('/login');
      });
      return;
    }
    if (!responseBodyApi.success!) {
      CryUtils.message(responseBodyApi.message!);
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    CryUtils.loaded();
    print('ERROR[${err.response?.statusCode}] => PATH: ${err.response?.realUri}');
    print(err.toString());
    String message = '请求出错：' + err.toString();
    CryUtils.message(message);
    super.onError(err, handler);
  }
}
