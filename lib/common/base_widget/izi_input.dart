// ignore_for_file: constant_identifier_names, library_private_types_in_public_api, no_logic_in_create_state

import 'package:demo_live_stream/exports/exports_path.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IZIInput extends StatefulWidget {
  IZIInput({
    Key? key,
    this.label,
    this.placeHolder,
    this.allowEdit = true,
    this.maxLine = 1,
    this.isRequired = false,
    required this.type,
    this.width,
    this.suffixIcon,
    this.textInputAction,
    this.onChanged,
    this.focusNode,
    this.onSubmitted,
    this.borderRadius,
    this.hintStyle,
    this.borderSide,
    this.isBorder = false,
    this.fillColor,
    this.prefixIcon,
    this.isLegend = false,
    this.miniSize = false,
    this.obscureText,
    this.contentPaddingIncrement,
    this.onTap,
    this.labelStyle,
    this.style,
    this.cursorColor,
    this.controller,
    this.autoFocus,
    this.textCapitalization,
    this.isReadOnly = false,
    this.textAlign,
  }) : super(key: key);

  // Is use.
  final Widget? suffixIcon;
  final Color? fillColor;
  final TextEditingController? controller;
  final double? borderRadius;
  final double? width;
  final bool miniSize;
  final bool? isReadOnly;
  final bool? autoFocus;
  final Function? onTap;
  final TextAlign? textAlign;
  final Function(dynamic)? onSubmitted;
  final Function(String value)? onChanged;
  final TextInputAction? textInputAction;
  final bool? allowEdit;
  final int? maxLine;
  final bool? obscureText;
  final TextStyle? style;
  final Color? cursorColor;
  final TextCapitalization? textCapitalization;
  final TextStyle? hintStyle;
  final EdgeInsets? contentPaddingIncrement;
  final bool? isLegend;
  final String? label;
  final Widget Function(FocusNode? focusNode)? prefixIcon;
  final String? placeHolder;
  final FocusNode? focusNode;
  final IZIInputType type;
  final TextStyle? labelStyle;
  final bool? isRequired;
  final BorderSide? borderSide;
  final bool? isBorder;

  _IZIInputState iziState = _IZIInputState();
  @override
  _IZIInputState createState() => iziState = _IZIInputState();
}

class _IZIInputState extends State<IZIInput> {
  FocusNode? focusNode;
  TextEditingController? textEditingController;

  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: '');

    focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    Future.delayed(Duration.zero, () {
      focusNode?.removeListener(() {});
      focusNode?.dispose();
      focusNode = null;
    });
    textEditingController?.dispose();
    super.dispose();
  }

  TextInputType getType(IZIInputType type) {
    if (type == IZIInputType.NUMBER) {
      return TextInputType.number;
    } else if (type == IZIInputType.PASSWORD) {
      return TextInputType.visiblePassword;
    } else if (type == IZIInputType.PRICE) {
      return TextInputType.number;
    } else if (type == IZIInputType.TEXT) {
      return TextInputType.text;
    } else if (type == IZIInputType.EMAIL) {
      return TextInputType.emailAddress;
    } else if (type == IZIInputType.PHONE) {
      return TextInputType.phone;
    } else if (type == IZIInputType.DOUBLE) {
      return const TextInputType.numberWithOptions();
    } else if (type == IZIInputType.MULTILINE) {
      return TextInputType.multiline;
    }
    return TextInputType.text;
  }

  TextEditingController getController(IZIInputType type) {
    return widget.controller ?? textEditingController!;
  }

  Widget? getSuffixIcon() {
    if (widget.type == IZIInputType.PASSWORD) {
      return GestureDetector(
        onTap: () {
          setState(() {
            isVisible = !isVisible;
          });
        },
        child: Icon(
          isVisible ? Icons.visibility_off : Icons.visibility,
        ),
      );
    }
    if (!IZIValidate.nullOrEmpty(widget.suffixIcon)) {
      return widget.suffixIcon!;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.isLegend == false && widget.label != null) _labelInput(),

        // Form input.
        _formInput(),
      ],
    );
  }

  Container _labelInput() {
    return Container(
      padding: IZISizeUtil.setEdgeInsetsOnly(bottom: 10),
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: widget.label,
          style: widget.labelStyle ??
              Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: ColorResources.black,
                  ),
          children: [
            if (widget.isRequired!)
              TextSpan(
                text: '*',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: ColorResources.red,
                    ),
              )
            else
              const TextSpan(),
          ],
        ),
      ),
    );
  }

  ///
  /// Form input.
  ///
  Widget _formInput() {
    return GestureDetector(
      onTap: () {
        if (!IZIValidate.nullOrEmpty(widget.onTap)) {
          widget.onTap!();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.fillColor ?? ColorResources.white,
          borderRadius: IZISizeUtil.setBorderRadiusAll(
            radius: widget.borderRadius ?? IZISizeUtil.RADIUS_MEDIUM,
          ),
        ),
        width: widget.width ?? IZISizeUtil.getMaxWidth(),
        height: widget.miniSize ? 50 : null,
        child: TextFormField(
          readOnly: widget.isReadOnly!,
          autofocus: widget.autoFocus ?? false,
          textAlign: widget.textAlign ?? TextAlign.start,
          onFieldSubmitted: (val) {
            if (!IZIValidate.nullOrEmpty(widget.onSubmitted)) {
              widget.onSubmitted!(val);
            }
          },
          onChanged: (val) {
            if (widget.onChanged != null) {
              widget.onChanged!(val);
            }
          },
          textInputAction: widget.textInputAction,
          keyboardType: getType(widget.type),
          maxLines: widget.maxLine,
          textAlignVertical: TextAlignVertical.center,
          enabled: widget.allowEdit,
          controller: getController(widget.type),
          obscureText: widget.obscureText ?? widget.type == IZIInputType.PASSWORD && isVisible,
          focusNode: focusNode,
          style: widget.style ??
              Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
          cursorColor: widget.cursorColor ?? ColorResources.primary_1,
          textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
          decoration: InputDecoration(
            hintStyle: widget.hintStyle ??
                Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorResources.grey,
                      fontWeight: FontWeight.normal,
                    ),
            contentPadding: widget.miniSize ? const EdgeInsets.all(12) : widget.contentPaddingIncrement,
            isDense: true,
            labelText: widget.isLegend == true ? widget.label : null,
            labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: focusNode!.hasFocus ? FontWeight.w600 : FontWeight.normal,
                ),
            prefixIcon: IZIValidate.nullOrEmpty(widget.prefixIcon) ? null : widget.prefixIcon!(focusNode),
            border: getOutlineInputBorder(),
            focusedBorder: getOutlineInputBorder(),
            enabledBorder: getOutlineInputBorder(),
            disabledBorder: getOutlineInputBorder(),
            filled: true,
            hintText: widget.placeHolder,
            fillColor: (widget.allowEdit == false)
                ? widget.fillColor ?? ColorResources.grey.withOpacity(0.4)
                : widget.fillColor ?? ColorResources.white,
            suffixIcon: getSuffixIcon(),
          ),
        ),
      ),
    );
  }

  ///
  /// Get outlineInputBorder
  ///
  OutlineInputBorder getOutlineInputBorder() {
    BorderSide borderSide = BorderSide.none;
    if (widget.isBorder == true || widget.isLegend == true) {
      borderSide = widget.borderSide ??
          BorderSide(
            width: 1,
            color: (widget.allowEdit == false) ? ColorResources.grey : ColorResources.black,
          );
    }

    return OutlineInputBorder(
      borderSide: borderSide,
      borderRadius: IZISizeUtil.setBorderRadiusAll(
        radius: widget.borderRadius ?? IZISizeUtil.RADIUS_MEDIUM,
      ),
    );
  }
}
