import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/constants/auth_text_style.dart';
import 'package:flutter_auth/auth/widget/Input_text_field.dart';

class UserNameTextField extends StatelessWidget {
  final String? Function(String?)? userNameValidator;
  final TextEditingController? userNameController;
  final Function()? onComplete;
  final String label;
  final String? hint;
  final TextStyle? inputStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;

  const UserNameTextField({
    required this.label,
    this.userNameController,
    this.userNameValidator,
    this.onComplete,
    this.hint,
    this.inputStyle,
    this.labelStyle,
    this.hintStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputTextField(
      controller: userNameController,
      validator: userNameValidator,
      textInputType: TextInputType.text,
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
