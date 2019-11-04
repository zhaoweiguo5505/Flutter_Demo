

import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/common/BaseCommon.dart';
import 'package:flutter_app/utils/Toast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
final  http = BaseHttp();

class BaseHttp extends DioForNative {
  static BaseHttp instance;
  static int cannotTimeOut = 3000;
  static int receiveTimeout = 3000;
  static String errorMessage;
  static BaseHttp getInstance() {
    if (instance == null) {
      instance = new BaseHttp();
      return instance;
    }
    return instance;
  }

  BaseHttp() {
    options.baseUrl = "https://www.wanandroid.com/";
    interceptors.add(ApiInterceptor());
    interceptors.add(CookieManager(
        PersistCookieJar(dir: StorageManager.temporaryDirectory.path)));
  }


  // post请求封装
  // ignore: avoid_init_to_null

}

class StorageManager {
  /// app全局配置 eg:theme
  static SharedPreferences sharedPreferences;
  static Directory temporaryDirectory;
  static LocalStorage localStorage;

  /// 必备数据的初始化操作
  ///
  /// 由于是同步操作会导致阻塞,所以应尽量减少存储容量
  static init() async {
    // async 异步操作
    // sync 同步操作
    temporaryDirectory = await getTemporaryDirectory();
    sharedPreferences = await SharedPreferences.getInstance();
    localStorage = LocalStorage('LocalStorage');
    await localStorage.ready;
  }
}

class BaseBean{
  dynamic data;
  int code = 0;
  String message;

  bool get success => 0 == code;

  BaseBean({this.data, this.code, this.message});

  @override
  String toString() {
    return 'RespData{data: $data, status: $code, message: $message}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.code;
    data['errorMsg'] = this.message;
    data['data'] = this.data;
    return data;
  }

  BaseBean.fromJson(Map<String, dynamic> json) {
    code = json['errorCode'];
    message = json['errorMsg'];
    data = json['data'];
  }
}

/// 玩Android API
class ApiInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
        ' queryParameters: ${options.queryParameters}');
//    debugPrint('---api-request--->data--->${options.data}');
    return options;

  }

  @override
  onResponse(Response response) {
    BaseBean respData = BaseBean.fromJson(response.data);
    if (respData.success) {
      response.data = respData.data;
      return http.resolve(response);
    } else {
      return handleFailed(respData);
    }
  }

  Future<Response> handleFailed(BaseBean respData) {
    debugPrint('---api-response--->error---->$respData');
    if(respData.code == -1001){
      StorageManager.localStorage.deleteItem(BaseCommon.user);
    }
   BaseHttp.errorMessage  = respData.message;
    return http.reject(respData.message);
  }
}

enum ViewState { idle, busy, empty, error, unAuthorized }

//enum ConnectivityStatus { WiFi, Cellular, Offline }

/// 用于未登录等权限不够,需要跳转授权页面
class UnAuthorizedException implements Exception {
  const UnAuthorizedException();

  @override
  String toString() => 'UnAuthorizedException';
}
