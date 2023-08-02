import 'dart:developer';

import 'package:apivideo_live_stream/apivideo_live_stream.dart';
import 'package:flutter/material.dart';

class LiveStreamPage extends StatefulWidget {
  const LiveStreamPage({super.key});

  @override
  State<LiveStreamPage> createState() => _LiveStreamPageState();
}

class _LiveStreamPageState extends State<LiveStreamPage> {
  //
  // Create data.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final ApiVideoLiveStreamController? _liveStreamController;
  bool isLoading = true;

  @override
  void initState() {
    //
    //  Initialize camera controller.
    _initCameraController();
    super.initState();
  }

  ///
  /// Initialize camera controller.
  ///
  Future<void> _initCameraController() async {
    //
    // Init live steam controller.
    _liveStreamController = ApiVideoLiveStreamController(
      initialAudioConfig: AudioConfig(),
      initialVideoConfig: VideoConfig.withDefaultBitrate(),
      onConnectionSuccess: () {
        log('Live stream connect success');
      },
      onConnectionFailed: (String error) {
        log('Live stream connect filed at $error');
      },
      onDisconnection: () {
        log('Live stream disconnect');
      },
      onError: (Exception e) {
        log('Live stream Error at $e}');
      },
      initialCameraPosition: CameraPosition.front,
    );

    await _liveStreamController!.initialize().catchError((e) {
      log('Init live steam controller error at $e}');
    });

    isLoading = false;
    if (!mounted) return;
    setState(() {});
  }

  ///
  /// Start video stream.
  ///
  Future<void> _startVideoStream() async {}

  @override
  Widget build(BuildContext context) {
    // final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Live Stream'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (_liveStreamController == null || !_liveStreamController!.isInitialized)
                        const Center(
                          child: Text(
                            'Camera not available. Please try again.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        )
                      else
                        Expanded(
                          child: ApiVideoCameraPreview(
                            controller: _liveStreamController!,
                          ),
                        ),
                    ],
                  ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      // Start/Stop stream.
                      MaterialButton(
                        color: Colors.red,
                        onPressed: () {
                          _startVideoStream();
                        },
                        child: const Text(
                          'Start stream',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
