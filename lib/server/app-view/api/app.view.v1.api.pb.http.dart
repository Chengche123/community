import 'package:dio/dio.dart';
import 'package:flutter_comic/server/app-view/api/app.view.v1.api.pb.dart';
class AppviewServiceClient {
	final Dio _dio;
	AppviewServiceClient(this._dio);

	Future<ListHomeMoResponse> listHomeMo(ListHomeMoRequest body, Map<String, dynamic> headers) async {
		Response response = await _dio.post(
			"/AppviewService/ListHomeMo",
			options: Options(headers: headers,),
			data: body.toJson());

		return ListHomeMoResponse.fromJson(response.data);
	}

	Future<ListComicDetailResponse> listComicDetail(ListComicDetailRequest body, Map<String, dynamic> headers) async {
		Response response = await _dio.post(
			"/AppviewService/ListComicDetail",
			options: Options(headers: headers,),
			data: body.toJson());

		return ListComicDetailResponse.fromJson(response.data);
	}

}
