import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/builder/phone_auth_builder.dart';
import 'package:flutter_auth/auth/constants/auth_assets.dart';
import 'auth_button.dart';

class PhoneAuthButton extends StatelessWidget {
  final Function()? onTap;
  final PhoneAuthBuilder builder;

  PhoneAuthButton({
    required this.builder,
    required this.onTap,
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
      _iconPath = AuthAssets.PHONE_ICON;
      _useDefaultAsset = true;
    } else {
      _iconPath = builder.authButtonIconPath;
      _useDefaultAsset = false;
    }
  }
}
