import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/constants/auth_colors.dart';
import 'package:flutter_auth/auth/constants/auth_strings.dart';
import 'package:flutter_auth/auth/utils/auth_utils.dart';

class EmailAuthBuilder{
  /// Defines the color of the EmailAuthButton on Auth Landing View
  Color get authButtonColor => AuthColors.emailButtonColor;

  /// Defines the path of the icon of EmailAuthButton
  /// If [authButtonIconPath] is empty it uses default icon, if null it doesn't render the icon
  String? get authButtonIconPath => "";

  /// Defines the color of the icon of EmailAuthButton
  Color? get authButtonIconColor => null;

  /// Defines the title of EmailAuthButton
  String get authButtonTitle => AuthStrings.emailAuthButtonTitle;

  /// Defines the color of the title of EmailAuthButton
  TextStyle? get authButtonTitleStyle => null;

  String get loginButtonTitle => AuthStrings.login;

  TextStyle? get loginButtonTitleStyle => null;

  String get signUpButtonTitle => AuthStrings.signUp;

  TextStyle? get signUpButtonTitleStyle => null;

  Color get passwordTexFieldSuffixIconColor => AuthColors.emailButtonColor;

  String get emailTextFieldLabel => AuthStrings.email;

  String? get emailTextFieldHint => AuthStrings.emailHint;

  String get passwordTextFieldLabel => AuthStrings.password;

  String? get passwordTextFieldHint => null;

  String get confirmPasswordTextFieldLabel => AuthStrings.confirmPassword;

  String? get confirmPasswordTextFieldHint => null;

  String get forgotPasswordText => AuthStrings.forgotPassword;

  TextStyle? get forgotPasswordTextStyle => null;

  String get doNotHaveAnAccountText => AuthStrings.doNotHaveAnAccountText;

  TextStyle? get doNotHaveAnAccountTextStyle => null;

  String get navigateToSignUpText => AuthStrings.navigateToSignUpText;

  TextStyle? get navigateToSignUpTextStyle => null;

  String get firstNameTextFieldLabel => AuthStrings.firstNameTextFieldLabel;

  String? get firstNameTextFieldHint => AuthStrings.firstNameTextFieldHint;

  String get lastNameTextFieldLabel => AuthStrings.lastNameTextFieldLabel;

  String? get lastNameTextFieldHint => AuthStrings.lastNameTextFieldHint;

  String get alreadyHaveAnAccountText => AuthStrings.alreadyHaveAnAccountText;

  TextStyle? get alreadyHaveAnAccountTextStyle => null;

  String get navigateToLoginText => AuthStrings.login;

  TextStyle? get navigateToLoginTextStyle => null;

  TextStyle? get inputStyle => null;

  TextStyle? get textFieldLabelTextStyle => null;

  TextStyle? get textFieldHintTExtStyle => null;

  String get oldPasswordTextFieldLabel => AuthStrings.oldPassword;

  String? get oldPasswordTextFieldHint => null;

  String get newPasswordTextFieldLabel => AuthStrings.newPassword;
  String? get newPasswordTextFieldHint => null;

  String get confirmNewPasswordTextFieldLabel => AuthStrings.confirmNewPassword;

  String? get confirmNewPasswordTextFieldHint => null;

  String get forgotPasswordBottomSheetTitle => AuthStrings.forgotPasswordBottomSheetTitle;

  TextStyle? get forgotPasswordBottomSheetTitleStyle => null;

  String get submitButtonTitle => AuthStrings.submit;

  Color get cancelButtonColor => Colors.redAccent;

  String get cancelButtonTitle => AuthStrings.cancel;

  TextStyle? get cancelButtonTitleStyle => null;


  /// Defines the input validator of EmailTextField
  String? emailValidator(String? email)  => email == null || !AuthUtils.isEmail(email) ? AuthStrings.emailValidationErrorMessage : null;

  String? passwordValidator(String? password)  => password == null || !AuthUtils.isValidPassword(password) ? AuthStrings.passwordValidationErrorMessage : null;

  String? firstNameValidator(String? userName)  => userName == null || userName.length < 3 ? AuthStrings.userNameValidationErrorMessage : null;
  String? lastNameValidator(String? userName)  => userName == null || userName.length < 3 ? AuthStrings.userNameValidationErrorMessage : null;

  String? get confirmPasswordValidationErrorMessage => AuthStrings.confirmPasswordValidationErrorMessage;





}