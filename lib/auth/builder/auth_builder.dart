import 'package:flutter_auth/auth/builder/logo_builder.dart';
import 'package:flutter_auth/auth/services/email_auth_network_service.dart';
import 'package:flutter_auth/auth/services/phone_auth_network_service.dart';
import 'package:flutter_auth/auth/builder/email_auth_builder.dart';
import 'package:flutter_auth/auth/builder/phone_auth_builder.dart';
import 'package:flutter_auth/auth/constants/enums.dart';

class AuthBuilder {
  final List<AuthOptions> _list = List.empty(growable: true);

  List<AuthOptions> get authOptions => _list;

  late final PhoneAuthBuilder phoneAuthBuilder;
  late final EmailAuthBuilder emailAuthBuilder;
  late final PhoneAuthNetworkService phoneAuthNetworkService;
  late final EmailAuthNetworkService emailAuthNetworkService;
  LogoBuilder? logoBuilder;

  AuthBuilder enablePhoneAuth({
    PhoneAuthBuilder? phoneAuthBuilder,
    required PhoneAuthNetworkService phoneAuthNetworkService,
  }) {
    _list.add(AuthOptions.PHONE);
    this.phoneAuthBuilder = phoneAuthBuilder ?? PhoneAuthBuilder();
    this.phoneAuthNetworkService = phoneAuthNetworkService;

    return this;
  }

  AuthBuilder enableEmailAuth({
    EmailAuthBuilder? emailAuthBuilder,
    required EmailAuthNetworkService emailAuthNetworkService,
  }) {
    _list.add(AuthOptions.EMAIL);
    this.emailAuthBuilder = emailAuthBuilder ?? EmailAuthBuilder();
    this.emailAuthNetworkService = emailAuthNetworkService;

    return this;
  }

  AuthBuilder setLogo({required LogoBuilder logoBuilder}) {
    this.logoBuilder = logoBuilder;
    return this;
  }
}
