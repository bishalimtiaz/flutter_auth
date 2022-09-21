import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/constants/auth_text_style.dart';
import 'package:flutter_auth/auth/constants/auth_values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCountryPickerMenu extends StatelessWidget {
  final Country country;

  const ItemCountryPickerMenu({required this.country, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        SizedBox(width: AuthValues.margin_8.w),
        Text(
          "+${country.phoneCode}",
          style: countryPickerTextStyle,
        ),
      ],
    );
  }
}
