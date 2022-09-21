import 'package:country_pickers/countries.dart';

class AuthUtils {
  AuthUtils._();

  static String getInitialPhoneCode(String countryCode) {
    return countryList
        .where((element) => element.isoCode == countryCode)
        .single.phoneCode;
  }

  /// Checks if string is email.
  static bool isEmail(String s) => hasMatch(s,
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  static bool isValidPassword(String s){

    String pattern = r'^(?=.*?[A-Z])' // should contain at least one upper case
        r'(?=.*?[a-z])' // should contain at least one lower case
        r'(?=.*?[0-9])' // should contain at least one digit
        r'(?=.*?[!@#\$&*~])' // should contain at least one Special character
        r'.{8,}$'; //Must be at least 8 characters in length

    return hasMatch(s, pattern);
  }
}
