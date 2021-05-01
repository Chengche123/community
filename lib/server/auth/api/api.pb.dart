class UserLoginRequest {
  String userName;
  String password;

  UserLoginRequest({this.userName, this.password});

  UserLoginRequest.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['password'] = this.password;
    return data;
  }
}

class LoginResponse {
  String accessToken;
  int expiresIn;

  LoginResponse({this.accessToken, this.expiresIn});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['expires_in'] = this.expiresIn;
    return data;
  }
}

class LoginRequest {
  String coed;

  LoginRequest({this.coed});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    coed = json['coed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coed'] = this.coed;
    return data;
  }
}
