import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/constants/auth_colors.dart';
import 'package:flutter_auth/auth/constants/auth_values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final greyMedium16 = TextStyle(
  fontSize: AuthValues.fontSize_16.sp,
  color: AuthColors.greyColor,
  fontWeight: FontWeight.w400,
);

final TextStyle inputTextStyle = TextStyle(
  color: AuthColors.defaultTextColor,
  fontSize: AuthValues.fontSize_16.sp,
  fontWeight: FontWeight.w400,
);

final TextStyle defaultBoldTextStyle = TextStyle(
  fontSize: AuthValues.fontSize_16.sp,
  fontWeight: FontWeight.w700,
  color: AuthColors.defaultTextColor,
);

final TextStyle hintTextStyle = TextStyle(
  color: AuthColors.textColorHint,
  fontSize: AuthValues.fontSize_14.sp,
  fontWeight: FontWeight.w400,
);

final TextStyle countryPickerTextStyle =
    hintTextStyle.copyWith(fontSize: AuthValues.fontSize_16.sp);

final resendCodeTextStyle =
    hintTextStyle.copyWith(color: AuthColors.defaultTextColor);

final TextStyle forgotPasswordTestStyle =
    greyMedium16.copyWith(color: AuthColors.emailButtonColor);

final TextStyle emailNavigatorTextStyle =
    hintTextStyle.copyWith(color: AuthColors.emailButtonColor);

final TextStyle textFieldLabelTextStyle =
    inputTextStyle.copyWith(color: AuthColors.emailButtonColor);

final TextStyle textFieldHintTextStyle =
    inputTextStyle.copyWith(color: AuthColors.textColorHint);
