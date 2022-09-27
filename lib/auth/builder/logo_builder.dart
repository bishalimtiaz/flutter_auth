import 'package:flutter/material.dart';

class LogoBuilder {
  final String logoPath;
  final double logoHeight;
  final double logoWidth;
  final BoxFit? fit;

  LogoBuilder({
    required this.logoPath,
    this.logoHeight = 50,
    this.logoWidth = 50,
    this.fit,
  });
}
