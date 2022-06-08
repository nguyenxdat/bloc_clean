import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'network.dart';

const String scheme = 'https';
const String host = 'true-survey.herokuapp.com';

class ApiProvider {
  final _dio = Dio(BaseOptions(
    baseUrl: Uri(scheme: scheme, host: host, path: '/api/v1').toString(),
    connectTimeout: 30000,
    headers: {
      'platform': Platform.isAndroid ? '2' : '1',
    },
  ));

  void _addInterceptors() {
    _dio
      ..interceptors.clear()
      ..interceptors.add(InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) =>
                _requestInterceptor(options, handler),
      ))
      ..interceptors.add(PrettyDioLogger(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
          responseHeader: true,
          maxWidth: 200,
          logPrint: (logValue) {
            log(logValue.toString());
          }));
  }

  void _requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String token = ''; //** Get TOKEN from Local**//
    options.headers.addAll({'Authorization': 'Bearer $token'});
    handler.next(options);
  }

  Future<dynamic> request({
    String? rawData,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    FormData? formParams,
    required String method,
    required String url,
  }) async {
    final dynamic responseJson;
    try {
      _addInterceptors();
      final response = await _dio.request(url,
          queryParameters: queryParams,
          data: (formParams != null)
              ? formParams
              : (data != null)
                  ? data
                  : rawData,
          options: Options(
              method: method,
              validateStatus: (code) {
                return code! >= 200 && code < 300;
              }));
      responseJson = _formatRes(response.statusCode, response.data);
    } on SocketException {
      throw ErrorException(HttpCode.noNetwork, "");
    } on DioError catch (e) {
      await Future.delayed(const Duration(milliseconds: 200));
      if (e.response?.statusCode == HttpCode.unauthorized) {}
      if (e.error is SocketException) {
        throw ErrorException(HttpCode.noNetwork, "");
      }
      throw ErrorException(e.response?.statusCode, e.message);
    }
    return responseJson;
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? params}) async {
    return await request(method: Method.get, url: url, queryParams: params);
  }

  Future<dynamic> postMultiPart(String url, FormData formData) async {
    return await request(method: Method.post, url: url, formParams: formData);
  }

  Future<dynamic> post(String url, {Map<String, dynamic>? params}) async {
    return await request(method: Method.post, url: url, data: params);
  }

  Future<dynamic> put(String url, {Map<String, dynamic>? params}) async {
    return await request(method: Method.put, url: url, data: params);
  }

  dynamic _formatRes(int? code, dynamic data) {
    switch (code) {
      case HttpCode.success:
        bool isSuccess = data['success'];
        if (isSuccess) {
          return data['data'];
        } else {
          int errorCode = data['error_code'];
          String errorMessage = _genMessageErrorByCode(errorCode);
          throw ErrorException(errorCode, errorMessage);
        }
      case HttpCode.badRequest:
      case HttpCode.unauthorized:
      case HttpCode.forbidden:
        throw UnauthorisedException('response.body.toString()');
      case HttpCode.internalServerError:
      default:
        throw ErrorException(code,
            'Error occured while Communication with Server with StatusCode : $code');
    }
  }

  String _genMessageErrorByCode(int errorCode) {
    switch (errorCode) {
      case 401:
        return 'Your account was expires';
    }
    return '';
  }
}

class Method {
  static String get get => 'get';

  static String get post => 'post';

  static String get patch => 'patch';

  static String get put => 'put';

  static String get delete => 'delete';
}
