import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/constants/auth_text_style.dart';
import 'package:flutter_auth/auth/widget/Input_text_field.dart';

class EmailTextField extends StatelessWidget {
  final String? Function(String?)? emailValidator;
  final TextEditingController? emailController;
  final Function()? onComplete;
  final String label;
  final String? hint;
  final TextStyle? inputStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;

  const EmailTextField({
    required this.label,
    this.hint,
    this.emailController,
    this.emailValidator,
    this.onComplete,
    this.inputStyle,
    this.labelStyle,
    this.hintStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputTextField(
      controller: emailController,
      validator: emailValidator,
      textInputType: TextInputType.emailAddress,
      inputBorder: const OutlineInputBorder(),
      labelText: label,
      labelStyle: labelStyle ?? textFieldLabelTextStyle,
      hintText: hint,
      hintStyle: hintStyle ?? textFieldHintTextStyle,
      maxLines: 1,
      style: inputStyle ?? inputTextStyle,
      inputAction: TextInputAction.next,
      onComplete: onComplete,
      //autoFocus: false,
    );
  }
}
