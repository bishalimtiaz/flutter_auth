import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/constants/auth_strings.dart';
import 'package:flutter_auth/auth/constants/enums.dart';
import 'package:flutter_auth/auth/model/page_status.dart';
import 'package:flutter_auth/auth/model/user_info.dart';
import 'package:flutter_auth/auth/services/auth_service.dart';
import 'package:flutter_auth/auth/services/email_auth_network_service.dart';

class EmailSignUpController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final ValueNotifier<PageStatus> pageStatus =
      ValueNotifier(PageStatus(pageState: PageState.DEFAULT));
  bool isLoading = false;

  final EmailAuthNetworkService service =
      AuthService.authBuilder.emailAuthNetworkService;

  String? confirmPasswordValidator(String? pass) {
    return pass == null ||
            passwordController.text.trim() !=
                confirmPasswordController.text.trim()
        ? AuthService.authBuilder.emailAuthBuilder
                .confirmPasswordValidationErrorMessage ??
            AuthStrings.confirmPasswordValidationErrorMessage
        : null;
  }

  void signUpWithEmailAndPassWord() {
    _setLoading();
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController. text.trim();
    String email = emailController.text.trim();
    String password = confirmPasswordController.text.trim();

    service.signUpWithEmailAndPassword(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      onSuccess: ({
        String? accessToken,
        String? successMessage,
        UserInfo? userInfo,
      }) {
        _setSuccessSignUp(accessToken: accessToken,userInfo: userInfo,successMessage: successMessage);
      },
      onError: ({required String errorMessage}) {
        _setError(errorMessage);
      },
    );
  }

  void _setSuccessSignUp({
    String? successMessage,
    UserInfo? userInfo,
    String? accessToken,
  }) {
    if (userInfo != null) {
      AuthService.sessionManager.updateUserInfo(userInfo);
    }

    pageStatus.value = PageStatus(
      pageState: PageState.SUCCESS,
      successMessage: successMessage ?? "",
      argument: accessToken == null
    );

    if(accessToken != null) {
      AuthService.sessionManager.login(accessToken: accessToken);
    }
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
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
