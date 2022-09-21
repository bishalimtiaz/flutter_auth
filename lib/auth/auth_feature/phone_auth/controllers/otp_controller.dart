import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/constants/enums.dart';
import 'package:flutter_auth/auth/model/page_status.dart';
import 'package:flutter_auth/auth/model/user_info.dart';
import 'package:flutter_auth/auth/services/auth_service.dart';
import 'package:flutter_auth/auth/services/phone_auth_network_service.dart';

class OtpController {
  final PhoneAuthNetworkService _service =
      AuthService.authBuilder.phoneAuthNetworkService;
  final TextEditingController textEditingController = TextEditingController();
  final ValueNotifier<String> timerText = ValueNotifier("");
  late Timer _timer;
  final _oneSec = const Duration(seconds: 1);
  final int _oneMinuteInSec = 60;

  final ValueNotifier<bool> isTimerRunning = ValueNotifier(false);

  bool isLoading = false;

  final ValueNotifier<PageStatus> pageStatus =
      ValueNotifier(PageStatus(pageState: PageState.DEFAULT));

  void verifyOtp(String otp) {
    _setLoading();
    _service.verifyOtp(
      otp: otp,
      onError: ({required String errorMessage}) {
        _setError(errorMessage);
      },
      onSuccess: ({
        required String accessToken,
        String? successMessage,
        UserInfo? userInfo,
      }) {
        _setSuccessLogin(
            accessToken: accessToken,
            successMessage: successMessage,
            userInfo: userInfo);
      },
    );
  }

  void _setLoading() {
    pageStatus.value = PageStatus(pageState: PageState.LOADING);
  }

  //ignor
  void _resetPageStatus() {
    pageStatus.value = PageStatus(pageState: PageState.DEFAULT);
  }

  void _setSuccessLogin(
      {String? successMessage,
      UserInfo? userInfo,
      required String accessToken}) {
    if (userInfo != null) {
      AuthService.sessionManager.updateUserInfo(userInfo);
    }

    pageStatus.value = PageStatus(
      pageState: PageState.SUCCESS,
      successMessage: successMessage ?? "",
    );
    AuthService.sessionManager.login(accessToken: accessToken);
  }

  void _setError(String errorMessage) {
    pageStatus.value =
        PageStatus(pageState: PageState.ERROR, errorMessage: errorMessage);
    textEditingController.clear();
  }

  void startTimer(int time) {
    isTimerRunning.value = true;
    _timer = Timer.periodic(_oneSec, (timer) {
      if (time == 0) {
        resetTimer();
      } else {
        time--;
        _setTimerText(time);
      }
    });
  }

  void resetTimer() {
    if (_timer.isActive) _timer.cancel();
    timerText.value = "";
    isTimerRunning.value = false;
  }

  void _setTimerText(int time) {
    if (time < _oneMinuteInSec) {
      timerText.value = "$time s";
    } else {
      int minute = (time / _oneMinuteInSec) as int;
      int second = time % _oneMinuteInSec;
      timerText.value = "$minute m $second s";
    }
  }

  void disposeController() {
    resetTimer();
    timerText.dispose();
    pageStatus.dispose();
  }
}
