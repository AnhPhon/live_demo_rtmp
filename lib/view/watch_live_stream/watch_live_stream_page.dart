import 'dart:developer';
import 'package:demo_live_stream/common/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class WatchLiveStreamPage extends StatefulWidget {
  const WatchLiveStreamPage({super.key});

  @override
  State<WatchLiveStreamPage> createState() => _WatchLiveStreamPageState();
}

class _WatchLiveStreamPageState extends State<WatchLiveStreamPage> {
  //
  // Create data.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late VlcPlayerController _controller;

  @override
  void initState() {
    //
    //  Initialize the play back live stream.
    _initializePlayBackLiveStream();
    super.initState();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await _controller.dispose();
  }

  ///
  /// Initialize the play back live stream.
  ///
  void _initializePlayBackLiveStream() {
    //initializing the player
    _controller = VlcPlayerController.network(AppConstants.urlVideoPlayBack, options: VlcPlayerOptions());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    log('Phone render');
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Watch live Stream'),
      ),
      body: VlcPlayer(
        controller: _controller,
        aspectRatio: 9 / 16,
        placeholder: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
