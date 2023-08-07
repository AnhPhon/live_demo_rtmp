import 'package:demo_live_stream/exports/exports_path.dart';
import 'package:demo_live_stream/router/app_router.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  //
  // Declare API.
  late AnimationController? _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));

    // check logged in or not.
    _animationController!.forward().whenComplete(
      () async {
        Navigator.pushNamedAndRemoveUntil(context, AppRouters.dashBoard, (route) => false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: IZIImage(
                ImagePaths.logoNoBG,
                width: IZISizeUtil.setSize(percent: .2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
