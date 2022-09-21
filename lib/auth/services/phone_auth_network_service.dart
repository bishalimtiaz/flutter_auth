import 'package:flutter_auth/auth/model/user_info.dart';

abstract class PhoneAuthNetworkService {
  Future<void> loginWithPhoneNumber({
    required String phoneNumber,
    required Function({
      required String phoneNumber,
      String? successMessage,
    })
        onSuccess,
    required Function({
      required String errorMessage,
    })
        onError,
  });

Future<void> verifyOtp({
  required String otp,
  required Function({required String accessToken,UserInfo? userInfo,String? successMessage}) onSuccess,
  required Function({required String errorMessage}) onError,
});
}
