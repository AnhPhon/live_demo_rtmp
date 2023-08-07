import 'package:demo_live_stream/data/socket_response.dart/socket_response.dart';
import 'package:demo_live_stream/exports/exports_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';

class WatchLiveStreamPage extends StatefulWidget {
  const WatchLiveStreamPage({super.key});

  @override
  State<WatchLiveStreamPage> createState() => _WatchLiveStreamPageState();
}

class _WatchLiveStreamPageState extends State<WatchLiveStreamPage> with TickerProviderStateMixin {
  //
  // Create data.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late VlcPlayerController _videoLiveController;
  final SocketIO _socketIO = GetIt.I.get<SocketIO>();

  // Animated gift.
  late final AnimationController _animatedController;
  bool _isShowLotie = false;
  String _lotiePath = '';

  // Live stream endpoint.
  late String _liveStreamEndpoint;
  bool _isLoading = true;

  @override
  void initState() {
    //
    // Get arguments.
    _getArguments();

    //  Init animated gift controller.
    _initAnimatedGiftController();

    // Connect socket.
    _listenChannelSocket();

    super.initState();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await _videoLiveController.stopRendererScanning();
    await _videoLiveController.dispose();
  }

  ///
  /// Init animated gift controller.
  ///
  void _initAnimatedGiftController() {
    _animatedController = AnimationController(vsync: this);
  }

  ///
  /// Get arguments.
  ///
  Future<void> _getArguments() async {
    await Future.delayed(const Duration(seconds: 1), () {
      if (!IZIValidate.nullOrEmpty(ModalRoute.of(context)?.settings.arguments)) {
        _liveStreamEndpoint = ModalRoute.of(context)?.settings.arguments as String;
      }
    });

    //  Initialize the play back live stream.
    _initializePlayBackLiveStream();
  }

  ///
  /// Initialize the play back live stream.
  ///
  Future<void> _initializePlayBackLiveStream() async {
    //
    //initializing the player
    _videoLiveController = VlcPlayerController.network(
      _liveStreamEndpoint,
      options: VlcPlayerOptions(),
    );

    _videoLiveController.addOnInitListener(() async {
      await _videoLiveController.startRendererScanning();
    });

    _isLoading = false;
    if (mounted) setState(() {});
  }

  ///
  /// Connect socket.
  ///
  void _listenChannelSocket() {
    if (_socketIO.socket.connected && !IZIValidate.nullOrEmpty(sl<SharedPreferenceHelper>().getChannelSocket)) {
      _socketIO.socket.on(
        sl<SharedPreferenceHelper>().getChannelSocket!,
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
    }
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

          // Watch live optional.
          _watchLiveOptional(context),

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
                ..forward().whenComplete(
                  () {
                    _onHideLottie();
                  },
                );
            },
          ),
        ],
      ),
    );
  }

  ///
  /// View live stream.
  ///
  Positioned _viewLiveStream() {
    return Positioned.fill(
      child: _isLoading
          ? const Center(child: LoadingApp(titleLoading: 'Joining the room....'))
          : Transform.scale(
              scale: 1.45,
              child: VlcPlayer(
                controller: _videoLiveController,
                aspectRatio: 9 / 16,
                placeholder: const Center(child: LoadingApp(titleLoading: 'Joining the room....')),
              ),
            ),
    );
  }

  ///
  ///  Watch live optional.
  ///
  Positioned _watchLiveOptional(BuildContext context) {
    return Positioned.fill(
      child: Padding(
        padding: IZISizeUtil.setEdgeInsetsOnly(
          top: IZISizeUtil.setSize(percent: .04),
          bottom: IZISizeUtil.SPACE_4X,
          right: IZISizeUtil.SPACE_HORIZONTAL_SCREEN,
          left: IZISizeUtil.SPACE_HORIZONTAL_SCREEN,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.close,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      barrierColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext ctx) {
                        return _giftBottomSheet();
                      },
                    );
                  },
                  child: IZIImage(
                    ImagePaths.giftIcon,
                    width: IZISizeUtil.setSize(percent: .06),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// Gift bottom sheet.
  ///
  Container _giftBottomSheet() {
    return Container(
      width: IZISizeUtil.getMaxWidth(),
      height: IZISizeUtil.setSize(percent: .2),
      decoration: const BoxDecoration(
        color: ColorResources.bgGift,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      padding: IZISizeUtil.setEdgeInsetsSymmetric(
          horizontal: IZISizeUtil.SPACE_HORIZONTAL_SCREEN, vertical: IZISizeUtil.SPACE_2X),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose a gift',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: ColorResources.white),
          ),
          Expanded(
            child: Center(
              child: Row(
                children: [
                  Wrap(
                    spacing: IZISizeUtil.SPACE_2X,
                    runSpacing: IZISizeUtil.SPACE_2X,
                    children: AppConstants.giftMap.keys.map((e) {
                      return InkWell(
                        onTap: () {
                          //
                          // Emit lotie.
                          if (_socketIO.socket.connected &&
                              !IZIValidate.nullOrEmpty(sl<SharedPreferenceHelper>().getChannelSocket)) {
                            final SocketResponse socketResponse = SocketResponse(
                                type: SocketType.donateGift.name, message: AppConstants.giftMap[e].toString());

                            _socketIO.socket
                                .emit(sl<SharedPreferenceHelper>().getChannelSocket!, socketResponse.toMap());
                          } else {
                            IZIAlert(context).error(context, message: 'Please connect socket.');
                          }
                        },
                        child: ClipRRect(
                          borderRadius: IZISizeUtil.setBorderRadiusAll(radius: 5),
                          child: IZIImage(
                            e,
                            width: IZISizeUtil.setSize(percent: .06),
                            height: IZISizeUtil.setSize(percent: .06),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
