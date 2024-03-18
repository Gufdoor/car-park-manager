import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

abstract class IconHelper {
  static Image build({
    required String iconName,
    double size = 64.0,
    BoxFit boxFit = BoxFit.fill,
    Color? color,
  }) {
    final String sizedIconPath = "assets/$iconName.png";

    return Image(
      fit: boxFit,
      image: AssetImage(sizedIconPath),
      width: size,
      height: size,
      color: color,
    );
  }
}
