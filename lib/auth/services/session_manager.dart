import 'package:flutter/widgets.dart';
import 'package:flutter_auth/auth/model/user_info.dart';
import 'package:flutter_auth/auth/utils/shared_preference_manager.dart';

class SessionManager {
  final ValueNotifier<bool> isLoggedIn = ValueNotifier(false);

  UserInfo _userInfo = UserInfo();

  UserInfo get userInfo => _userInfo;

  String _accessToken = "";

  String get accessToken => _accessToken;

  String _refreshToken = "";

  String get refreshToken => _refreshToken;

  Future<void> logout() async {
    await SharedPreferenceManager.remove(SharedPreferenceManager.ACCESS_TOKEN);

    _accessToken = "";
    isLoggedIn.value = false;
  }

  Future<void> login({required String accessToken}) async {
    await SharedPreferenceManager.setString(
        SharedPreferenceManager.ACCESS_TOKEN, accessToken);
    _accessToken = accessToken;
    isLoggedIn.value = true;
  }

  Future<void> updateUserInfo(UserInfo userInfo) async {
    _userInfo = userInfo;
  }

  Future<void> validateLoginStatus() async {
    final String accessToken = await SharedPreferenceManager.getString(
        SharedPreferenceManager.ACCESS_TOKEN);

    if (accessToken.isEmpty) {
      isLoggedIn.value = false;
    } else {
      _accessToken = accessToken;
      isLoggedIn.value = true;
    }

    final String refreshToken = await SharedPreferenceManager.getString(
        SharedPreferenceManager.REFRESH_TOKEN);
    _refreshToken = refreshToken;
  }

  Future<void> updateAccessToken(String accessToken) async {
    await SharedPreferenceManager.setString(
        SharedPreferenceManager.ACCESS_TOKEN, accessToken);

    _accessToken = accessToken;
  }

  Future<void> updateRefreshToken(String refreshToken) async {
    await SharedPreferenceManager.setString(
        SharedPreferenceManager.REFRESH_TOKEN, refreshToken);
    _refreshToken = refreshToken;
  }
}
