import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/constants/auth_colors.dart';
import 'auth_button.dart';

class GoogleAuthButton extends StatelessWidget {
  final Function()? onTap;

  const GoogleAuthButton({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      iconPath: 'google_logo.svg',
      buttonTitle: "Continue With Google",
      buttonBackgroundColor: AuthColors.googleButtonColor,
      onTap: onTap,
    );
  }
}
