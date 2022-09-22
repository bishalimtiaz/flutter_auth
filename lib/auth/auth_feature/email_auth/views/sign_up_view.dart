import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/auth/auth_feature/email_auth/controllers/email_sign_up_controller.dart';
import 'package:flutter_auth/auth/builder/email_auth_builder.dart';
import 'package:flutter_auth/auth/constants/auth_colors.dart';
import 'package:flutter_auth/auth/constants/auth_text_style.dart';
import 'package:flutter_auth/auth/constants/auth_values.dart';
import 'package:flutter_auth/auth/constants/enums.dart';
import 'package:flutter_auth/auth/model/page_status.dart';
import 'package:flutter_auth/auth/services/auth_service.dart';
import 'package:flutter_auth/auth/widget/auth_button.dart';
import 'package:flutter_auth/auth/widget/email_text_field.dart';
import 'package:flutter_auth/auth/widget/last_name_text_field.dart';
import 'package:flutter_auth/auth/widget/loader/loader.dart';
import 'package:flutter_auth/auth/widget/password_text_field.dart';
import 'package:flutter_auth/auth/widget/first_name_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final EmailAuthBuilder _builder = AuthService.authBuilder.emailAuthBuilder;
  late final EmailSignUpController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller = EmailSignUpController();
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
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(),
      child: Scaffold(
        backgroundColor: AuthColors.defaultPageBackground,
        body: SafeArea(child: _pageBody(context)),
      ),
    );
  }

  //ignore: long-method
  Widget _pageBody(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AuthValues.padding_20.w,
          vertical: AuthValues.padding_20.h,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FirstNameTextField(
                firstNameController: _controller.firstNameController,
                label: _builder.firstNameTextFieldLabel,
                hint: _builder.firstNameTextFieldHint,
                inputStyle: _builder.inputStyle,
                labelStyle: _builder.textFieldLabelTextStyle,
                hintStyle: _builder.textFieldHintTExtStyle,
                firstNameValidator: _builder.firstNameValidator,
              ),
              SizedBox(height: AuthValues.margin_16.h),
              LastNameTextField(
                lastNameController: _controller.lastNameController,
                label: _builder.lastNameTextFieldLabel,
                hint: _builder.lastNameTextFieldHint,
                inputStyle: _builder.inputStyle,
                labelStyle: _builder.textFieldLabelTextStyle,
                hintStyle: _builder.textFieldHintTExtStyle,
                lastNameValidator: _builder.lastNameValidator,
              ),
              SizedBox(height: AuthValues.margin_16.h),
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
                inputAction: TextInputAction.next,
                inputStyle: _builder.inputStyle,
                labelStyle: _builder.textFieldLabelTextStyle,
                hintStyle: _builder.textFieldHintTExtStyle,
                passwordValidator: _builder.passwordValidator,
              ),
              SizedBox(height: AuthValues.margin_16.h),
              PasswordTextField(
                passwordController: _controller.confirmPasswordController,
                suffixIconColor: _builder.passwordTexFieldSuffixIconColor,
                labelText: _builder.confirmPasswordTextFieldLabel,
                hint: _builder.confirmPasswordTextFieldHint,
                inputAction: TextInputAction.send,
                inputStyle: _builder.inputStyle,
                labelStyle: _builder.textFieldLabelTextStyle,
                hintStyle: _builder.textFieldHintTExtStyle,
                passwordValidator: _controller.confirmPasswordValidator,
                onComplete: _onSignUpButtonTap,
              ),
              SizedBox(height: AuthValues.margin_32.h),
              AuthButton(
                buttonBackgroundColor: _builder.authButtonColor,
                buttonTitle: _builder.signUpButtonTitle,
                buttonTitleStyle: _builder.signUpButtonTitleStyle,
                onTap: _onSignUpButtonTap,
              ),
              SizedBox(height: AuthValues.margin_16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _builder.alreadyHaveAnAccountText,
                    style:
                        _builder.alreadyHaveAnAccountTextStyle ?? hintTextStyle,
                  ),
                  SizedBox(width: AuthValues.margin_8.w),
                  GestureDetector(
                    onTap: () {
                      _navigateToLogonScreen(context);
                    },
                    child: Text(
                      _builder.navigateToLoginText,
                      style: _builder.navigateToLoginTextStyle ??
                          emailNavigatorTextStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
        if (pageStatus.argument) {
          Navigator.of(context).pop();
        }
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

  void _onSignUpButtonTap() {
    if (!_formKey.currentState!.validate()) return;
    _closeKeyboard();
    _controller.signUpWithEmailAndPassWord();
  }

  void _navigateToLogonScreen(BuildContext context) {
    Navigator.of(context).pop();
  }
}
