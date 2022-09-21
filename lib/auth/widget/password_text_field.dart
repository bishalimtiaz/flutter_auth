import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/widget/Input_text_field.dart';
import 'package:flutter_auth/auth/constants/auth_text_style.dart';

class PasswordTextField extends StatefulWidget {
  final String? Function(String?)? passwordValidator;
  final TextEditingController? passwordController;
  final Function()? onComplete;
  final Color suffixIconColor;
  final String labelText;
  final TextInputAction? inputAction;
  final String? hint;
  final TextStyle? inputStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;

  const PasswordTextField({
    required this.suffixIconColor,
    required this.labelText,
    this.passwordController,
    this.passwordValidator,
    this.inputAction,
    this.onComplete,
    this.inputStyle,
    this.hint,
    this.labelStyle,
    this.hintStyle,
    Key? key,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return InputTextField(
      controller: widget.passwordController,
      validator: widget.passwordValidator,
      textInputType: TextInputType.text,
      inputBorder: const OutlineInputBorder(),
      labelText: widget.labelText,
      labelStyle: widget.labelStyle ?? textFieldLabelTextStyle,
      hintText: widget.hint,
      hintStyle: widget.hintStyle ?? textFieldHintTextStyle,
      maxLines: 1,
      style: widget.inputStyle ?? inputTextStyle,
      inputAction: widget.inputAction,
      onComplete: widget.onComplete,
      isObscure: !_showPassword,
      errorMaxLine: 9,
      suffixIcon: GestureDetector(
        child: Icon(
          _showPassword ? Icons.visibility : Icons.visibility_off,
          color: widget.suffixIconColor,
        ),
        onTap: () {
          setState(
            () {
              _showPassword = !_showPassword;
            },
          );
        },
      ),
    );
  }
}
