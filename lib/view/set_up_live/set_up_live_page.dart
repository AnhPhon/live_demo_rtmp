import 'package:demo_live_stream/common/base_widget/izi_button.dart';
import 'package:demo_live_stream/common/base_widget/izi_input.dart';
import 'package:demo_live_stream/common/live_stream_settings/audio_settings.dart';
import 'package:demo_live_stream/exports/exports_path.dart';
import 'package:demo_live_stream/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SetUpLivePage extends StatefulWidget {
  const SetUpLivePage({super.key});

  @override
  State<SetUpLivePage> createState() => _SetUpLivePageState();
}

class _SetUpLivePageState extends State<SetUpLivePage> {
  ///
  /// Declare the data.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ParamsLiveStream _paramsLiveStream = GetIt.I.get<ParamsLiveStream>();

  // Expended.
  bool _isExpandedVideoSetting = false;
  bool _isExpandedAudioSetting = false;

  // Stream url.
  final TextEditingController _rtmpEndPointController = TextEditingController();
  final TextEditingController _streamKeyController = TextEditingController();

  // Video settings.
  final TextEditingController _cameraPositionController = TextEditingController();
  final TextEditingController _videoResolutionController = TextEditingController();
  final TextEditingController _videoFPSController = TextEditingController();
  final TextEditingController _muteLiveController = TextEditingController();

  // Audio settings.
  final TextEditingController _channelAudioController = TextEditingController();
  final TextEditingController _bitrateAudioController = TextEditingController();
  final TextEditingController _sampleRateAudioController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Init data.
    _initData();
  }

  @override
  void dispose() {
    super.dispose();

    // Stream url.
    _rtmpEndPointController.dispose();
    _streamKeyController.dispose();

    // Video settings.
    _cameraPositionController.dispose();
    _videoResolutionController.dispose();
    _videoFPSController.dispose();
    _muteLiveController.dispose();

    // Audio settings.
    _channelAudioController.dispose();
    _bitrateAudioController.dispose();
    _sampleRateAudioController.dispose();
  }

  ///
  /// Init data.
  ///
  void _initData() {
    //
    // Stream url.
    if (!IZIValidate.nullOrEmpty(sl<SharedPreferenceHelper>().getRTMPEndPoint)) {
      _rtmpEndPointController.text = sl<SharedPreferenceHelper>().getRTMPEndPoint.toString();
    }

    if (!IZIValidate.nullOrEmpty(sl<SharedPreferenceHelper>().getStreamKey)) {
      _streamKeyController.text = sl<SharedPreferenceHelper>().getStreamKey.toString();
    }

    // Video settings.
    _cameraPositionController.text = _paramsLiveStream.cameraPosition.toCameraPositionPrettyString();
    _videoResolutionController.text = _paramsLiveStream.video.resolution.toResolutionPrettyString();
    _videoFPSController.text = _paramsLiveStream.video.fps.toFPSPrettyString();
    _muteLiveController.text = _paramsLiveStream.isMute.toMutePrettyString();

    // Audio settings.
    _channelAudioController.text = _paramsLiveStream.audio.channel.toChannelPrettyAudioString();
    _bitrateAudioController.text =
        _paramsLiveStream.audio.bitrate.toBitratePrettyAudioString(bitrate: _paramsLiveStream.audio.bitrate);
    _sampleRateAudioController.text = _paramsLiveStream.audio.sampleRate.toSampleRatePrettyString();
  }

  ///
  /// Validate start live.
  ///
  bool _validateStartLive() {
    if (_rtmpEndPointController.text.trim().isEmpty) {
      IZIAlert(context).error(context, message: 'RTMP EndPoint invalid');
      return false;
    }
    if (_streamKeyController.text.trim().isEmpty) {
      IZIAlert(context).error(context, message: 'Stream key invalid');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: const BaseAppBar(
        title: 'Set up live stream',
        leading: SizedBox(),
        backgroundColor: ColorResources.backGround,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: IZISizeUtil.setEdgeInsetsSymmetric(horizontal: IZISizeUtil.SPACE_HORIZONTAL_SCREEN),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              // RTMP Endpoint.
              Padding(
                padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_COMPONENT),
                child: IZIInput(
                  placeHolder: 'Input your RTMP Endpoint',
                  label: 'RTMP Endpoint',
                  type: IZIInputType.TEXT,
                  controller: _rtmpEndPointController,
                  textInputAction: TextInputAction.next,
                ),
              ),

              // Stream key.
              Padding(
                padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_COMPONENT),
                child: IZIInput(
                  placeHolder: 'Input your Stream Key',
                  label: 'Stream key',
                  type: IZIInputType.TEXT,
                  controller: _streamKeyController,
                ),
              ),

              // Start live steam button.
              IZIButton(
                margin: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_BIG_COMPONENT),
                isGradient: true,
                label: 'Start live stream',
                onTap: () {
                  if (_validateStartLive()) {
                    Navigator.pushNamed(context, AppRouters.liveStreamRoom, arguments: [
                      _rtmpEndPointController.text.trim(),
                      _streamKeyController.text.trim(),
                    ]);

                    // Set endpoint live.
                    sl<SharedPreferenceHelper>().setRTMPEndPoint(rtmpEndPoint: _rtmpEndPointController.text.trim());
                    sl<SharedPreferenceHelper>().setStreamKey(streamKey: _streamKeyController.text.trim());
                  }
                },
              ),

              // Video settings.
              _videoSettings(context),

              // Audio settings.
              _audioSettings(context),
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// Video settings.
  ///
  Column _videoSettings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_COMPONENT),
          child: InkWell(
            onTap: () {
              _isExpandedVideoSetting = !_isExpandedVideoSetting;
              if (mounted) setState(() {});
            },
            child: Row(
              children: [
                Padding(
                  padding: IZISizeUtil.setEdgeInsetsOnly(right: IZISizeUtil.SPACE_1X),
                  child: IZIImage(
                    ImagePaths.logoNoBG,
                    width: IZISizeUtil.setSize(percent: .03),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Video settings',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                Icon(
                  _isExpandedVideoSetting
                      ? Icons.keyboard_double_arrow_up_outlined
                      : Icons.keyboard_double_arrow_down_outlined,
                  size: IZISizeUtil.setSize(percent: .03),
                  color: ColorResources.black,
                ),
              ],
            ),
          ),
        ),

        // Video specifications.
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          child: _isExpandedVideoSetting ? _videoSpecifications(context) : const SizedBox(),
        ),
      ],
    );
  }

  ///
  /// Video specifications.
  ///
  Widget _videoSpecifications(BuildContext context) {
    return Column(
      children: [
        //
        // Video  position.
        Padding(
          padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_SMALL_COMPONENT),
          child: IZIInput(
            onTap: () async {
              await BaseDialog.showBaseDialog(context: context, typeOfVideoSettings: TypeOfVideoSettings.videoPosition)
                  .then((value) {
                _cameraPositionController.text = _paramsLiveStream.cameraPosition.toCameraPositionPrettyString();
              });
            },
            label: 'Video position',
            controller: _cameraPositionController,
            type: IZIInputType.TEXT,
            allowEdit: false,
            fillColor: ColorResources.white,
          ),
        ),

        // Video  resolution.
        Padding(
          padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_SMALL_COMPONENT),
          child: IZIInput(
            onTap: () async {
              await BaseDialog.showBaseDialog(
                      context: context, typeOfVideoSettings: TypeOfVideoSettings.videoResolutions)
                  .then((value) {
                _videoResolutionController.text = _paramsLiveStream.video.resolution.toResolutionPrettyString();
              });
            },
            label: 'Video resolution',
            controller: _videoResolutionController,
            type: IZIInputType.TEXT,
            allowEdit: false,
            fillColor: ColorResources.white,
          ),
        ),

        // Video FPS.
        Padding(
          padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_SMALL_COMPONENT),
          child: IZIInput(
            onTap: () async {
              await BaseDialog.showBaseDialog(context: context, typeOfVideoSettings: TypeOfVideoSettings.videoFPS)
                  .then((value) {
                _videoFPSController.text = _paramsLiveStream.video.fps.toFPSPrettyString();
              });
            },
            label: 'Video FPS',
            controller: _videoFPSController,
            type: IZIInputType.TEXT,
            allowEdit: false,
            fillColor: ColorResources.white,
          ),
        ),

        // Video resolution.
        Padding(
          padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_BIG_COMPONENT),
          child: IZIInput(
            onTap: () async {
              await BaseDialog.showBaseDialog(context: context, typeOfVideoSettings: TypeOfVideoSettings.muteLive)
                  .then((value) {
                _muteLiveController.text = _paramsLiveStream.isMute.toMutePrettyString();
              });
            },
            label: 'Mute/Unmute',
            controller: _muteLiveController,
            type: IZIInputType.TEXT,
            allowEdit: false,
            fillColor: ColorResources.white,
          ),
        ),
      ],
    );
  }

  ///
  /// Audio settings.
  ///
  Column _audioSettings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_COMPONENT),
          child: InkWell(
            onTap: () {
              _isExpandedAudioSetting = !_isExpandedAudioSetting;
              if (mounted) setState(() {});
            },
            child: Row(
              children: [
                Padding(
                  padding: IZISizeUtil.setEdgeInsetsOnly(right: IZISizeUtil.SPACE_1X),
                  child: IZIImage(
                    ImagePaths.logoNoBG,
                    width: IZISizeUtil.setSize(percent: .03),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Audio settings',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                Icon(
                  _isExpandedAudioSetting
                      ? Icons.keyboard_double_arrow_up_outlined
                      : Icons.keyboard_double_arrow_down_outlined,
                  size: IZISizeUtil.setSize(percent: .03),
                  color: ColorResources.black,
                ),
              ],
            ),
          ),
        ),

        // Audio specifications.
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          child: _isExpandedAudioSetting ? _audioSpecifications(context) : const SizedBox(),
        ),
      ],
    );
  }

  ///
  /// Audio specifications.
  ///
  Column _audioSpecifications(BuildContext context) {
    return Column(
      children: [
        //
        // Channel of audio.
        Padding(
          padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_SMALL_COMPONENT),
          child: IZIInput(
            onTap: () async {
              await BaseDialog.showBaseDialog(context: context, typeOfVideoSettings: TypeOfVideoSettings.channelAudio)
                  .then((value) {
                _channelAudioController.text = _paramsLiveStream.audio.channel.toChannelPrettyAudioString();
              });
            },
            label: 'Channel of audio',
            controller: _channelAudioController,
            type: IZIInputType.TEXT,
            allowEdit: false,
            fillColor: ColorResources.white,
          ),
        ),

        // Bitrate of audio.
        Padding(
          padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_SMALL_COMPONENT),
          child: IZIInput(
            onTap: () async {
              await BaseDialog.showBaseDialog(context: context, typeOfVideoSettings: TypeOfVideoSettings.bitrateAudio)
                  .then((value) {
                _bitrateAudioController.text = _paramsLiveStream.audio.bitrate
                    .toBitratePrettyAudioString(bitrate: _paramsLiveStream.audio.bitrate);
              });
            },
            label: 'Bitrate of audio',
            controller: _bitrateAudioController,
            type: IZIInputType.TEXT,
            allowEdit: false,
            fillColor: ColorResources.white,
          ),
        ),

        // Sample rate of audio.
        Padding(
          padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_SMALL_COMPONENT),
          child: IZIInput(
            onTap: () async {
              await BaseDialog.showBaseDialog(
                      context: context, typeOfVideoSettings: TypeOfVideoSettings.sampleRateAudio)
                  .then((value) {
                _sampleRateAudioController.text = _paramsLiveStream.audio.sampleRate.toSampleRatePrettyString();
              });
            },
            label: 'Sample rate of audio',
            controller: _sampleRateAudioController,
            type: IZIInputType.TEXT,
            allowEdit: false,
            fillColor: ColorResources.white,
          ),
        ),

        // Echo canceler.
        Padding(
          padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_SMALL_COMPONENT),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Enable echo canceler',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: ColorResources.black,
                      ),
                ),
              ),
              Switch(
                activeColor: ColorResources.primary_1,
                inactiveThumbColor: ColorResources.primary_1,
                inactiveTrackColor: ColorResources.grey,
                value: _paramsLiveStream.audio.enableEchoCanceler,
                onChanged: (val) {
                  _paramsLiveStream.audio.enableEchoCanceler = val;
                  if (mounted) setState(() {});
                },
              ),
            ],
          ),
        ),

        // Noise suppressor.
        Padding(
          padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_SMALL_COMPONENT),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Enable noise suppressor',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: ColorResources.black,
                      ),
                ),
              ),
              Switch(
                activeColor: ColorResources.primary_1,
                inactiveThumbColor: ColorResources.primary_1,
                inactiveTrackColor: ColorResources.grey,
                value: _paramsLiveStream.audio.enableNoiseSuppressor,
                onChanged: (val) {
                  _paramsLiveStream.audio.enableNoiseSuppressor = val;
                  if (mounted) setState(() {});
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
