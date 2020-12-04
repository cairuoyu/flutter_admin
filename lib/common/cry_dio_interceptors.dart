import 'dart:io';

import 'package:cry/model/response_body_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_admin/constants/constant.dart';
import 'package:flutter_admin/utils/local_storage_util.dart';
import 'package:flutter_admin/utils/utils.dart';

class CryDioInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
//    print("REQUEST[${options?.method}] => PATH: ${options?.path}");
    String token = LocalStorageUtil.get(Constant.KEY_TOKEN);
    options.headers[HttpHeaders.authorizationHeader] = token;
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
//    print("RESPONSE[${response?.statusCode}] => PATH: ${response?.request?.path}");
    ResponseBodyApi responseBodyApi = ResponseBodyApi.fromMap(response.data);
    if (!responseBodyApi.success) {
      Utils.message(responseBodyApi.message);
    }
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    print("ERROR[${err?.response?.statusCode}] => PATH: ${err?.request?.path}");
    String message = '请求出错：' + err.toString();
    Utils.message(message);
    return super.onError(err);
  }
}
