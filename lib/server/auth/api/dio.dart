import 'package:dio/dio.dart';
import 'package:flutter_comic/conf/server/url.dart';
import 'package:flutter_comic/server/auth/api/api.pb.http.dart';

class AuthServiceClientProxy extends AuthServiceClient {
  static AuthServiceClientProxy _instance;
  AuthServiceClientProxy._(_dio) : super(_dio);

  // 在获取实例时才第一次初始化dio
  static AuthServiceClientProxy getInstance() {
    if (_instance == null) {
      Dio dio = Dio();
      dio.options.baseUrl = authServiceBaseUrl;
      dio.options.connectTimeout = 5000;
      dio.options.receiveTimeout = 3000;

      _instance = AuthServiceClientProxy._(dio);
    }
    return _instance;
  }
}
