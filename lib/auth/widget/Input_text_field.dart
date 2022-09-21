import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key? key,
    this.initialValue,
    this.controller,
    this.labelText,
    this.hintText,
    this.icon,
    this.onChanged,
    this.isObscure,
    this.validator,
    this.inputAction,
    this.textInputType,
    this.onSubmitted,
    this.onComplete,
    this.inputBorder,
    this.style,
    this.hintStyle,
    this.labelStyle,
    this.errorStyle,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.errorMaxLine,
    this.readOnly = false,
    this.autoFocus = true,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.counterText,
    this.suffixIcon,
  }) : super(key: key);

  final String? initialValue;
  final String? labelText;
  final String? hintText;
  final IconData? icon;
  final Function(String)? onChanged;
  final Function(String?)? onSubmitted;
  final Function()? onComplete;
  final bool? isObscure;
  final String? Function(String?)? validator;
  final TextInputAction? inputAction;
  final TextInputType? textInputType;
  final InputBorder? inputBorder;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? errorStyle;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final int? errorMaxLine;
  final TextEditingController? controller;
  final bool readOnly;
  final bool autoFocus;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final String? counterText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      focusNode: focusNode,
      initialValue: initialValue,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: hintStyle,
        errorStyle: errorStyle,
        errorMaxLines: errorMaxLine,
        labelStyle: labelStyle,
        icon: icon != null ? Icon(icon) : null,
        border: inputBorder,
        disabledBorder: inputBorder,
        enabledBorder: inputBorder,
        errorBorder: inputBorder,
        focusedBorder: inputBorder,
        focusedErrorBorder: inputBorder,
        counterText: counterText,
        suffixIcon: suffixIcon,
      ),
      style: style,
      onChanged: onChanged,
      obscureText: isObscure ?? false,
      validator: validator,
      textInputAction: inputAction,
      keyboardType: textInputType,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      onSaved: onSubmitted,
      onEditingComplete: onComplete,
      readOnly: readOnly,
      autofocus: autoFocus,
      textCapitalization: textCapitalization,
      textAlign: textAlign,
    );
  }
}
