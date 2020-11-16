import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_admin/constants/constant.dart';
import 'package:flutter_admin/models/response_body_api.dart';
import 'package:flutter_admin/utils/local_storage_util.dart';
import 'package:flutter_admin/utils/utils.dart';

class HttpUtil {
  static Dio dio;

//   static const String API_PREFIX = 'http://localhost:9094/';
  static const String API_PREFIX = 'http://www.cairuoyu.com/api/p4/';
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;

  static const String POST = 'post';
  static const String GET = 'get';

  static Future<ResponseBodyApi> get(String url, {data, requestToken = true}) async {
    return await request(url, data: data, requestToken: requestToken, method: GET);
  }

  static Future<ResponseBodyApi> post(String url, {data, requestToken = true}) async {
    return await request(url, data: data, requestToken: requestToken);
  }

  static Future<ResponseBodyApi> request(String url, {data, method, requestToken = true}) async {
    data = data ?? {};
    method = method ?? POST;

    Dio dio = createInstance();
    dio.options.method = method;

    Response res = await dio.request(url, data: data);
    ResponseBodyApi responseBodyApi = res.data;

    return responseBodyApi;
  }

  static Dio createInstance() {
    if (dio == null) {
      BaseOptions options = new BaseOptions(
        baseUrl: API_PREFIX,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      );

      dio = new Dio(options);
      dio.interceptors.add(CryDioInterceptors());
    }

    return dio;
  }

  static clear() {
    dio = null;
  }
}

class CryDioInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    // print("REQUEST[${options?.method}] => PATH: ${options?.path}");
    String token = LocalStorageUtil.get(Constant.KEY_TOKEN);
    options.headers[HttpHeaders.authorizationHeader] = token;
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    // print("RESPONSE[${response?.statusCode}] => PATH: ${response?.request?.path}");
    ResponseBodyApi responseBodyApi = ResponseBodyApi.fromJson(response.data);
    if (!responseBodyApi.success) {
      Utils.message(responseBodyApi.message);
    }
    response.data = responseBodyApi;
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    print("ERROR[${err?.response?.statusCode}] => PATH: ${err?.request?.path}");
    Utils.message('请求出错：' + err.toString());
    return super.onError(err);
  }
}
