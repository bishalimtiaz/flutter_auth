import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/constants/enums.dart';
import 'package:flutter_auth/auth/model/page_status.dart';
import 'package:flutter_auth/auth/services/auth_service.dart';
import 'package:flutter_auth/auth/services/phone_auth_network_service.dart';
import 'package:flutter_auth/auth/utils/auth_utils.dart';

class PhoneAuthController {
  PhoneAuthController() {
    String code = AuthUtils.getInitialPhoneCode(
        AuthService.authBuilder.phoneAuthBuilder.initialCountry);
    updateCountryCode(code);
  }

  String _countryCode = "";
  final TextEditingController phoneController = TextEditingController();

  final ValueNotifier<PageStatus> pageStatus =
      ValueNotifier(PageStatus(pageState: PageState.DEFAULT));

  bool isLoading = false;

  final PhoneAuthNetworkService service =
      AuthService.authBuilder.phoneAuthNetworkService;

  void updateCountryCode(String code) => _countryCode = "+$code";

  //ignore: no-empty-block
  void loginWithNumber() {
    String phoneNumber = "${_countryCode.trim()}${phoneController.text.trim()}";
    _setLoading();

    service.loginWithPhoneNumber(
      phoneNumber: phoneNumber,
      onSuccess: ({required String phoneNumber, String? successMessage}) {
        _setSuccessPhone(argument: phoneNumber, successMessage: successMessage);
      },
      onError: ({required String errorMessage}) {
        _setError(errorMessage);
      },
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

  void _setSuccessPhone({String? successMessage, dynamic argument}) {
    pageStatus.value = PageStatus(
      pageState: PageState.SUCCESS,
      successMessage: successMessage ?? "",
      argument: argument,
    );
  }

  //ignore: no-empty-block
  void verifyOtp(String otp) {}

  void disposeController() {
    phoneController.dispose();
    pageStatus.dispose();
  }
}
