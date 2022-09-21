import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/constants/enums.dart';
import 'package:flutter_auth/auth/model/page_status.dart';
import 'package:flutter_auth/auth/model/user_info.dart';
import 'package:flutter_auth/auth/services/auth_service.dart';
import 'package:flutter_auth/auth/services/email_auth_network_service.dart';

class EmailSignInController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ValueNotifier<PageStatus> pageStatus =
      ValueNotifier(PageStatus(pageState: PageState.DEFAULT));
  bool isLoading = false;

  final EmailAuthNetworkService service =
      AuthService.authBuilder.emailAuthNetworkService;

  void loginWithEmailAndPassword() {
    _setLoading();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    service.loginWithEmailAndPassword(
      email: email,
      password: password,
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
      onError: ({required String errorMessage}) {
        _setError(errorMessage);
      },
    );
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

  void _setLoading() {
    pageStatus.value = PageStatus(pageState: PageState.LOADING);
  }

  void _resetPageStatus() {
    pageStatus.value = PageStatus(pageState: PageState.DEFAULT);
  }

  void _setError(String errorMessage) {
    pageStatus.value =
        PageStatus(pageState: PageState.ERROR, errorMessage: errorMessage);
  }

  void disposeController() {
    pageStatus.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
