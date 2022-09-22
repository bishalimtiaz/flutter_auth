import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/auth_feature/email_auth/controllers/forgot_password_controller.dart';
import 'package:flutter_auth/auth/builder/email_auth_builder.dart';
import 'package:flutter_auth/auth/constants/auth_text_style.dart';
import 'package:flutter_auth/auth/constants/auth_values.dart';
import 'package:flutter_auth/auth/constants/enums.dart';
import 'package:flutter_auth/auth/model/page_status.dart';
import 'package:flutter_auth/auth/services/auth_service.dart';
import 'package:flutter_auth/auth/widget/auth_button.dart';
import 'package:flutter_auth/auth/widget/loader/loader.dart';
import 'package:flutter_auth/auth/widget/password_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPassWordBottomSheet extends StatefulWidget {
  const ForgotPassWordBottomSheet({Key? key}) : super(key: key);

  @override
  State<ForgotPassWordBottomSheet> createState() =>
      _ForgotPassWordBottomSheetState();
}

class _ForgotPassWordBottomSheetState extends State<ForgotPassWordBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final EmailAuthBuilder _builder = AuthService.authBuilder.emailAuthBuilder;

  late final ForgotPasswordController _controller;

  @override
  void initState() {
    _controller = ForgotPasswordController();
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
    return SafeArea(
      minimum: EdgeInsets.only(top: AuthValues.margin_20.h),
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AuthValues.margin_20.w,
            vertical: AuthValues.margin_20.h,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _builder.forgotPasswordBottomSheetTitle,
                  style: _builder.forgotPasswordBottomSheetTitleStyle ??
                      defaultBoldTextStyle,
                ),
                SizedBox(height: AuthValues.margin_20.h),
                PasswordTextField(
                  passwordController: _controller.oldPasswordController,
                  suffixIconColor: _builder.passwordTexFieldSuffixIconColor,
                  labelText: _builder.oldPasswordTextFieldLabel,
                  hint: _builder.oldPasswordTextFieldHint,
                  inputAction: TextInputAction.next,
                  inputStyle: _builder.inputStyle,
                  labelStyle: _builder.textFieldLabelTextStyle,
                  hintStyle: _builder.textFieldHintTExtStyle,
                ),
                SizedBox(height: AuthValues.margin_16.h),
                PasswordTextField(
                  passwordController: _controller.newPasswordController,
                  suffixIconColor: _builder.passwordTexFieldSuffixIconColor,
                  labelText: _builder.newPasswordTextFieldLabel,
                  hint: _builder.newPasswordTextFieldHint,
                  inputAction: TextInputAction.next,
                  inputStyle: _builder.inputStyle,
                  labelStyle: _builder.textFieldLabelTextStyle,
                  hintStyle: _builder.textFieldHintTExtStyle,
                  passwordValidator: _builder.passwordValidator,
                ),
                SizedBox(height: AuthValues.margin_16.h),
                PasswordTextField(
                  passwordController: _controller.confirmNewPasswordController,
                  suffixIconColor: _builder.passwordTexFieldSuffixIconColor,
                  labelText: _builder.confirmNewPasswordTextFieldLabel,
                  hint: _builder.confirmNewPasswordTextFieldHint,
                  inputAction: TextInputAction.send,
                  inputStyle: _builder.inputStyle,
                  labelStyle: _builder.textFieldLabelTextStyle,
                  hintStyle: _builder.textFieldHintTExtStyle,
                  passwordValidator: _controller.confirmPasswordValidator,
                ),
                SizedBox(height: AuthValues.margin_32.h),
                Row(
                  children: [
                    Expanded(
                      child: AuthButton(
                        buttonBackgroundColor: _builder.cancelButtonColor,
                        buttonTitle: _builder.cancelButtonTitle,
                        buttonTitleStyle: _builder.cancelButtonTitleStyle,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    SizedBox(width: AuthValues.margin_16.w),
                    Expanded(
                      child: AuthButton(
                        buttonBackgroundColor: _builder.authButtonColor,
                        buttonTitle: _builder.submitButtonTitle,
                        buttonTitleStyle: _builder.signUpButtonTitleStyle,
                        onTap: _onSubmitButtonTap,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmitButtonTap() {
    if (!_formKey.currentState!.validate()) return;
    _closeKeyboard();
    _controller.resetPassword();
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
        Navigator.of(context).pop();
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
}
