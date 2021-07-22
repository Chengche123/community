import 'package:dio/dio.dart';
import 'package:flutter_comic/server/auth/api/api.pb.dart';
class AuthServiceClient {
	final Dio _dio;
	AuthServiceClient(this._dio);

	Future<LoginResponse> login(LoginRequest body, Map<String, dynamic> headers) async {
		Response response = await _dio.post(
			"/AuthService/Login",
			options: Options(headers: headers,),
			data: body.toJson());

		return LoginResponse.fromJson(response.data);
	}

	Future<LoginResponse> userLogin(UserLoginRequest body, Map<String, dynamic> headers) async {
		Response response = await _dio.post(
			"/AuthService/UserLogin",
			options: Options(headers: headers,),
			data: body.toJson());

		return LoginResponse.fromJson(response.data);
	}

}
