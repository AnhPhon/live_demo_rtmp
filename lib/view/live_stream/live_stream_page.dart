import 'dart:developer';

import 'package:apivideo_live_stream/apivideo_live_stream.dart';
import 'package:demo_live_stream/data/socket_response.dart/socket_response.dart';
import 'package:demo_live_stream/exports/exports_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:wakelock/wakelock.dart';

class LiveStreamPage extends StatefulWidget {
  const LiveStreamPage({
    super.key,
  });

  @override
  State<LiveStreamPage> createState() => _LiveStreamPageState();
}

class _LiveStreamPageState extends State<LiveStreamPage> with TickerProviderStateMixin {
  //
  // Create data.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final ApiVideoLiveStreamController? _liveStreamController;
  final ParamsLiveStream _paramsLiveStream = GetIt.I.get<ParamsLiveStream>();
  final SocketIO _socketIO = GetIt.I.get<SocketIO>();

  // Animated gift.
  late final AnimationController _animatedController;
  bool _isShowLotie = false;
  String _lotiePath = '';

  // bool value.
  bool _isLoading = true;
  bool _isStreaming = false;
  bool _isMicroOff = false;

  // Endpoint live steam.
  late String _rtmpLiveStreamEndPoint;
  late String _streamKeyLiveStream;

  @override
  void initState() {
    //
    // Initialize camera controller.
    _initCameraController();

    //  Init animated gift controller.
    _initAnimatedGiftController();

    // Connect socket.
    _listenChannelSocket();

    super.initState();
  }

  @override
  void dispose() {
    _liveStreamController?.dispose();

    // Disable screen alive.
    Wakelock.disable();
    super.dispose();
  }

  ///
  /// Init animated gift controller.
  ///
  void _initAnimatedGiftController() {
    _animatedController = AnimationController(vsync: this);
  }

  ///
  /// Connect socket.
  ///
  void _listenChannelSocket() {
    if (_socketIO.socket.connected && !IZIValidate.nullOrEmpty(sl<SharedPreferenceHelper>().getChannelSocket)) {
      _socketIO.socket.on(
        sl<SharedPreferenceHelper>().getChannelSocket.toString(),
        (data) {
          if (!IZIValidate.nullOrEmpty(data)) {
            final SocketResponse socketResponse = SocketResponse.fromMap(data as Map<String, dynamic>);
            if (socketResponse.type.toString() == SocketType.donateGift.name) {
              //
              // Show lotie.
              Future.delayed(Duration.zero, () {
                _onShowLottie(socketResponse.message.toString());
              });
            }
          }
        },
      );
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        IZIAlert(context).error(context, message: 'Please connect the socket to use the gift.');
      });
    }
  }

  ///
  /// Initialize camera controller.
  ///
  Future<void> _initCameraController() async {
    //
    // Init live steam controller.
    _liveStreamController = ApiVideoLiveStreamController(
      initialAudioConfig: _paramsLiveStream.audio,
      initialVideoConfig: _paramsLiveStream.video,
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
      initialCameraPosition: _paramsLiveStream.cameraPosition,
    );

    await _liveStreamController!.initialize().catchError((e) {
      log('Init live steam controller error at $e}');
    });

    // Set mute/unmute with setting.
    _isMicroOff = _paramsLiveStream.isMute;
    _liveStreamController!.setIsMuted(_isMicroOff);

    _isLoading = false;
    if (!mounted) return;
    setState(() {});

    //  Get arguments.
    _getArguments();
  }

  ///
  /// Get arguments.
  ///
  void _getArguments() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!IZIValidate.nullOrEmpty(ModalRoute.of(context)?.settings.arguments)) {
        final List<String> arguments = ModalRoute.of(context)?.settings.arguments as List<String>;

        _rtmpLiveStreamEndPoint = arguments.first;
        _streamKeyLiveStream = arguments.last;
      }
    });
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
        .startStreaming(streamKey: _streamKeyLiveStream, url: _rtmpLiveStreamEndPoint)
        .catchError((error) {
      if (error is PlatformException) {
        log("Start live stream failed to start stream: ${error.message}");
        IZIAlert(context).error(context, message: 'Start live stream failed to start stream: ${error.message}');
      } else {
        log("Start live stream failed to start stream: $error");
        IZIAlert(context).error(context, message: 'Start live stream failed to start stream: $error');
      }
    });

    await _liveStreamController!.isStreaming.then((val) {
      if (val) {
        // Set flag stream is true.
        _setFlagsStream(isStreaming: true);

        // Keep screen alive.
        Wakelock.enable();
      }
    });
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

    // Disable screen alive.
    Wakelock.disable();
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

  ///
  /// Show lotie.
  ///
  void _onShowLottie(String lottie) {
    _lotiePath = lottie;
    _isShowLotie = true;

    if (mounted) setState(() {});
  }

  ///
  /// On hide lotie.
  ///
  void _onHideLottie() {
    _isShowLotie = false;
    _animatedController.reset();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          //
          // View live stream.
          _viewLiveStream(),

          // Optional settings.
          _optionalSettings(),

          // Show lotie.
          if (_isShowLotie) _lotieGift(),
        ],
      ),
    );
  }

  ///
  /// Lotie gift.
  ///
  Positioned _lotieGift() {
    return Positioned.fill(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            _lotiePath,
            controller: _animatedController,
            repeat: true,
            onLoaded: (composition) {
              _animatedController
                ..duration = composition.duration
                ..forward().whenComplete(() {
                  _onHideLottie();
                });
            },
          ),
        ],
      ),
    );
  }

  ///
  ///  View live stream.
  ///
  Positioned _viewLiveStream() {
    return Positioned.fill(
      child: _isLoading
          ? const Center(child: LoadingApp(titleLoading: 'Creating live streams...'))
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
                  Transform.scale(
                    scale: 1.2,
                    child: ApiVideoCameraPreview(
                      controller: _liveStreamController!,
                    ),
                  ),
              ],
            ),
    );
  }

  ///
  ///  Optional settings.
  ///
  Positioned _optionalSettings() {
    return Positioned.fill(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: IZISizeUtil.setEdgeInsetsOnly(
              top: IZISizeUtil.setSize(percent: .04),
              right: IZISizeUtil.SPACE_HORIZONTAL_SCREEN,
              left: IZISizeUtil.SPACE_HORIZONTAL_SCREEN,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //
                // Start or stop live.
                _startOrStopLive(),

                // Setting video live.
                if (!_isLoading) _settingVideoLive(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  ///  Start or stop live.
  ///
  Row _startOrStopLive() {
    return Row(
      children: [
        Padding(
          padding: IZISizeUtil.setEdgeInsetsOnly(right: IZISizeUtil.SPACE_3X),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.close,
              size: 35,
              color: Colors.white,
            ),
          ),
        ),

        // Start/Stop stream.
        if (!_isLoading)
          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            padding: IZISizeUtil.setEdgeInsetsSymmetric(
              vertical: IZISizeUtil.SPACE_2X,
              horizontal: IZISizeUtil.SPACE_3X,
            ),
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
    );
  }

  ///
  /// Setting video live.
  ///
  Column _settingVideoLive() {
    return Column(
      children: [
        Padding(
          padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_3X),
          child: InkWell(
            onTap: () async {
              await _switchCamera();
            },
            child: const Icon(
              Icons.cameraswitch,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            await _toggleMicrophone();
          },
          child: Icon(
            _isMicroOff ? Icons.mic_off : Icons.mic,
            color: Colors.white,
            size: 35,
          ),
        ),
      ],
    );
  }
}
