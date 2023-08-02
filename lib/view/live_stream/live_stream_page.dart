import 'dart:developer';

import 'package:apivideo_live_stream/apivideo_live_stream.dart';
import 'package:demo_live_stream/common/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  // bool value.
  bool _isLoading = true;
  bool _isStreaming = false;
  bool _isMicroOff = false;

  @override
  void initState() {
    //
    //  Initialize camera controller.
    _initCameraController();
    super.initState();
  }

  @override
  void dispose() {
    _liveStreamController?.dispose();
    super.dispose();
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

    _isLoading = false;
    if (!mounted) return;
    setState(() {});
  }

  ///
  /// Start video stream.
  ///
  Future<void> _startVideoStream() async {
    if (_liveStreamController == null) {
      log('Error: create a camera controller first.');
      return;
    }

    // Start live stream.
    await _liveStreamController!
        .startStreaming(streamKey: AppConstants.streamKey, url: AppConstants.rtmpUrl)
        .catchError((error) {
      if (error is PlatformException) {
        log("Start live stream failed to start stream: ${error.message}");
      } else {
        log("Start live stream failed to start stream: $error");
      }
    });

    // Set flag stream is true.
    _setFlagsStream(isStreaming: true);
  }

  ///
  /// Stop live stream.
  ///
  Future<void> _stopVideoStream() async {
    if (_liveStreamController == null) {
      log('Error: create a camera controller first.');
      return;
    }

    await _liveStreamController!.stopStreaming().catchError((error) {
      if (error is PlatformException) {
        log("Stop live stream failed to start stream: ${error.message}");
      } else {
        log("Stop live stream failed to start stream: $error");
      }
    });

    // Set flag stream is false.
    _setFlagsStream(isStreaming: false);
  }

  ///
  /// Switch camera.
  ///
  Future<void> _switchCamera() async {
    if (_liveStreamController == null) {
      log('Error: create a camera controller first.');
      return;
    }

    await _liveStreamController!.switchCamera();

    if (!mounted) return;
    setState(() {});
  }

  ///
  /// Toggle microphone.
  ///
  Future<void> _toggleMicrophone() async {
    if (_liveStreamController == null) {
      log('Error: create a camera controller first.');
      return;
    }

    await _liveStreamController!.toggleMute();

    // Set flags micro.
    _setFlagsMicro();
  }

  ///
  /// Set flags stream.
  ///
  void _setFlagsStream({required bool isStreaming}) {
    _isStreaming = isStreaming;
    if (!mounted) return;
    setState(() {});
  }

  ///
  /// Set flags micro.
  ///
  void _setFlagsMicro() {
    _isMicroOff = !_isMicroOff;
    if (!mounted) return;
    setState(() {});
  }

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
            child: _isLoading
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
                        ApiVideoCameraPreview(
                          controller: _liveStreamController!,
                        ),
                    ],
                  ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              padding: const EdgeInsets.only(bottom: 20),
                              icon: const Icon(
                                Icons.cameraswitch,
                                color: Colors.white,
                                size: 40,
                              ),
                              color: Colors.white,
                              onPressed: () async {
                                await _switchCamera();
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                _isMicroOff ? Icons.mic_off : Icons.mic,
                                color: Colors.white,
                                size: 40,
                              ),
                              color: Colors.white,
                              onPressed: () async {
                                await _toggleMicrophone();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //
                      // Start/Stop stream.
                      MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        color: _isStreaming ? Colors.red : Colors.green,
                        onPressed: () async {
                          if (_isStreaming) {
                            await _stopVideoStream();
                          } else {
                            await _startVideoStream();
                          }
                        },
                        child: Row(
                          children: [
                            Icon(
                              _isStreaming ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                            ),
                            Text(
                              _isStreaming ? 'Stop live' : 'Start live',
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
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
