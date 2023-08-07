import 'package:demo_live_stream/exports/exports_path.dart';
import 'package:flutter/material.dart';

class BaseAppBar extends StatefulWidget implements PreferredSizeWidget {
  const BaseAppBar(
      {Key? key,
      required this.title,
      this.onBack,
      this.actions,
      this.backgroundColor,
      this.titleStyle,
      this.leading,
      this.bottom})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  State<BaseAppBar> createState() => _BaseAppBarState();

  final String title;
  final Widget? leading;
  final Function? onBack;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final PreferredSizeWidget? bottom;
}

class _BaseAppBarState extends State<BaseAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: widget.bottom,
      elevation: 0,
      backgroundColor: widget.backgroundColor ?? ColorResources.white,
      actions: widget.actions,
      foregroundColor: ColorResources.white,
      surfaceTintColor: Colors.transparent,
      leading: widget.leading ??
          GestureDetector(
            onTap: () {
              if (widget.onBack != null) {
                widget.onBack!();
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: ColorResources.black,
              size: IZISizeUtil.setSizeWithWidth(percent: 0.06),
            ),
          ),
      title: Text(
        widget.title,
        style: widget.titleStyle ??
            Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
      ),
      centerTitle: true,
    );
  }
}
