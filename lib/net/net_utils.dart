/*
 * flutter_ui_demo 
 * net_utils.dart 
 * 
 * Created by YueChen on 2021/12/22.
 */

import 'package:flutter_ui_demo/net/dio_manager.dart';

class NetUrl {
  static String baseUrl = "https://api.github.com";

  static String search = baseUrl + "/search/repositories?q="; //搜索
  static String user = baseUrl + "/users/"; //用户
}

class NetUtils {
  /// Base Request
  static sendRequest(
    String url,
    String method, {
    Map<String, dynamic>? header,
    Map<String, dynamic>? params,
    Function? success,
    Function? error,
  }) {
    DioManager().requestNet(
      url,
      method,
      header: header,
      params: params,
      success: (result) {
        success?.call(result);
      },
      error: (errorCode, errorMsg) {
        error?.call(errorCode, errorMsg);
      },
    );
  }

  // 用户信息
  static requestUser(
    String u, {
    Function? success,
    Function? error,
  }) {
    // 通过相应模块的工具类请求
    if (u.length == 0) {
      u = "ConnyYue";
    }
    String url = NetUrl.user + u;
    sendRequest(
      url,
      DioGet,
      success: success,
      error: error,
    );
  }

  // 搜索
  static requestSearch(
    String q, {
    Function? success,
    Function? error,
  }) {
    // 通过相应模块的工具类请求
    if (q.length == 0) {
      q = "Flutter";
    }
    String searchPath = NetUrl.search + q;
    sendRequest(
      searchPath,
      DioGet,
      success: success,
      error: error,
    );
  }
}
