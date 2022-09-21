import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/builder/phone_auth_builder.dart';
import 'package:flutter_auth/auth/constants/auth_text_style.dart';
import 'Input_text_field.dart';
import 'item_country_picker_menu.dart';
import 'phone_number_input.dart';

class PhoneTextField extends StatelessWidget {
  final String? Function(String?)? phoneValidator;
  final TextEditingController? phoneController;
  final Function()? onComplete;
  final Function(String) onPhoneCodeChanged;
  final PhoneAuthBuilder builder;
  final TextStyle? inputStyle;

  const PhoneTextField({
    required this.onPhoneCodeChanged,
    required this.builder,
    this.phoneController,
    this.phoneValidator,
    this.onComplete,
    this.inputStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhoneNumberInput(
      label: builder.phoneTextFieldLabel,
      phoneTextFieldLabelStyle: builder.phoneTextFieldLabelStyle,
      countryPickerDropdown: _getCountryPickerDropdown(),
      inputTextField: _getInputTextField(),
    );
  }

  InputTextField _getInputTextField() {
    return InputTextField(
      controller: phoneController,
      validator: phoneValidator,
      textInputType: TextInputType.phone,
      inputBorder: InputBorder.none,
      maxLines: 1,
      style: inputStyle ?? inputTextStyle,
      inputAction: TextInputAction.send,
      onComplete: onComplete,
    );
  }

  Widget _getCountryPickerDropdown() {
    return CountryPickerDropdown(
      itemFilter: builder.countryList.isNotEmpty
          ? (c) => builder.countryList.contains(c.isoCode)
          : null,
      initialValue: builder.initialCountry,
      itemBuilder: (c) => ItemCountryPickerMenu(country: c),
      onValuePicked: (country) {
        onPhoneCodeChanged(country.phoneCode);
      },
    );
  }
}
