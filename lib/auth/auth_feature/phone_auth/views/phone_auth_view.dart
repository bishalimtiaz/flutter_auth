import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/auth_feature/phone_auth/controllers/phone_auth_controller.dart';
import 'package:flutter_auth/auth/auth_feature/phone_auth/wdget/otp_bottom_sheet.dart';
import 'package:flutter_auth/auth/builder/phone_auth_builder.dart';
import 'package:flutter_auth/auth/constants/auth_colors.dart';
import 'package:flutter_auth/auth/constants/auth_text_style.dart';
import 'package:flutter_auth/auth/constants/auth_values.dart';
import 'package:flutter_auth/auth/constants/enums.dart';
import 'package:flutter_auth/auth/model/page_status.dart';
import 'package:flutter_auth/auth/services/auth_service.dart';
import 'package:flutter_auth/auth/widget/auth_button.dart';
import 'package:flutter_auth/auth/widget/loader/loader.dart';
import 'package:flutter_auth/auth/widget/phone_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PhoneAuthView extends StatefulWidget {
  const PhoneAuthView({Key? key}) : super(key: key);

  @override
  State<PhoneAuthView> createState() => _PhoneAuthViewState();
}

class _PhoneAuthViewState extends State<PhoneAuthView> {
  final _formKey = GlobalKey<FormState>();

  final PhoneAuthBuilder _builder = AuthService.authBuilder.phoneAuthBuilder;
  late final PhoneAuthController _controller;

  @override
  void initState() {
    _controller = PhoneAuthController();
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
      body: SafeArea(child: _pageBody()),
    );
  }

  Widget _pageBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AuthValues.padding_20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: PhoneTextField(
              builder: _builder,
              phoneController: _controller.phoneController,
              phoneValidator: _builder.phoneValidator,
              inputStyle: _builder.phoneTextFieldInputStyle,
              onComplete: () {
                _onPhoneLoginButtonTap();
              },
              onPhoneCodeChanged: (code) {
                _controller.updateCountryCode(code);
              },
            ),
          ),
          SizedBox(
            height: AuthValues.margin_16.h,
          ),
          Text(
            _builder.phoneVerificationHint,
            style: _builder.phoneVerificationHintStyle ?? hintTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: AuthValues.margin_32.h,
          ),
          AuthButton(
            buttonBackgroundColor: _builder.authButtonColor,
            buttonTitle: _builder.loginButtonTitle,
            buttonTitleStyle: _builder.loginButtonTitleStyle,
            onTap: () {
              _onPhoneLoginButtonTap();
            },
          ),
        ],
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
        _showOtpBottomSheet(pageStatus.argument);
      }
    });
  }

  void _removeListeners() {
    _controller.pageStatus.removeListener(() {}); // ignore: no-empty-block
  }

  void _onPhoneLoginButtonTap() {
    if (!_formKey.currentState!.validate()) return;
    _closeKeyboard();
    _controller.loginWithNumber();
  }

  void _showOtpBottomSheet(String phoneNumber) {
    showModalBottomSheet(
      //TODO: Add Animation
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      builder: (BuildContext ctx) {
        return OTPBottomSheet(
          resendOtp: () {
            Navigator.pop(ctx);
            _controller.loginWithNumber();
          },
          phoneNumber: phoneNumber,
          onCancel: () {
            Navigator.pop(ctx);
          },
        );
      },
    );
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
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: isError ? Colors.red : null,
      textColor: isError ? Colors.white : null,
    );
  }

  void _closeKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
