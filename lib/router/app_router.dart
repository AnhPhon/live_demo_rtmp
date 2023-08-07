import 'package:demo_live_stream/common/base_widget/page_transaction_router.dart';
import 'package:demo_live_stream/exports/exports_path.dart';
import 'package:demo_live_stream/view/dash_board/dash_board_page.dart';
import 'package:demo_live_stream/view/live_stream/live_stream_page.dart';
import 'package:demo_live_stream/view/set_up_live/set_up_live_page.dart';
import 'package:demo_live_stream/view/splash/splash_page.dart';
import 'package:demo_live_stream/view/watch_live_stream/watch_live_stream_page.dart';
import 'package:flutter/material.dart';

abstract class AppRouters {
  //
  // Name router.
  static const String splash = '/splash';
  static const String dashBoard = '/dashBoard';
  static const String liveStreamRoom = '/liveStreamRoom';
  static const String setUpLive = '/setUpLive';
  static const String joinLiveStream = '/joinLiveStream';

  // Generate routes.
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const SplashPage();
          },
        );
      case dashBoard:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const DashBoard();
          },
        );
      case liveStreamRoom:
        return TransitionPageRoute(
          settings: settings,
          builder: (_) {
            return const LiveStreamPage();
          },
          type: PageTransitionType.rightToLeft,
        );
      case setUpLive:
        return TransitionPageRoute(
          settings: settings,
          builder: (_) {
            return const SetUpLivePage();
          },
          type: PageTransitionType.rightToLeft,
        );
      case joinLiveStream:
        return TransitionPageRoute(
          settings: settings,
          builder: (_) {
            return const WatchLiveStreamPage();
          },
          type: PageTransitionType.rightToLeft,
        );
      default:
        return null;
    }
  }
}
