import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/auth_feature/email_auth/views/email_auth_view.dart';
import 'package:flutter_auth/auth/auth_feature/phone_auth/views/phone_auth_view.dart';
import 'package:flutter_auth/auth/builder/logo_builder.dart';
import 'package:flutter_auth/auth/constants/auth_values.dart';
import 'package:flutter_auth/auth/constants/enums.dart';
import 'package:flutter_auth/auth/services/auth_service.dart';
import 'package:flutter_auth/auth/widget/asset_image_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'email_auth_button.dart';
import 'facebook_auth_button.dart';
import 'google_auth_button.dart';
import 'phone_auth_button.dart';

class AuthUI extends StatelessWidget {
  const AuthUI({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
          AuthValues.defaultLayoutWidth, AuthValues.defaultLayoutHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) => _pageBody(context),
    );
  }

  Widget _pageBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AuthValues.padding_20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (AuthService.authBuilder.logoBuilder != null)
            _getLogo(AuthService.authBuilder.logoBuilder!),
          _getAuthButtons(context)
        ],
      ),
    );
  }

  Widget _buildAuthUI(AuthOptions options, BuildContext context) {
    switch (options) {
      case AuthOptions.EMAIL:
        return EmailAuthButton(
          builder: AuthService.authBuilder.emailAuthBuilder,
          onTap: () {
            _onTapEmailButton(context);
          },
        );
      case AuthOptions.PHONE:
        return PhoneAuthButton(
          builder: AuthService.authBuilder.phoneAuthBuilder,
          onTap: () {
            _onTapPhoneButton(context);
          },
        );
      case AuthOptions.GOOGLE:
        return GoogleAuthButton(onTap: _onTapGoogleButton);
      case AuthOptions.FACEBOOK:
        return FacebookAuthButton(onTap: _onTapFacebookButton);
      default:
        return EmailAuthButton(
          builder: AuthService.authBuilder.emailAuthBuilder,
          onTap: () {
            _onTapEmailButton(context);
          },
        );
    }
  }

  Widget _getLogo(LogoBuilder logoBuilder) {
    return Container(
      margin: EdgeInsets.only(bottom: AuthValues.margin_60.h),
      child: AssetImageView(
        isDefault: false,
        assetPath: logoBuilder.logoPath,
        height: logoBuilder.logoHeight,
        width: logoBuilder.logoWidth,
        fit: logoBuilder.fit,
      ),
    );
  }

  Widget _getAuthButtons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0;
            i < AuthService.authBuilder.authOptions.length;
            i++) ...[
          _buildAuthUI(AuthService.authBuilder.authOptions[i], context),
          if (i != AuthService.authBuilder.authOptions.length - 1)
            SizedBox(height: AuthValues.margin_16.h),
        ],
      ],
    );
  }

  //ignore: no-empty-block
  void _onTapPhoneButton(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PhoneAuthView(),
      ),
    );
  }

  //ignore: no-empty-block
  void _onTapEmailButton(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const EmailAuthView(),
      ),
    );
  }

  //ignore: no-empty-block
  void _onTapGoogleButton() {}

  //ignore: no-empty-block
  void _onTapFacebookButton() {}
}
