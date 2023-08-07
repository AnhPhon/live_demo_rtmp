// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:demo_live_stream/exports/exports_path.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class IZIAlert {
  ///
  /// Declare toast.
  final showToast = FToast();
  int? milliseconds;
  IZIAlert(BuildContext context, {this.milliseconds}) {
    init(context);
  }

  ///
  /// Init toast.
  ///
  void init(BuildContext context) {
    showToast.init(context);
  }

  ///
  /// Show info.
  ///
  void info(
    BuildContext context, {
    required String message,
    ToastGravity? toastGravityPosition,
  }) {
    showToast.removeQueuedCustomToasts();
    showToast.showToast(
      positionedToastBuilder: (context, child) {
        return Positioned(
          top: IZISizeUtil.getStatusBarHeight(),
          left: 0,
          right: 0,
          child: child,
        );
      },
      toastDuration: Duration(milliseconds: milliseconds ?? 1000),
      child: customToast(context, message: message, typeOfAlert: TypeOfAlert.INFO),
      gravity: toastGravityPosition ?? ToastGravity.TOP,
    );
  }

  ///
  /// Show successfully.
  ///
  void success(
    BuildContext context, {
    required String message,
    ToastGravity? toastGravityPosition,
  }) {
    showToast.removeQueuedCustomToasts();
    showToast.showToast(
      positionedToastBuilder: (context, child) {
        return Positioned(
          top: IZISizeUtil.getStatusBarHeight(),
          left: 0,
          right: 0,
          child: child,
        );
      },
      child: customToast(context, message: message, typeOfAlert: TypeOfAlert.SUCCESS),
      gravity: toastGravityPosition ?? ToastGravity.TOP,
      toastDuration: Duration(milliseconds: milliseconds ?? 1000),
    );
  }

  ///
  /// Show error.
  ///
  void error(
    BuildContext context, {
    required String message,
    ToastGravity? toastGravityPosition,
  }) {
    showToast.removeQueuedCustomToasts();
    showToast.showToast(
      positionedToastBuilder: (context, child) {
        return Positioned(
          top: IZISizeUtil.getStatusBarHeight(),
          left: 0,
          right: 0,
          child: child,
        );
      },
      child: customToast(context, message: message, typeOfAlert: TypeOfAlert.ERROR),
      gravity: toastGravityPosition ?? ToastGravity.TOP,
      toastDuration: Duration(milliseconds: milliseconds ?? 1000),
    );
  }

  ///
  /// Show warring.
  ///
  void warring(
    BuildContext context, {
    required String message,
    ToastGravity? toastGravityPosition,
  }) {
    showToast.removeQueuedCustomToasts();
    showToast.showToast(
      positionedToastBuilder: (context, child) {
        return Positioned(
          top: IZISizeUtil.getStatusBarHeight(),
          left: 0,
          right: 0,
          child: child,
        );
      },
      child: customToast(context, message: message, typeOfAlert: TypeOfAlert.WARRING),
      gravity: toastGravityPosition ?? ToastGravity.TOP,
      toastDuration: Duration(milliseconds: milliseconds ?? 1000),
    );
  }

  ///
  /// customToastSuccessful
  ///
  Widget customToast(
    BuildContext context, {
    required String message,
    required TypeOfAlert typeOfAlert,
    Color? colorBG,
    double? sizeWidthToast,
  }) {
    ///
    /// Generate title alert.
    ///
    String _generateTitleAlert(TypeOfAlert type) {
      switch (type) {
        case TypeOfAlert.SUCCESS:
          return 'Success!';
        case TypeOfAlert.INFO:
          return 'Info!';
        case TypeOfAlert.ERROR:
          return 'Error!';
        default:
          return 'Warring!';
      }
    }

    ///
    /// Generate background color.
    ///
    Color _genBackgroundColor(TypeOfAlert type) {
      switch (type) {
        case TypeOfAlert.SUCCESS:
          return ColorResources.successAlert;
        case TypeOfAlert.INFO:
          return ColorResources.infoAlert;
        case TypeOfAlert.WARRING:
          return ColorResources.warringAlert;
        default:
          return ColorResources.errorAlert;
      }
    }

    ///
    /// Convert color to dark color.
    ///
    HSLColor _genDartColor(TypeOfAlert type) {
      switch (type) {
        case TypeOfAlert.SUCCESS:
          final hsl = HSLColor.fromColor(ColorResources.successAlert);
          final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 0.9));
          return hslDark;
        case TypeOfAlert.INFO:
          final hsl = HSLColor.fromColor(ColorResources.infoAlert);
          final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 0.9));
          return hslDark;
        case TypeOfAlert.WARRING:
          final hsl = HSLColor.fromColor(ColorResources.warringAlert);
          final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 0.9));
          return hslDark;
        default:
          final hsl = HSLColor.fromColor(ColorResources.errorAlert);
          final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 0.9));
          return hslDark;
      }
    }

    ///
    /// Generate image path.
    ///
    String _genImagePath(TypeOfAlert type) {
      switch (type) {
        case TypeOfAlert.SUCCESS:
          return ImagePaths.successAlert;
        case TypeOfAlert.INFO:
          return ImagePaths.helpAlert;
        default:
          return ImagePaths.warningAlert;
      }
    }

    return Row(
      children: [
        Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: IZISizeUtil.setEdgeInsetsSymmetric(horizontal: IZISizeUtil.setSizeWithWidth(percent: .03)),
                padding: IZISizeUtil.setEdgeInsetsOnly(
                  left: IZISizeUtil.setSizeWithWidth(percent: .13),
                  top: 15,
                  right: 10,
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                  color: _genBackgroundColor(typeOfAlert),
                  borderRadius: IZISizeUtil.setBorderRadiusAll(radius: IZISizeUtil.SPACE_2X),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 25,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _generateTitleAlert(typeOfAlert),
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Padding(
                            padding: IZISizeUtil.setEdgeInsetsOnly(top: 3),
                            child: Text(
                              message,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.white,
                                  ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// other SVGs in body
              Positioned(
                bottom: 0,
                left: IZISizeUtil.setSizeWithWidth(percent: 0.035),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                  ),
                  child: IZIImage(
                    ImagePaths.bubblesAlert,
                    height: IZISizeUtil.setSize(percent: 0.05),
                    width: IZISizeUtil.setSize(percent: 0.04),
                    colorIconsSvg: _genDartColor(typeOfAlert).toColor(),
                  ),
                ),
              ),

              Positioned(
                top: -IZISizeUtil.setSize(percent: 0.018),
                left: IZISizeUtil.setSize(percent: 0.05),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    IZIImage(
                      ImagePaths.backAlert,
                      width: IZISizeUtil.setSize(percent: 0.03),
                      colorIconsSvg: _genDartColor(typeOfAlert).toColor(),
                    ),
                    Positioned(
                      top: IZISizeUtil.setSize(percent: 0.008),
                      child: IZIImage(
                        _genImagePath(typeOfAlert),
                        height: IZISizeUtil.setSize(percent: 0.015),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
