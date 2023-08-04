import 'package:flutter/material.dart';

class WatchLiveStreamPage extends StatefulWidget {
  const WatchLiveStreamPage({super.key});

  @override
  State<WatchLiveStreamPage> createState() => _WatchLiveStreamPageState();
}

class _WatchLiveStreamPageState extends State<WatchLiveStreamPage> {
  //
  // Create data.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Watch live Stream'),
      ),
      body: const SizedBox(),
    );
  }
}
