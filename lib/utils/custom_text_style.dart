import 'package:flutter/material.dart';

class CustomTextStyles {
  static TextStyle text({
    required double size,
    required FontWeight weight,
    Color? color,
    double? height,
  }) {
    return TextStyle(
      color: color,
      fontFamily: "Roboto",
      fontSize: size,
      fontWeight: weight,
      height: height,
    );
  }

  static TextStyle f10W300({Color? color, double? height}) =>
      text(size: 10, weight: FontWeight.w300, color: color, height: height);
  static TextStyle f10W400({Color? color, double? height}) =>
      text(size: 10, weight: FontWeight.w400, color: color, height: height);
  static TextStyle f10W500({Color? color, double? height}) =>
      text(size: 10, weight: FontWeight.w500, color: color, height: height);
  static TextStyle f10W600({Color? color, double? height}) =>
      text(size: 10, weight: FontWeight.w600, color: color, height: height);
  static TextStyle f10W700({Color? color, double? height}) =>
      text(size: 10, weight: FontWeight.w700, color: color, height: height);

  static TextStyle f11W300({Color? color, double? height}) =>
      text(size: 11, weight: FontWeight.w300, color: color, height: height);
  static TextStyle f11W400({Color? color, double? height}) =>
      text(size: 11, weight: FontWeight.w400, color: color, height: height);
  static TextStyle f11W500({Color? color, double? height}) =>
      text(size: 11, weight: FontWeight.w500, color: color, height: height);
  static TextStyle f11W600({Color? color, double? height}) =>
      text(size: 11, weight: FontWeight.w600, color: color, height: height);
  static TextStyle f11W700({Color? color, double? height}) =>
      text(size: 11, weight: FontWeight.w700, color: color, height: height);

  static TextStyle f12W300({Color? color, double? height}) =>
      text(size: 12, weight: FontWeight.w300, color: color, height: height);
  static TextStyle f12W400({Color? color, double? height}) =>
      text(size: 12, weight: FontWeight.w400, color: color, height: height);
  static TextStyle f12W500({Color? color, double? height}) =>
      text(size: 12, weight: FontWeight.w500, color: color, height: height);
  static TextStyle f12W600({Color? color, double? height}) =>
      text(size: 12, weight: FontWeight.w600, color: color, height: height);
  static TextStyle f12W700({Color? color, double? height}) =>
      text(size: 12, weight: FontWeight.w700, color: color, height: height);

  static TextStyle f13W400({Color? color, double? height}) =>
      text(size: 13, weight: FontWeight.w400, color: color, height: height);
  static TextStyle f13W500({Color? color, double? height}) =>
      text(size: 13, weight: FontWeight.w500, color: color, height: height);
  static TextStyle f13W600({Color? color, double? height}) =>
      text(size: 13, weight: FontWeight.w600, color: color, height: height);
  static TextStyle f13W700({Color? color, double? height}) =>
      text(size: 13, weight: FontWeight.w700, color: color, height: height);

  static TextStyle f14W400({Color? color, double? height}) =>
      text(size: 14, weight: FontWeight.w400, color: color, height: height);
  static TextStyle f14W500({Color? color, double? height}) =>
      text(size: 14, weight: FontWeight.w500, color: color, height: height);
  static TextStyle f14W600({Color? color, double? height}) =>
      text(size: 14, weight: FontWeight.w600, color: color, height: height);
  static TextStyle f14W700({Color? color, double? height}) =>
      text(size: 14, weight: FontWeight.w700, color: color, height: height);

  static TextStyle f16W300({Color? color, double? height}) =>
      text(size: 16, weight: FontWeight.w300, color: color, height: height);
  static TextStyle f16W400({Color? color, double? height}) =>
      text(size: 16, weight: FontWeight.w400, color: color, height: height);
  static TextStyle f16W500({Color? color, double? height}) =>
      text(size: 16, weight: FontWeight.w500, color: color, height: height);
  static TextStyle f16W600({Color? color, double? height}) =>
      text(size: 16, weight: FontWeight.w600, color: color, height: height);
  static TextStyle f16W700({Color? color, double? height}) =>
      text(size: 16, weight: FontWeight.w700, color: color, height: height);

  static TextStyle f18W400({Color? color, double? height}) =>
      text(size: 18, weight: FontWeight.w400, color: color, height: height);
  static TextStyle f18W500({Color? color, double? height}) =>
      text(size: 18, weight: FontWeight.w500, color: color, height: height);
  static TextStyle f18W600({Color? color, double? height}) =>
      text(size: 18, weight: FontWeight.w600, color: color, height: height);
  static TextStyle f18W700({Color? color, double? height}) =>
      text(size: 18, weight: FontWeight.w700, color: color, height: height);

  static TextStyle f20W400({Color? color, double? height}) =>
      text(size: 20, weight: FontWeight.w400, color: color, height: height);
  static TextStyle f20W600({Color? color, double? height}) =>
      text(size: 20, weight: FontWeight.w600, color: color, height: height);
  static TextStyle f20W700({Color? color, double? height}) =>
      text(size: 20, weight: FontWeight.w700, color: color, height: height);

  static TextStyle f24W600({Color? color, double? height}) =>
      text(size: 24, weight: FontWeight.w600, color: color, height: height);
  static TextStyle f24W700({Color? color, double? height}) =>
      text(size: 24, weight: FontWeight.w700, color: color, height: height);

  static TextStyle f28W600({Color? color, double? height}) =>
      text(size: 28, weight: FontWeight.w600, color: color, height: height);
  static TextStyle f28W700({Color? color, double? height}) =>
      text(size: 28, weight: FontWeight.w700, color: color, height: height);

  static TextStyle f32W600({Color? color, double? height}) =>
      text(size: 32, weight: FontWeight.w600, color: color, height: height);
  static TextStyle f32W700({Color? color, double? height}) =>
      text(size: 32, weight: FontWeight.w700, color: color, height: height);
}
