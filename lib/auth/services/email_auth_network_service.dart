import 'package:flutter_auth/auth/model/user_info.dart';

abstract class EmailAuthNetworkService {
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
    required Function({required String accessToken,UserInfo? userInfo,String? successMessage}) onSuccess,
    required Function({required String errorMessage}) onError,
  });

  Future<void> signUpWithEmailAndPassword({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required Function({String? accessToken,UserInfo? userInfo,String? successMessage}) onSuccess,
    required Function({required String errorMessage}) onError,
  });

  Future<void> resetPassword({
    required String oldPassword,
    required String newPassword,
    required Function({String? successMessage}) onSuccess,
    required Function({required String errorMessage}) onError,
  });
}
