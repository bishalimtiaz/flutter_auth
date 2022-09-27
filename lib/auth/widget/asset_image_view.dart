import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AssetImageView extends StatelessWidget {
  const AssetImageView({
    Key? key,
    required this.assetPath,
    this.height,
    this.width,
    this.color,
    this.scale,
    this.isDefault = true,
    this.fit,
  }) : super(key: key);

  final String assetPath;
  final double? height;
  final double? width;
  final Color? color;
  final double? scale;
  final bool isDefault;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return _getView();
  }

  Widget _getView() {
    String mimType = assetPath.split(".").last;
    //String path = "images/$fileName";

    if (mimType.isEmpty) {
      return Icon(
        Icons.image_not_supported_outlined,
        size: width,
        color: color,
      );
    }

    switch (mimType) {
      case "svg":
        return SvgPicture.asset(
          assetPath,
          height: height,
          width: width,
          color: color,
          package: isDefault ? 'flutter_auth' : null,
        );
      case "png":
      case "jpg":
      case "jpeg":
        return Image.asset(
          assetPath,
          height: height,
          width: width,
          color: color,
          scale: scale,
          package: isDefault ? 'flutter_auth' : null,
          fit: fit,
        );
      default:
        return Icon(
          Icons.image_not_supported_outlined,
          size: width,
          color: color,
        );
    }
  }
}
