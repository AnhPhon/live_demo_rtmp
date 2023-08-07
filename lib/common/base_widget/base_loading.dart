import 'package:demo_live_stream/exports/exports_path.dart';
import 'package:flutter/material.dart';

class LoadingApp extends StatelessWidget {
  const LoadingApp({
    Key? key,
    this.titleLoading,
    this.titleStyle,
  }) : super(key: key);

  final String? titleLoading;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      width: IZISizeUtil.getMaxWidth(),
      height: IZISizeUtil.getMaxHeight(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: IZISizeUtil.setSize(percent: .14),
            height: IZISizeUtil.setSize(percent: .14),
            child: Stack(
              alignment: Alignment.center,
              children: [
                IZIImage(
                  ImagePaths.logoNoBG,
                  width: IZISizeUtil.setSize(percent: .08),
                ),
                SizedBox(
                  width: IZISizeUtil.setSize(percent: .12),
                  height: IZISizeUtil.setSize(percent: .12),
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(ColorResources.primary_1),
                    strokeWidth: 3,
                  ),
                ),
              ],
            ),
          ),
          if (!IZIValidate.nullOrEmpty(titleLoading))
            Padding(
              padding: IZISizeUtil.setEdgeInsetsOnly(top: 10),
              child: Text(
                titleLoading!,
                style: titleStyle ?? Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
