import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_comic/server/auth/api/api.pb.dart';
class AuthServiceClient {
	String baseUrl;
	AuthServiceClient(String baseUrl) {this.baseUrl = baseUrl;}
	Future<LoginResponse> login(LoginRequest body, Map<String, String> headers) async {
		final response = await http.post(
			Uri.parse(this.baseUrl + "/AuthService/Login"),
			body: json.encode(body),
			headers: headers);

		if (response.statusCode != 200) throw response.body;
		var raw = json.decode(Utf8Decoder().convert(response.bodyBytes));
		final LoginResponse res = LoginResponse.fromJson(raw);
		return res;
	}

	Future<LoginResponse> userLogin(UserLoginRequest body, Map<String, String> headers) async {
		final response = await http.post(
			Uri.parse(this.baseUrl + "/AuthService/UserLogin"),
			body: json.encode(body),
			headers: headers);

		if (response.statusCode != 200) throw response.body;
		var raw = json.decode(Utf8Decoder().convert(response.bodyBytes));
		final LoginResponse res = LoginResponse.fromJson(raw);
		return res;
	}

}
