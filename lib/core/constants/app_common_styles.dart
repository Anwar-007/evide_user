import 'package:evide_user/core/utils/app_imports.dart';

class AppCommonStyles {
  static TextStyle commonTextStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    String? fontFamily,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
    TextOverflow? overflow,
  }) {
    return TextStyle(
      color: color ?? Colors.black,
      fontSize: fontSize ?? 16.sp,
      fontWeight: fontWeight ?? FontWeight.bold,
      fontFamily: fontFamily ?? AppAssets.poppinsFont,
      letterSpacing: letterSpacing,
      decoration: decoration,
      overflow: overflow,
      height: height,
    );
  }
}