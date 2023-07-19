// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  int _maxCharactersPerLine = 200;

  @override
  Future<dynamic> onRequest(RequestOptions options,
      RequestInterceptorHandler interceptorHandler) async {
    print("--> ${options.method} ${options.path}");
    print("Content type: ${options.contentType}");
    print("<-- END HTTP");

    return super.onRequest(options, interceptorHandler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler interceptorHandler) async {
    print(
        "<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");
    String responseAsString = response.data.toString();
    if (responseAsString.length > _maxCharactersPerLine) {
      int iterations =
          (responseAsString.length / _maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * _maxCharactersPerLine + _maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        print(
            responseAsString.substring(i * _maxCharactersPerLine, endingIndex));
      }
    } else {
      print(response.data);
    }
    print("<-- END HTTP");

    return super.onResponse(response, interceptorHandler);
  }

  @override
  Future onError(
      DioError err, ErrorInterceptorHandler errorInterceptorHandler) async {
    print("<-- Error -->");
    print(err.error);
    print(err.message);
    return super.onError(err, errorInterceptorHandler);
  }
}
