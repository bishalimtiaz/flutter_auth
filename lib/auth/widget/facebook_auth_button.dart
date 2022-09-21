import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/constants/auth_colors.dart';
import 'auth_button.dart';

class FacebookAuthButton extends StatelessWidget {
  final Function()? onTap;

  const FacebookAuthButton({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      iconPath: 'facebook_logo.svg',
      buttonTitle: "Continue With Facebook",
      buttonBackgroundColor: AuthColors.facebookButtonColor,
      onTap: onTap,
    );
  }
}
