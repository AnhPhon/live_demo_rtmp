// ignore_for_file: constant_identifier_names

import 'package:demo_live_stream/exports/exports_path.dart';
import 'package:flutter/material.dart';

class IZIButton extends StatelessWidget {
  const IZIButton({
    Key? key,
    required this.onTap,
    this.label,
    this.height,
    this.maxLine,
    this.type = IZIButtonType.DEFAULT,
    this.isEnabled = true,
    this.padding,
    this.margin,
    this.borderRadius,
    this.icon,
    this.iconRight,
    this.imageUrlIconRight,
    this.color = ColorResources.white,
    this.colorBGDisabled = ColorResources.grey,
    this.colorDisable = ColorResources.black,
    this.colorBG = ColorResources.primary_1,
    this.colorIcon,
    this.colorText,
    this.imageUrlIcon,
    this.withBorder,
    this.width,
    this.fontSizedLabel,
    this.space,
    this.fontWeight,
    this.colorBorder,
    this.fillColor,
    this.sizeIcon,
    this.isGradient = false,
    this.gradientColorList,
  }) : super(key: key);

  final String? label;
  final Color? color;
  final Color? colorDisable;
  final Color? colorBGDisabled;
  final Color? colorBG;
  final Function onTap;
  final double? height;
  final int? maxLine;
  final IZIButtonType? type;
  final Color? colorIcon;
  final Color? colorText;
  final Color? colorBorder;
  final Color? fillColor;

  final bool? isEnabled;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? borderRadius;
  final IconData? icon, iconRight;
  final String? imageUrlIcon, imageUrlIconRight;
  final double? withBorder;
  final double? width;
  final double? fontSizedLabel;
  final double? space;
  final double? sizeIcon;
  final FontWeight? fontWeight;
  final bool? isGradient;
  final List<Color>? gradientColorList;

  Color getColorBG(IZIButtonType type) {
    if (type == IZIButtonType.DEFAULT) {
      if (isEnabled!) {
        return colorBG!;
      }
      return colorBGDisabled!;
    } else if (type == IZIButtonType.OUTLINE) {
      if (isEnabled!) {
        return fillColor ?? ColorResources.backGround;
      }
      return ColorResources.white;
    }
    return colorBG!;
  }

  Color getColor(IZIButtonType type) {
    if (type == IZIButtonType.DEFAULT) {
      if (isEnabled!) {
        return color!;
      }
      return colorDisable!;
    } else if (type == IZIButtonType.OUTLINE) {
      if (isEnabled!) {
        return colorBG!;
      }
      return ColorResources.grey;
    }
    return color!;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled!
          ? () {
              FocusManager.instance.primaryFocus?.unfocus();
              onTap();
            }
          : null,
      child: Container(
        width: width ?? IZISizeUtil.getMaxWidth(),
        padding: padding ??
            IZISizeUtil.setEdgeInsetsSymmetric(vertical: IZISizeUtil.SPACE_2X, horizontal: IZISizeUtil.SPACE_2X),
        margin: margin,
        decoration: BoxDecoration(
          gradient: !isGradient!
              ? null
              : LinearGradient(
                  colors: gradientColorList ??
                      const [
                        Color(0xffFF4BAD),
                        Color(0xffA9005C),
                      ],
                ),
          color: getColorBG(type!),
          border: type == IZIButtonType.DEFAULT
              ? null
              : Border.all(
                  color: colorBorder ?? ColorResources.primary_1,
                  width: withBorder ?? 1,
                ),
          borderRadius: IZISizeUtil.setBorderRadiusAll(radius: borderRadius ?? 100),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!IZIValidate.nullOrEmpty(imageUrlIcon))
              SizedBox(
                height: sizeIcon ?? IZISizeUtil.setSize(percent: .1),
                width: sizeIcon ?? IZISizeUtil.setSize(percent: .1),
                child: IZIImage(
                  imageUrlIcon.toString(),
                ),
              ),
            if (icon != null)
              Icon(
                icon,
                color: colorIcon ?? getColor(type!),
                size: sizeIcon ?? IZISizeUtil.setSize(percent: .1),
              )
            else
              const SizedBox(),
            SizedBox(
              width: space == null ? 0 : IZISizeUtil.setSize(percent: .1) * space!,
            ),
            if (label != null)
              Flexible(
                child: Text(
                  " $label",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: fontSizedLabel ?? IZISizeUtil.LABEL_FONT_SIZE,
                        color: colorText ?? getColor(type!),
                        fontWeight: fontWeight ?? FontWeight.w700,
                      ),
                  maxLines: maxLine ?? 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            if (!IZIValidate.nullOrEmpty(imageUrlIconRight))
              SizedBox(
                height: IZISizeUtil.setSize(percent: .2),
                width: IZISizeUtil.setSize(percent: .2),
                child: IZIImage(
                  imageUrlIconRight.toString(),
                ),
              ),
            if (iconRight != null)
              Icon(
                iconRight,
                color: colorIcon ?? getColor(type!),
                size: IZISizeUtil.setSize(percent: .125),
              )
            else
              const SizedBox(),
          ],
        ),
      ),
    );
  }
}
