import 'package:dio/dio.dart';
import 'dart:convert';
import 'Config.dart';

class Http {
  static Http instance;
  static BaseOptions _options;
  static Dio _dio;

  static Http getInstance() {
    if (instance == null) {
      instance = new Http();
      return instance;
    }
    return instance;
  }

  Http() {
    _options = new BaseOptions(
        baseUrl: Config.base_url,
        connectTimeout: Config.cannotTimeOut,
        receiveTimeout: Config.receiveTimeout,
        headers: {
          'Cookie': 'JSESSIONID=11a97b03-f2ee-4c6b-a1fd-ee043b9776ff;',
          'Cookie': 'route=;',
          'Cookie': 'login_device=6af8b37c-4d17-4d61-93e8-8af0f8a93475;',
          'Cookie': 'uid=412530;',
          'User-Agent': 'zhgtrade_android;',
          'X-Requested-With': 'XMLHttpRequest;'
        });
    _dio = new Dio(_options);
  }

  // get 请求封装
  get(url, {options, cancelToken, data = null}) async {
    print('get:::url：$url ,body: $data');
    Response response;
    try {
      response =
          await _dio.get(url, cancelToken: cancelToken, queryParameters: data);
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('get请求取消! ' + e.message);
      } else {
        print('get请求发生错误：$e');
      }
    }
    return response.data;
  }

  // post请求封装
  post(url, {options, cancelToken, data = null}) async {
    print('post请求::: url：$url ,body: $data');
    Response response;
    try {
      response =
          await _dio.post(url, queryParameters: data, cancelToken: cancelToken);
      json.decode(response.data);
      print(json.decode(response.data)['code']);
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('get请求取消! ' + e.message);
      } else {
        print('get请求发生错误：$e');
      }
    }
    return response.data;
  }
}
