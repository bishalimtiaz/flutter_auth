import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/constants/auth_colors.dart';
import 'package:flutter_auth/auth/constants/auth_text_style.dart';
import 'package:flutter_auth/auth/constants/auth_values.dart';
import 'package:flutter_auth/auth/widget/Input_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneNumberInput extends StatelessWidget {
  final String label;
  final Widget countryPickerDropdown;
  final InputTextField inputTextField;
  final TextStyle? phoneTextFieldLabelStyle;

  const PhoneNumberInput({
    required this.label,
    required this.countryPickerDropdown,
    required this.inputTextField,
    this.phoneTextFieldLabelStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getLabel(),
        SizedBox(height: AuthValues.margin_8.h),
        _getPhoneNumberField(),
      ],
    );
  }

  Widget _getLabel() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AuthValues.margin_20.w,
      ),
      child: Text(
        label,
        style: phoneTextFieldLabelStyle ?? defaultBoldTextStyle,
      ),
    );
  }

  Widget _getPhoneNumberField() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AuthValues.margin_20.w,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: AuthColors.accentViolet,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          countryPickerDropdown,
          SizedBox(width: AuthValues.margin_6.w),
          Expanded(child: inputTextField),
        ],
      ),
    );
  }
}
