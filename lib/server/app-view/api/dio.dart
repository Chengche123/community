import 'package:dio/dio.dart';
import 'package:flutter_comic/conf/server/url.dart';

import 'package:flutter_comic/server/app-view/api/app.view.v1.api.pb.http.dart';

class AppviewServiceClientProxy extends AppviewServiceClient {
  static AppviewServiceClientProxy _instance;
  AppviewServiceClientProxy._(_dio) : super(_dio);

  // @override
  // Future<ListHomeMoResponse> listHomeMo(
  //     ListHomeMoRequest body, Map<String, dynamic> headers) async {
  //   return ListHomeMoResponse.fromJson(json.decode(HomeMoMock));
  // }

  // 在获取实例时才第一次初始化dio
  static AppviewServiceClientProxy getInstance() {
    if (_instance == null) {
      Dio dio = Dio();
      dio.options.baseUrl = appviewServiceBaseUrl;
      dio.options.connectTimeout = 5000;
      dio.options.receiveTimeout = 3000;

      _instance = AppviewServiceClientProxy._(dio);
    }
    return _instance;
  }
}
