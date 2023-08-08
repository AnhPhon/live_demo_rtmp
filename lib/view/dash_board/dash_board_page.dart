import 'package:demo_live_stream/exports/exports_path.dart';
import 'package:demo_live_stream/view/about_me/about_me_page.dart';
import 'package:demo_live_stream/view/set_up_live/set_up_live_page.dart';
import 'package:demo_live_stream/view/set_up_socket/set_up_socket_page.dart';
import 'package:demo_live_stream/view/set_up_watch/set_up_watch_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  ///
  /// Declares the data.
  final List<Widget> _bodyView = const [SetUpLivePage(), SetUpWatch(), SetUpSocket(), AboutMePage()];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _bodyView,
      ),
      bottomNavigationBar: Padding(
        padding: IZISizeUtil.setEdgeInsetsOnly(
          left: IZISizeUtil.SPACE_5X,
          right: IZISizeUtil.SPACE_5X,
          bottom: IZISizeUtil.SPACE_2X,
          top: IZISizeUtil.SPACE_2X,
        ),
        child: GNav(
          selectedIndex: _currentIndex,
          onTabChange: (value) {
            _currentIndex = value;
            if (mounted) setState(() {});
          },
          rippleColor: Colors.grey[300]!,
          hoverColor: Colors.grey[800]!,
          haptic: true,
          tabBorderRadius: 100,
          tabActiveBorder: Border.all(color: ColorResources.primary_1, width: 1),
          curve: Curves.easeOutExpo,
          duration: const Duration(milliseconds: 300),
          gap: 5,
          color: ColorResources.black,
          activeColor: ColorResources.primary_1,
          iconSize: 25,
          tabBackgroundColor: ColorResources.white,
          padding: IZISizeUtil.setEdgeInsetsSymmetric(horizontal: IZISizeUtil.SPACE_3X, vertical: IZISizeUtil.SPACE_1X),
          tabs: [
            GButton(
              iconSize: 25,
              icon: Icons.stream_outlined,
              text: 'Live',
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
            GButton(
              iconSize: 25,
              icon: Icons.live_tv_outlined,
              text: 'Watch',
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
            GButton(
              iconSize: 28,
              icon: Icons.troubleshoot_outlined,
              text: 'Socket',
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
            GButton(
              iconSize: 28,
              icon: Icons.info_outline,
              text: 'About me',
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
