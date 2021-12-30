/*
 * flutter_ui_demo 
 * net_utils_home.dart 
 * 
 * Created by YueChen on 2021/12/22.
 */

import 'package:flutter_ui_demo/net/dio_manager.dart';
import 'package:flutter_ui_demo/net/net_utils.dart';

class HomeNetUrl extends NetUrl {
  static String homeBaseUrl = "https://www.baidu.com";

  static String repos = NetUrl.baseUrl + "/users/flutter/repos"; //仓库列表
  static String detail = NetUrl.baseUrl + "/repos/flutter/flutter"; //仓库详情
  static String issues = NetUrl.baseUrl + "/repos/flutter/flutter/issues"; //讨论
}

class HomeNetUtils extends NetUtils {
  /// 仓库列表
  static requestRepoList({
    Map<String, dynamic>? header,
    Map<String, dynamic>? params,
    Function? success,
    Function? error,
  }) {
    // 通过工具类请求
    NetUtils.sendRequest(
      HomeNetUrl.repos,
      DioGet,
      header: header,
      params: params,
      success: success,
      error: error,
    );
  }

  /// 仓库详情
  static requestRepoDetail({
    Map<String, dynamic>? header,
    Map<String, dynamic>? params,
    Function? success,
    Function? error,
  }) {
    // 通过工具类请求
    NetUtils.sendRequest(
      HomeNetUrl.detail,
      DioGet,
      header: header,
      params: params,
      success: success,
      error: error,
    );
  }

  /// 仓库讨论列表
  static requestRepoIssues({
    Map<String, dynamic>? header,
    Map<String, dynamic>? params,
    Function? success,
    Function? error,
  }) {
    // 通过工具类请求
    NetUtils.sendRequest(
      HomeNetUrl.issues,
      DioGet,
      header: header,
      params: params,
      success: success,
      error: error,
    );
  }
}
