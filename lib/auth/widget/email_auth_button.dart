import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/builder/email_auth_builder.dart';
import 'auth_button.dart';

class EmailAuthButton extends StatelessWidget {
  final Function()? onTap;
  final EmailAuthBuilder builder;

  const EmailAuthButton({
    required this.onTap,
    required this.builder,
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
