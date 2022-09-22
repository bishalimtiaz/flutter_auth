import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/auth_feature/email_auth/controllers/email_sign_in_controller.dart';
import 'package:flutter_auth/auth/auth_feature/email_auth/views/sign_up_view.dart';
import 'package:flutter_auth/auth/auth_feature/email_auth/widget/forgot_password_bottomsheet.dart';
import 'package:flutter_auth/auth/builder/email_auth_builder.dart';
import 'package:flutter_auth/auth/constants/auth_colors.dart';
import 'package:flutter_auth/auth/constants/auth_text_style.dart';
import 'package:flutter_auth/auth/constants/auth_values.dart';
import 'package:flutter_auth/auth/constants/enums.dart';
import 'package:flutter_auth/auth/model/page_status.dart';
import 'package:flutter_auth/auth/services/auth_service.dart';
import 'package:flutter_auth/auth/widget/auth_button.dart';
import 'package:flutter_auth/auth/widget/email_text_field.dart';
import 'package:flutter_auth/auth/widget/loader/loader.dart';
import 'package:flutter_auth/auth/widget/password_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmailAuthView extends StatefulWidget {
  const EmailAuthView({Key? key}) : super(key: key);

  @override
  State<EmailAuthView> createState() => _EmailAuthViewState();
}

class _EmailAuthViewState extends State<EmailAuthView> {
  final _formKey = GlobalKey<FormState>();
  final EmailAuthBuilder _builder = AuthService.authBuilder.emailAuthBuilder;
  late final EmailSignInController _controller;

  @override
  void initState() {
    _controller = EmailSignInController();
    _addListeners();

    super.initState();
  }

  @override
  void dispose() {
    _removeListeners();
    _controller.disposeController();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthColors.defaultPageBackground,
      body: SafeArea(child: _pageBody(context)),
    );
  }

  //ignore: long-method
  Widget _pageBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AuthValues.padding_20.w),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EmailTextField(
              emailController: _controller.emailController,
              label: _builder.emailTextFieldLabel,
              hint: _builder.emailTextFieldHint,
              inputStyle: _builder.inputStyle,
              labelStyle: _builder.textFieldLabelTextStyle,
              hintStyle: _builder.textFieldHintTExtStyle,
              emailValidator: _builder.emailValidator,
            ),
            SizedBox(height: AuthValues.margin_16.h),
            PasswordTextField(
              passwordController: _controller.passwordController,
              suffixIconColor: _builder.passwordTexFieldSuffixIconColor,
              labelText: _builder.passwordTextFieldLabel,
              hint: _builder.passwordTextFieldHint,
              inputAction: TextInputAction.send,
              inputStyle: _builder.inputStyle,
              labelStyle: _builder.textFieldLabelTextStyle,
              hintStyle: _builder.textFieldHintTExtStyle,
              passwordValidator: _builder.passwordValidator,
              onComplete: _onEmailLoginButtonTap,
            ),
            SizedBox(height: AuthValues.margin_16.h),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  _openForgotPasswordBottomSheet(context);
                },
                child: Text(
                  _builder.forgotPasswordText,
                  style: _builder.forgotPasswordTextStyle ??
                      forgotPasswordTestStyle,
                ),
              ),
            ),
            SizedBox(height: AuthValues.margin_32.h),
            AuthButton(
              buttonBackgroundColor: _builder.authButtonColor,
              buttonTitle: _builder.loginButtonTitle,
              buttonTitleStyle: _builder.loginButtonTitleStyle,
              onTap: () {
                _onEmailLoginButtonTap();
              },
            ),
            SizedBox(height: AuthValues.margin_16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _builder.doNotHaveAnAccountText,
                  style: _builder.doNotHaveAnAccountTextStyle ?? hintTextStyle,
                ),
                SizedBox(width: AuthValues.margin_8.w),
                GestureDetector(
                  onTap: () {
                    _navigateToSignUpScreen(context);
                  },
                  child: Text(
                    _builder.navigateToSignUpText,
                    style: _builder.navigateToSignUpTextStyle ??
                        emailNavigatorTextStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onEmailLoginButtonTap() {
    if (!_formKey.currentState!.validate()) return;
    _closeKeyboard();
    _controller.loginWithEmailAndPassword();
  }

  void _navigateToSignUpScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpView(),
      ),
    );
  }

  void _addListeners() {
    _controller.pageStatus.addListener(() {
      final PageStatus pageStatus = _controller.pageStatus.value;

      if (pageStatus.pageState == PageState.LOADING) {
        _showLoadingDialog();
      } else if (pageStatus.pageState == PageState.ERROR) {
        _hideLoadingDialog();
        _showErrorMessage(pageStatus.errorMessage);
      } else if (pageStatus.pageState == PageState.DEFAULT) {
        _hideLoadingDialog();
      } else if (pageStatus.pageState == PageState.SUCCESS) {
        _hideLoadingDialog();
        _showSuccessMessage(pageStatus.successMessage);
      }
    });
  }

  void _removeListeners() {
    _controller.pageStatus.removeListener(() {}); // ignore: no-empty-block
  }

  void _hideLoadingDialog() {
    if (_controller.isLoading) Navigator.of(context).pop();
  }

  void _showLoadingDialog() {
    _controller.isLoading = true;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return const LoaderCircle(
          color: Colors.green,
        );
      },
    ).then((_) => _controller.isLoading = false);
  }

  void _showErrorMessage(String message) {
    if (message.isEmpty) return;

    _showToast(true, message);
  }

  _showSuccessMessage(String message) {
    if (message.isEmpty) return;
    _showToast(false, message);
  }

  void _showToast(bool isError, String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isError ? Colors.red : null,
      textColor: isError ? Colors.white : null,
    );
  }

  void _closeKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _openForgotPasswordBottomSheet(BuildContext context) {
    showModalBottomSheet(
      //TODO: Add Animation
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      builder: (BuildContext ctx) {
        return const ForgotPassWordBottomSheet();
      },
    );
  }
}
