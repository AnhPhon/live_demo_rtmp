// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mixin IZISizeUtil {
  ///
  /// Get max size width.
  ///
  static double getMaxWidth() {
    return ScreenUtil().screenWidth;
  }

  ///
  /// Get max size height.
  ///
  static double getMaxHeight() {
    return ScreenUtil().screenHeight;
  }

  ///
  /// Set size for Size Box, Container.
  ///
  static double setSize({required double percent}) {
    return percent.sh;
  }

  ///
  /// Set size with height.
  ///
  static double setSizeWithWidth({required double percent}) {
    return percent.sw;
  }

  ///
  /// Get bottom bar height.
  ///
  static double getBottomBarHeight({double? value}) {
    if (value != null) {
      return value.sh;
    }
    return ScreenUtil().bottomBarHeight;
  }

  ///
  /// Get status bar height.
  ///
  static double getStatusBarHeight({double? value}) {
    if (value != null) {
      return value.sh;
    }
    return ScreenUtil().statusBarHeight;
  }

  ///
  /// Set EdgeInsets all.
  ///
  static REdgeInsets setEdgeInsetsAll(double value) {
    return REdgeInsets.all(value);
  }

  ///
  /// Set EdgeInsets only.
  ///
  static REdgeInsets setEdgeInsetsOnly({double? bottom = 0, double? right = 0, double? left = 0, double? top = 0}) {
    return REdgeInsets.only(
      bottom: bottom!,
      right: right!,
      left: left!,
      top: top!,
    );
  }

  ///
  /// Set EdgeInsets symmetric.
  ///
  static REdgeInsets setEdgeInsetsSymmetric({double? vertical = 0, double? horizontal = 0}) {
    return REdgeInsets.symmetric(
      vertical: vertical!,
      horizontal: horizontal!,
    );
  }

  ///
  /// Set radius circular.
  ///
  static Radius setRadiusCircular({required double radius}) {
    return Radius.circular(radius).w;
  }

  ///
  /// Set border radius all.
  ///
  static BorderRadius setBorderRadiusAll({required double radius}) {
    return BorderRadius.all(Radius.circular(radius)).w;
  }

  /// Space between widget.
  static const double SPACE_TITLE_VS_CONTENT = 5;
  static const double SPACE_BIG_COMPONENT = 20;
  static const double SPACE_COMPONENT = 15;
  static const double SPACE_SMALL_COMPONENT = 10;
  static const double SPACE_HORIZONTAL_SCREEN = 10;
  static const double SPACE_1X = 5;
  static const double SPACE_2X = 10;
  static const double SPACE_3X = 15;
  static const double SPACE_4X = 20;
  static const double SPACE_5X = 25;
  static const double SPACE_6X = 30;

  /// Border radius.
  static const double RADIUS_BIG = 30;
  static const double RADIUS_MEDIUM = 20;
  static const double RADIUS_SMALL = 10;
  static const double RADIUS_1X = 5;
  static const double RADIUS_2X = 10;
  static const double RADIUS_3X = 15;
  static const double RADIUS_4X = 20;
  static const double RADIUS_5X = 25;
  static const double RADIUS_6X = 30;

  /// Font size.
  static double BIG_FONT_SIZE = 24.sp;
  static double MEDIUM_FONT_SIZE = 20.sp;
  static double SMALL_FONT_SIZE = 18.sp;
  static double LABEL_FONT_SIZE = 16.sp;
  static double MEDIUM_LABEL_FONT_SIZE = 15.sp;
  static double MEDIUM_SMALL_LABEL_FONT_SIZE = 14.sp;
  static double MEDIUM_SMALL_LABEL_FONT_SIZE_12 = 12.sp;
  static double BIG_CONTENT_FONT_SIZE = 13.sp;
  static double MEDIUM_CONTENT_FONT_SIZE = 10.sp;
  static double SMALL_CONTENT_FONT_SIZE = 8.sp;
}
