import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/builder/phone_auth_builder.dart';
import 'auth_button.dart';

class PhoneAuthButton extends StatelessWidget {
  final Function()? onTap;
  final PhoneAuthBuilder builder;

  const PhoneAuthButton({
    required this.builder,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      iconPath: builder.authButtonIconPath,
      buttonTitle: builder.authButtonTitle,
      buttonBackgroundColor: builder.authButtonColor,
      buttonIconColor: builder.authButtonIconColor,
      buttonTitleStyle: builder.authButtonTitleStyle,
      onTap: onTap,
    );
  }
}
