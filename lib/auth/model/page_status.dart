import 'package:flutter_auth/auth/constants/enums.dart';

class PageStatus {
  final PageState pageState;
  final String errorMessage;
  final String successMessage;
  dynamic argument;

  PageStatus({
    required this.pageState,
    this.errorMessage = "",
    this.successMessage = "",
    this.argument,
  });
}
