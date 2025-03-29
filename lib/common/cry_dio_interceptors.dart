/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'dart:io';

import 'package:cry/model.dart';
import 'package:cry/utils.dart';
import 'package:cry/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter_admin/constants/constant.dart';
import 'package:flutter_admin/constants/response_code_constant.dart';
import 'package:flutter_admin/utils/store_util.dart';
import 'package:flutter_admin/utils/utils.dart';

class CryDioInterceptors extends InterceptorsWrapper {
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    LoggerUtil.info('REQUEST[${options.method}] => PATH: ${options.path}');
    String? token = StoreUtil.read(Constant.KEY_TOKEN);
    if (token != null) {
      options.headers[HttpHeaders.authorizationHeader] = token;
    }
    CryUtil.loading();
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    CryUtil.loaded();
    LoggerUtil.info('RESPONSE.statusCode[${response.statusCode}] => response.realUri: ${response.realUri}');
    LoggerUtil.info('RESPONSE.data[${response.data}]');
    ResponseBodyApi responseBodyApi = ResponseBodyApi.fromMap(response.data);
    if (responseBodyApi.code == ResponseCodeConstant.SESSION_EXPIRE_CODE) {
      cryConfirm(CryUtil.context, responseBodyApi.message!, (_) {
        Utils.logout();
        CryUtil.pushNamedAndRemove('/login');
      });
      return;
    }
    if (!responseBodyApi.success!) {
      CryUtil.message(responseBodyApi.message!);
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    CryUtil.loaded();
    LoggerUtil.error('ERROR[${err.response?.statusCode}] => PATH: ${err.response?.realUri}');
    LoggerUtil.error(err.toString());
    CryUtil.message('服务器忙，请稍后再试');
    super.onError(err, handler);
  }
}
