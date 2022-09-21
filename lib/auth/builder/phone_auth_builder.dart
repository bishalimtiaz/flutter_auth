import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/constants/auth_assets.dart';
import 'package:flutter_auth/auth/constants/auth_colors.dart';
import 'package:flutter_auth/auth/constants/auth_strings.dart';
import 'package:flutter_auth/auth/constants/auth_values.dart';

class PhoneAuthBuilder {
  /// Defines the color of the PhoneAuthButton on Auth Landing View
  Color get authButtonColor => AuthColors.phoneButtonColor;

  /// Defines the path of the icon of PhoneAuthButton
  String get authButtonIconPath => AuthAssets.PHONE_ICON;

  /// Defines the color of the icon of PhoneAuthButton
  Color? get authButtonIconColor => null;

  /// Defines the title of PhoneAuthButton
  String get authButtonTitle => AuthStrings.phoneAuthButtonTitle;

  /// Defines the color of the title of PhoneAuthButton
  TextStyle? get authButtonTitleStyle => null;

  /// Defines the list of country that will be shown to country dropdown list
  List<String> get countryList => [];

  /// Defines the initial selected country of the country dropdown
  String get initialCountry => 'BD';

  /// Defines the label of PhoneTextField
  String get phoneTextFieldLabel => AuthStrings.phoneTextFieldTitle;

  /// Defines the text style of the label of PhoneTextField
  TextStyle? get phoneTextFieldLabelStyle => null;

  /// Defines the input validator of PhoneTextField
  String? phoneValidator(String? phone)  => phone == null || phone.isEmpty ? AuthStrings.phoneValidationErrorMessage : null;


  String get loginButtonTitle => AuthStrings.login;

  TextStyle? get loginButtonTitleStyle => null;

  String get phoneVerificationHint => AuthStrings.phoneVerificationHint;

  TextStyle? get phoneVerificationHintStyle => null;

  TextStyle? get phoneTextFieldInputStyle => null;

  String get otpBottomSheetTitle => AuthStrings.otpBottomSheetTitle;

  TextStyle? get otpBottomSheetTitleStyle => null;

  int get otpDigit => 6;

  String get otpBottomSheetHint => AuthStrings.otpBottomSheetHint;

  TextStyle? get otpBottomSheetHintStyle => null;

  String get otpBoxHint => AuthStrings.otpBoxHint;

  TextStyle? get otpBoxHintStyle => null;

  Color get cancelButtonColor => Colors.redAccent;

  String get cancelButtonTitle => AuthStrings.cancel;

  TextStyle? get cancelButtonTitleStyle => null;

  int get otpResendTimeInSecond => AuthValues.otpResendTimeInSecond;

  String get resendCodeText => AuthStrings.resendCode;


}
