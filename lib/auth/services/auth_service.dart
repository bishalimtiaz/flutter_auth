import 'package:flutter_auth/auth/builder/auth_builder.dart';
import 'package:flutter_auth/auth/services/session_manager.dart';

class AuthService {
  AuthService._();

  static final AuthBuilder authBuilder = AuthBuilder();

  static late final SessionManager sessionManager;

  static Future<void> startService() async{
    sessionManager = SessionManager();
    await sessionManager.validateLoginStatus();
  }

// static AuthBuilder enableFacebookAuth() {
//   return _authBuilder.enableFacebookAuth();
// }
//
// static AuthBuilder enableGoogleAuth() {
//   return _authBuilder.enableGoogleAuth();
// }
//
// static AuthBuilder enablePhoneAuth() {
//   return _authBuilder.enablePhoneAuth();
// }
//
// static AuthBuilder enableEmailAuth() {
//   return _authBuilder.enableEmailAuth();
// }
}
