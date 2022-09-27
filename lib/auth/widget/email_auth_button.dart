import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/builder/email_auth_builder.dart';
import 'package:flutter_auth/auth/constants/auth_assets.dart';
import 'auth_button.dart';

class EmailAuthButton extends StatelessWidget {
  final Function()? onTap;
  final EmailAuthBuilder builder;

  EmailAuthButton({
    required this.onTap,
    required this.builder,
    Key? key,
  }) : super(key: key) {
    _validateIconPath();
  }

  late final String? _iconPath;
  late final bool _useDefaultAsset;

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      iconPath: _iconPath,
      useDefaultAsset: _useDefaultAsset,
      buttonTitle: builder.authButtonTitle,
      buttonBackgroundColor: builder.authButtonColor,
      buttonIconColor: builder.authButtonIconColor,
      buttonTitleStyle: builder.authButtonTitleStyle,
      onTap: onTap,
    );
  }

  void _validateIconPath() {
    if (builder.authButtonIconPath == null) {
      _iconPath = null;
      _useDefaultAsset = true;
    } else if (builder.authButtonIconPath!.isEmpty) {
      _iconPath = AuthAssets.EMAIL_ICON;
      _useDefaultAsset = true;
    } else {
      _iconPath = builder.authButtonIconPath;
      _useDefaultAsset = false;
    }
  }
}
