import 'package:demo_live_stream/exports/exports_path.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: ColorResources.backGround,
  fontFamily: 'Nunito',
  primaryColor: ColorResources.primary_1, // Màu chủ đạo
  brightness: Brightness.light,
  hintColor: ColorResources.grey,
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
  radioTheme: _radioThemeData(),
  bottomSheetTheme: _bottomSheetThemeData(),
  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  useMaterial3: true,
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(
        secondary: ColorResources.red,
      )
      .copyWith(
        background: ColorResources.backGround,
      ),
  filledButtonTheme: _filledButtonThemeData(),
  iconButtonTheme: _iconButtonThemeData(),
  elevatedButtonTheme: _elevatedButtonThemeData(),
  textButtonTheme: _textButtonThemeData(),
  outlinedButtonTheme: _outlineButtonThemData(),
  textTheme: TextTheme(
    //
    // Set for big title.
    displayLarge: TextStyle(
      fontSize: IZISizeUtil.BIG_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      fontSize: IZISizeUtil.MEDIUM_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      fontSize: IZISizeUtil.SMALL_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
    ),

    // Set for labels.
    labelLarge: TextStyle(
      fontSize: IZISizeUtil.LABEL_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
    ),
    labelMedium: TextStyle(
      fontSize: IZISizeUtil.MEDIUM_SMALL_LABEL_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
    ),

    // Set for content.
    bodyLarge: TextStyle(
        fontSize: IZISizeUtil.BIG_CONTENT_FONT_SIZE,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        fontFamily: 'Nunito'),
    bodyMedium: TextStyle(
      fontSize: IZISizeUtil.MEDIUM_CONTENT_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      fontSize: IZISizeUtil.SMALL_CONTENT_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
    ),
  ),
);

///
/// Filled button theme data.
///
FilledButtonThemeData _filledButtonThemeData() {
  return FilledButtonThemeData(
    style: _buttonStyle(
      backgroundColor: ColorResources.primary_1,
    ),
  );
}

///
/// Icon button them data.
///
IconButtonThemeData _iconButtonThemeData() {
  return IconButtonThemeData(
    style: _buttonStyle(),
  );
}

///
/// Radio theme data.
///
RadioThemeData _radioThemeData() {
  return RadioThemeData(
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
      return ColorResources.primary_1;
    }),
    visualDensity: VisualDensity.comfortable,
  );
}

///
/// Bottom sheet theme data.
///
BottomSheetThemeData _bottomSheetThemeData() {
  return const BottomSheetThemeData(
    backgroundColor: Colors.transparent,
    modalBackgroundColor: Colors.transparent,
    elevation: 0,
  );
}

///
/// Elevated button theme data.
///
ElevatedButtonThemeData _elevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: _buttonStyle(
      elevation: 0,
      backgroundColor: ColorResources.primary_1,
      textColor: ColorResources.black,
    ),
  );
}

///
/// Text button theme data.
///
TextButtonThemeData _textButtonThemeData() {
  return TextButtonThemeData(
    style: _buttonStyle(
      textColor: ColorResources.primary_1,
    ),
  );
}

///
/// Out line button theme data.
///
OutlinedButtonThemeData _outlineButtonThemData() {
  return OutlinedButtonThemeData(
    style: _buttonStyle(
      borderSide: const BorderSide(
        color: ColorResources.primary_1,
        width: 2,
      ),
      textColor: ColorResources.primary_1,
    ),
  );
}

/// ButtonStyle.
ButtonStyle _buttonStyle({
  BorderSide? borderSide,
  double? elevation,
  Color? backgroundColor,
  Color? textColor,
}) {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all(backgroundColor),
    foregroundColor: MaterialStateProperty.all(textColor),
    elevation: MaterialStateProperty.all(elevation ?? 0.0),
    overlayColor: MaterialStateProperty.all(Colors.transparent),
    textStyle: MaterialStatePropertyAll(TextStyle(
      fontSize: IZISizeUtil.LABEL_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
    )),
    padding: const MaterialStatePropertyAll(
      EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 24,
      ),
    ),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
    side: MaterialStatePropertyAll(borderSide),
  );
}
