/*
 * flutter_ui_demo 
 * dio_manager.dart 
 * 
 * Created by YueChen on 2021/12/22.
 */

import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'dart:convert' as convert;

// 接口请求数据
const String DioGet = "GET";
const String DioPost = "POST";
const String DioPut = "PUT";
const String DioDelete = "DELETE";

class DioManager {
  static final DioManager _instance = DioManager._internal();

  factory DioManager() {
    return _instance;
  }

  DioManager._internal() {
    //初始化
    _configManager();
  }

  // 接口返回数据
  static const String DioStatus = "status"; //接口字段 错误码
  static const String DioMessage = "message"; //接口字段 错误信息
  static const String DioResult = "result"; //接口字段 返回数据
  static const int DioCode = 0; // 默认错误码

  // 数据
  bool isRelease = true;
  String environment = "Online"; //测试环境 Test 线上环境 Online

  // 网络请求类
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: 30 * 1000,
      receiveTimeout: 30 * 1000,
      responseType: ResponseType.json,
    ),
  );

  /// 初始化
  _configManager() {
    _configHttpData();
    _configHttpSetting();
  }

  //MARK: Private
  _configHttpData() {
    //
  }

  _configHttpSetting() {
    // 日志
    if (kReleaseMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: false,
          responseBody: false,
        ),
      );
    } else {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
          responseHeader: true,
        ),
      );
    }
  }

  //MARK: Public - App Start
  // appStart() async {
  //   var dio = Dio();
  // final response = await dio.get('https://baidu.com');
  // print(response.data);
  // }

  //MARK: Public - Request
  Future<Response> request<T>(
    String url,
    String method, {
    Map<String, dynamic>? header,
    Map<String, dynamic>? params,
    Function? success,
    Function? error,
  }) async {
    /// 这个方法针对接口数据的统一性 进行校验
    Response response = await _requestDio(
      url,
      DioGet,
      header: header,
      params: params,
    );

    Map<String, dynamic> resultData = Map<String, dynamic>();

    if (response.data is Map) {
      resultData = response.data;
    } else if (response.data is String) {
      resultData = convert.jsonDecode(response.data);
    } else {
      // 接口格式异常
      response.statusCode = DioCode;
      response.statusMessage = "数据异常";

      error?.call(response.statusCode, response.statusMessage);
      return response;
    }

    if (response.statusCode == 200) {
      // 网络请求成功
      if (resultData.keys.contains(DioStatus) && resultData[DioStatus] == 200) {
        // 业务逻辑成功
        if (resultData.keys.contains(DioResult)) {
          T _result = resultData[DioResult];
          success?.call(_result);
        } else {
          success?.call(null);
        }
      } else {
        // 业务逻辑异常
        if (resultData.keys.contains(DioStatus) &&
            resultData.keys.contains(DioMessage)) {
          response.statusCode = resultData[DioStatus]; //状态码
          response.statusMessage = resultData[DioMessage]; //提示信息
        } else {
          response.statusCode = DioCode;
          response.statusMessage = "数据异常";
        }
        error?.call(response.statusCode, response.statusMessage);
      }
    } else {
      // 网络请求失败
      error?.call(response.statusCode, response.statusMessage);
    }
    return response;
  }

  //MARK: Public - Request Net
  Future<Response> requestNet(
    String url,
    String method, {
    Map<String, dynamic>? header,
    Map<String, dynamic>? params,
    Function? success,
    Function? error,
  }) async {
    /// 这个方法针对接口网络的正确性 进行校验
    Response response = await _requestDio(
      url,
      DioGet,
      header: header,
      params: params,
    );

    if (response.statusCode == 200) {
      // 网络请求成功
      success?.call(
        response.data,
      );
    } else {
      // 网络请求失败
      error?.call(
        response.statusCode,
        response.statusMessage,
      );
    }

    return response;
  }

  //MARK: Private - Base Method For Dio Request
  Future<Response> _requestDio(
    String url,
    String method, {
    Map<String, dynamic>? header,
    Map<String, dynamic>? params,
  }) async {
    /// 这个方法针对接口数据的调试
    Response response = await _requset(
      url,
      method: DioGet,
      header: header,
      params: params,
    );

    // 正式包不打印 可以调试Release包时手动注释
    if (kReleaseMode) {
      return response;
    }

    // 调试接口 这里可以查看特定的日志
    if (url.contains('baidu.com')) {
      print(response.requestOptions);
      print(response.data);
    }

    return response;
  }

  //MARK: Public - GET Method
  Future<Response> get(
    String url, {
    Map<String, dynamic>? header,
    Map<String, dynamic>? params,
  }) async {
    return await _requset(
      url,
      method: DioGet,
      header: header,
      params: params,
    );
  }

  //MARK: Public - POST Method
  Future<Response> post(
    String url, {
    Map<String, dynamic>? header,
    Map<String, dynamic>? body,
  }) async {
    return await _requset(
      url,
      method: DioPost,
      header: header,
      params: body,
    );
  }

  //MARK: Public - PUT Method
  Future<Response> put(
    String url, {
    Map<String, dynamic>? header,
    Map<String, dynamic>? body,
  }) async {
    return await _requset(
      url,
      method: DioPut,
      header: header,
      params: body,
    );
  }

  //MARK: Public - DELETE Method
  Future<Response> delete(
    String url, {
    Map<String, dynamic>? header,
    Map<String, dynamic>? body,
  }) async {
    return await _requset(
      url,
      method: DioDelete,
      header: header,
      params: body,
    );
  }

  //MARK: Private - 网络请求
  Future<Response> _requset(
    String url, {
    String method = DioGet,
    Map<String, dynamic>? header,
    Map<String, dynamic>? params,
  }) async {
    Response response;
    try {
      switch (method) {
        case DioPost:
          response = await _dio.post(
            url,
            data: params,
            options: Options(headers: header),
          );
          return response;
        case DioPut:
          response = await _dio.put(
            url,
            data: params,
            options: Options(headers: header),
          );
          return response;
        case DioDelete:
          Options options = Options(headers: header);
          response = await _dio.delete(
            url,
            data: params,
            options: options,
          );
          return response;
        default:
          response = await _dio.get(
            url,
            queryParameters: params,
            options: Options(headers: header),
          );
          return response;
      }
    } on DioError catch (dioError) {
      // 请求错误处理
      Response errorResponse;
      if (dioError.response != null) {
        errorResponse = dioError.response!;
      } else {
        errorResponse = Response(
          statusCode: DioCode,
          statusMessage: "网络异常",
          requestOptions: dioError.requestOptions,
        );
      }

      // 超时
      if (dioError.type == DioErrorType.connectTimeout ||
          dioError.type == DioErrorType.sendTimeout ||
          dioError.type == DioErrorType.receiveTimeout) {
        errorResponse.statusCode = DioCode;
        errorResponse.statusMessage = "网络超时";
      }

      // 其他
      if (dioError.type == DioErrorType.other) {
        errorResponse.statusCode = DioCode;
        errorResponse.statusMessage = "网络连接失败";
      }

      return errorResponse;
    }
  }
}
