import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/constants/auth_values.dart';
import 'package:flutter_auth/auth/constants/auth_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'asset_image_view.dart';

class AuthButton extends StatelessWidget {
  final String? iconPath;
  final String buttonTitle;
  final Color? buttonBackgroundColor;
  final Color? buttonIconColor;
  final TextStyle? buttonTitleStyle;
  final Function()? onTap;

  const AuthButton({
    required this.buttonTitle,
    required this.onTap,
    this.buttonBackgroundColor,
    this.buttonIconColor,
    this.iconPath,
    this.buttonTitleStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AuthValues.padding_16.w,
          vertical: AuthValues.padding_12.h,
        ),
        decoration: BoxDecoration(
          color: buttonBackgroundColor,
          borderRadius: BorderRadius.circular(AuthValues.radius_16.r),
        ),
        child: iconPath != null
            ? _getButtonWithIconAndTitle()
            : _getButtonWithTitle(),
      ),
    );
  }

  Widget _getButtonWithIconAndTitle() {
    return Row(
      children: [
        AssetImageView(
          fileName: iconPath ?? "",
          height: AuthValues.iconDefaultSize.sp,
          width: AuthValues.iconDefaultSize.sp,
          color: buttonIconColor,
        ),
        SizedBox(
          width: AuthValues.margin_16.w,
        ),
        Text(
          buttonTitle,
          style: buttonTitleStyle ?? greyMedium16,
        )
      ],
    );
  }

  Widget _getButtonWithTitle() {
    return Center(
      child: Text(
        buttonTitle,
        style: buttonTitleStyle ?? greyMedium16,
      ),
    );
  }
}
