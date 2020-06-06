import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter_admin/constants/constant.dart';
import 'package:flutter_admin/models/responeBodyApi.dart';
import 'package:flutter_admin/utils/localStorageUtil.dart';

class HttpUtil {
  static Dio dio;

//  static const String API_PREFIX = 'http://localhost:9094/';
  static const String API_PREFIX = 'http://www.cryqd.com/api/p4/';
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;

  static const String POST = 'post';
  static const String GET= 'get';

  static Future<ResponeBodyApi> get(String url, {data, requestToken = true}) async {
    Map map = await request(url, data: data, requestToken: requestToken,method: GET);
    if (map == null) {}
    ResponeBodyApi responeBodyApi = ResponeBodyApi.fromJson(map);
    return responeBodyApi;
  }
  static Future<ResponeBodyApi> post(String url, {data, requestToken = true}) async {
    Map map = await request(url, data: data, requestToken: requestToken);
    if (map == null) {}
    ResponeBodyApi responeBodyApi = ResponeBodyApi.fromJson(map);
    return responeBodyApi;
  }

  static Future<Map> request(String url, {data, method, requestToken = true}) async {
    data = data ?? {};
    method = method ?? POST;

    String token = LocalStorageUtil.get(Constant.KEY_TOKEN);
//    if (url != "/user/login" && requestToken && token == null) {
      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Layout1()));
//    }

    Dio dio = createInstance();
    if (requestToken) {
      dio.options.headers[HttpHeaders.authorizationHeader] = token;
    }
    dio.options.method = method;
    var result;

    try {
      Response res = await dio.request(url, data: data);
      result = res.data;
    } on DioError catch (e) {
      BotToast.showText(text: '请求出错：' + e.toString());

      throw e.toString() + '||' + API_PREFIX + url;
    }

    return result;
  }

  static Dio createInstance() {
    if (dio == null) {
      BaseOptions options = new BaseOptions(
        baseUrl: API_PREFIX,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      );

      dio = new Dio(options);
    }

    return dio;
  }

  static clear() {
    dio = null;
  }
}
