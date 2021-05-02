import 'package:flutter_comic/store/ccache.dart';

const tokenKey = "user.token";

void setToken(String token) {
  CCache.aCCache.setCookie(tokenKey, token);
}

String getToken() {
  return CCache.aCCache.getCookie(tokenKey);
}
