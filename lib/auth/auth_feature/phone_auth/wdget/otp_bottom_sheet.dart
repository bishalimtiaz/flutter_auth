import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/auth_feature/phone_auth/controllers/otp_controller.dart';
import 'package:flutter_auth/auth/builder/phone_auth_builder.dart';
import 'package:flutter_auth/auth/constants/auth_colors.dart';
import 'package:flutter_auth/auth/constants/auth_text_style.dart';
import 'package:flutter_auth/auth/constants/auth_values.dart';
import 'package:flutter_auth/auth/constants/enums.dart';
import 'package:flutter_auth/auth/model/page_status.dart';
import 'package:flutter_auth/auth/services/auth_service.dart';
import 'package:flutter_auth/auth/widget/auth_button.dart';
import 'package:flutter_auth/auth/widget/loader/loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPBottomSheet extends StatefulWidget {
  final Function() onCancel;
  final Function() resendOtp;
  final String phoneNumber;

  const OTPBottomSheet({
    required this.onCancel,
    required this.phoneNumber,
    required this.resendOtp,
    Key? key,
  }) : super(key: key);

  @override
  State<OTPBottomSheet> createState() => _OTPBottomSheetState();
}

class _OTPBottomSheetState extends State<OTPBottomSheet> {
  final PhoneAuthBuilder _builder = AuthService.authBuilder.phoneAuthBuilder;
  late final OtpController _controller;

  @override
  void initState() {
    _controller = OtpController();
    _addListeners();
    _controller.startTimer(_builder.otpResendTimeInSecond);
    super.initState();
  }

  @override
  void dispose() {
    _controller.disposeController();
    _removeListeners();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AuthValues.margin_20.w,
          vertical: AuthValues.margin_20.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _builder.otpBottomSheetTitle,
              style: _builder.otpBottomSheetTitleStyle ?? defaultBoldTextStyle,
            ),
            SizedBox(height: AuthValues.margin_20.h),
            Text(
              "${_builder.otpBottomSheetHint} ${widget.phoneNumber}",
              style: _builder.otpBottomSheetHintStyle ?? hintTextStyle,
            ),
            SizedBox(height: AuthValues.margin_20.h),
            _getOTPBoxes(context),
            Text(
              _builder.otpBoxHint,
              style: _builder.otpBoxHintStyle ?? hintTextStyle,
            ),
            SizedBox(height: AuthValues.margin_32.h),
            _getTimerText(),
            SizedBox(height: AuthValues.margin_32.h),
            AuthButton(
              buttonBackgroundColor: _builder.cancelButtonColor,
              buttonTitle: _builder.cancelButtonTitle,
              buttonTitleStyle: _builder.cancelButtonTitleStyle,
              onTap: widget.onCancel,
            ),
            // const SizedBox(
            //   height: AuthValues.margin_20,
            // ),
          ],
        ),
      ),
    );
  }

  Widget _getOTPBoxes(BuildContext context) {
    return PinCodeTextField(
        controller: _controller.textEditingController,
        appContext: context,
        length: _builder.otpDigit,
        autoFocus: true,
        autoDisposeControllers: true,
        pinTheme: PinTheme(
          inactiveColor: Colors.redAccent,

          activeColor: Colors.grey,
          selectedColor: AuthColors.phoneButtonColor,
          // selectedFillColor: AppColors.otpBoxColor,
        ),
        onChanged: (String value) {},
        onCompleted: (value) {
          _closeKeyboard();
          _controller.verifyOtp(value);
        });
  }

  Widget _getTimerText() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder(
            valueListenable: _controller.isTimerRunning,
            builder: (BuildContext context, bool isTimerRunning, _) {
              return InkWell(
                onTap: isTimerRunning ? null : widget.resendOtp,
                child: Text(
                  _builder.resendCodeText,
                  style: isTimerRunning ? hintTextStyle : resendCodeTextStyle,
                ),
              );
            }),
        SizedBox(
          width: AuthValues.margin_8.w,
        ),
        ValueListenableBuilder(
          valueListenable: _controller.timerText,
          builder: (BuildContext context, String timerText, _) {
            return Text(
              timerText,
              style: resendCodeTextStyle,
            );
          },
        )
      ],
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

  _showErrorMessage(String message) {
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
