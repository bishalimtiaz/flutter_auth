import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/constants/auth_strings.dart';
import 'package:flutter_auth/auth/constants/enums.dart';
import 'package:flutter_auth/auth/model/page_status.dart';
import 'package:flutter_auth/auth/services/auth_service.dart';
import 'package:flutter_auth/auth/services/email_auth_network_service.dart';

class ForgotPasswordController {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  final ValueNotifier<PageStatus> pageStatus =
      ValueNotifier(PageStatus(pageState: PageState.DEFAULT));
  bool isLoading = false;

  final EmailAuthNetworkService service =
      AuthService.authBuilder.emailAuthNetworkService;

  String? confirmPasswordValidator(String? pass) {
    return pass == null ||
            newPasswordController.text.trim() !=
                confirmNewPasswordController.text.trim()
        ? AuthService.authBuilder.emailAuthBuilder
                .confirmPasswordValidationErrorMessage ??
            AuthStrings.confirmPasswordValidationErrorMessage
        : null;
  }

  void disposeController() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
  }

  void resetPassword() {
    _setLoading();
    String oldPassword = oldPasswordController.text.trim();
    String newPassword = confirmNewPasswordController.text.trim();

    service.resetPassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
      onSuccess: ({String? successMessage}){
        _setSuccessReset(successMessage: successMessage);
      },
      onError: ({required String errorMessage}){
        _setError(errorMessage);
      },
    );
  }

  void _setSuccessReset({
    String? successMessage,
  }) {
    pageStatus.value = PageStatus(
      pageState: PageState.SUCCESS,
      successMessage: successMessage ?? "",
    );
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
}
