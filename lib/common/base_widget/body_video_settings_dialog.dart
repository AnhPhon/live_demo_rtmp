import 'package:demo_live_stream/common/base_widget/izi_button.dart';
import 'package:demo_live_stream/common/live_stream_settings/audio_settings.dart';
import 'package:demo_live_stream/exports/exports_path.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


class BodyVideoSettingsDialog extends StatefulWidget {
  const BodyVideoSettingsDialog({super.key, required this.typeOfVideoSettings});

  final TypeOfVideoSettings typeOfVideoSettings;

  @override
  State<BodyVideoSettingsDialog> createState() => _BodyVideoSettingsDialogState();
}

class _BodyVideoSettingsDialogState extends State<BodyVideoSettingsDialog> {
  ///
  /// Declare the data.
  final ParamsLiveStream _paramsLiveStream = GetIt.I.get<ParamsLiveStream>();
  late Map<dynamic, String> _data;
  int _groupValueSetting = 0;

  @override
  void initState() {
    super.initState();

    // Create data.
    _createData();
  }

  ///
  /// Create data.
  ///
  Future<void> _createData() async {
    //
    // Get type of video settings.
    await _getTypeOfVideSettings(widget.typeOfVideoSettings);

    // Get init group setting value.
    _getInitGroupSettingValue(widget.typeOfVideoSettings);
  }

  ///
  /// Generate title dialog.
  ///
  String _generateTitleDialog(TypeOfVideoSettings type) {
    switch (type) {
      case TypeOfVideoSettings.videoResolutions:
        return 'Video resolution';
      case TypeOfVideoSettings.videoFPS:
        return 'Video FPS';
      case TypeOfVideoSettings.videoPosition:
        return 'Video position';
      case TypeOfVideoSettings.muteLive:
        return 'Mute/Unmute';
      case TypeOfVideoSettings.channelAudio:
        return 'Channel of audio';
      case TypeOfVideoSettings.bitrateAudio:
        return 'Bitrate of audio';
      case TypeOfVideoSettings.sampleRateAudio:
        return 'Sample rate of audio';
      default:
    }
    return 'Video resolution';
  }

  ///
  /// Get type of video settings.
  ///
  Future<void> _getTypeOfVideSettings(TypeOfVideoSettings type) async {
    switch (type) {
      case TypeOfVideoSettings.videoResolutions:
        _data = VideoSettings.getResolutionsMap();

        if (mounted) setState(() {});
        break;

      case TypeOfVideoSettings.videoFPS:
        _data = VideoSettings.getFPSMap();

        if (mounted) setState(() {});
        break;

      case TypeOfVideoSettings.videoPosition:
        _data = VideoSettings.getPositionMap();

        if (mounted) setState(() {});
        break;
      case TypeOfVideoSettings.muteLive:
        _data = VideoSettings.getMuteMap();

        if (mounted) setState(() {});
        break;

      case TypeOfVideoSettings.channelAudio:
        _data = AudioSettings.getChannelMap();

        if (mounted) setState(() {});
        break;
      case TypeOfVideoSettings.bitrateAudio:
        _data = AudioSettings.getBitrateMap();

        if (mounted) setState(() {});
        break;
      case TypeOfVideoSettings.sampleRateAudio:
        _data = AudioSettings.getSampleRatesMap();

        if (mounted) setState(() {});
        break;
      default:
    }
  }

  ///
  /// Get init group setting value.
  ///
  void _getInitGroupSettingValue(TypeOfVideoSettings type) {
    switch (type) {
      case TypeOfVideoSettings.videoResolutions:
        for (int i = 0; i < _data.keys.length; i++) {
          if (_data[_data.keys.toList()[i]] == _paramsLiveStream.video.resolution.toResolutionPrettyString()) {
            _groupValueSetting = i;
            break;
          }
        }
        if (mounted) setState(() {});
        break;
      case TypeOfVideoSettings.videoFPS:
        for (int i = 0; i < _data.keys.length; i++) {
          if (_data[_data.keys.toList()[i]] == _paramsLiveStream.video.fps.toFPSPrettyString()) {
            _groupValueSetting = i;
            break;
          }
        }
        if (mounted) setState(() {});
        break;
      case TypeOfVideoSettings.videoPosition:
        for (int i = 0; i < _data.keys.length; i++) {
          if (_data[_data.keys.toList()[i]] == _paramsLiveStream.cameraPosition.toCameraPositionPrettyString()) {
            _groupValueSetting = i;
            break;
          }
        }
        if (mounted) setState(() {});
        break;
      case TypeOfVideoSettings.muteLive:
        for (int i = 0; i < _data.keys.length; i++) {
          if (_data[_data.keys.toList()[i]] == _paramsLiveStream.isMute.toMutePrettyString()) {
            _groupValueSetting = i;
            break;
          }
        }
        if (mounted) setState(() {});
        break;
      case TypeOfVideoSettings.channelAudio:
        for (int i = 0; i < _data.keys.length; i++) {
          if (_data[_data.keys.toList()[i]] == _paramsLiveStream.audio.channel.toChannelPrettyAudioString()) {
            _groupValueSetting = i;
            break;
          }
        }
        if (mounted) setState(() {});
        break;
      case TypeOfVideoSettings.bitrateAudio:
        for (int i = 0; i < _data.keys.length; i++) {
          if (_data[_data.keys.toList()[i]] ==
              _paramsLiveStream.audio.bitrate.toBitratePrettyAudioString(bitrate: _paramsLiveStream.audio.bitrate)) {
            _groupValueSetting = i;
            break;
          }
        }
        if (mounted) setState(() {});
        break;
      case TypeOfVideoSettings.sampleRateAudio:
        for (int i = 0; i < _data.keys.length; i++) {
          if (_data[_data.keys.toList()[i]] == _paramsLiveStream.audio.sampleRate.toSampleRatePrettyString()) {
            _groupValueSetting = i;
            break;
          }
        }
        if (mounted) setState(() {});
        break;
      default:
    }
  }

  ///
  /// Generate on select settings.
  ///
  void _generateOnSelectSettings(TypeOfVideoSettings type) {
    switch (type) {
      case TypeOfVideoSettings.videoResolutions:
        _paramsLiveStream.video.resolution = _data.keys.toList()[_groupValueSetting];
        Navigator.of(context).pop();
        break;
      case TypeOfVideoSettings.videoFPS:
        _paramsLiveStream.video.fps = _data.keys.toList()[_groupValueSetting];
        Navigator.of(context).pop();
        break;
      case TypeOfVideoSettings.videoPosition:
        _paramsLiveStream.cameraPosition = _data.keys.toList()[_groupValueSetting];
        Navigator.of(context).pop();
        break;
      case TypeOfVideoSettings.muteLive:
        _paramsLiveStream.isMute = _data.keys.toList()[_groupValueSetting];
        Navigator.of(context).pop();
        break;
      case TypeOfVideoSettings.channelAudio:
        _paramsLiveStream.audio.channel = _data.keys.toList()[_groupValueSetting];
        Navigator.of(context).pop();
        break;
      case TypeOfVideoSettings.bitrateAudio:
        _paramsLiveStream.audio.bitrate = _data.keys.toList()[_groupValueSetting];
        Navigator.of(context).pop();
        break;
      case TypeOfVideoSettings.sampleRateAudio:
        _paramsLiveStream.audio.sampleRate = _data.keys.toList()[_groupValueSetting];
        Navigator.of(context).pop();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: IZISizeUtil.getMaxWidth(),
      height: IZISizeUtil.getMaxHeight(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: IZISizeUtil.setEdgeInsetsSymmetric(horizontal: IZISizeUtil.SPACE_3X),
              width: IZISizeUtil.getMaxWidth(),
              decoration: BoxDecoration(
                color: ColorResources.white,
                borderRadius: IZISizeUtil.setBorderRadiusAll(radius: IZISizeUtil.RADIUS_3X),
              ),
              padding: IZISizeUtil.setEdgeInsetsAll(IZISizeUtil.SPACE_3X),
              child: Column(
                children: [
                  Padding(
                    padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_2X),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: IZISizeUtil.setEdgeInsetsOnly(right: IZISizeUtil.SPACE_1X),
                          child: IZIImage(
                            ImagePaths.logoNoBG,
                            width: IZISizeUtil.setSize(percent: .04),
                          ),
                        ),
                        Text(
                          _generateTitleDialog(widget.typeOfVideoSettings),
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: ColorResources.black,
                              ),
                        ),
                      ],
                    ),
                  ),

                  // Body data.
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _data.keys.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: IZISizeUtil.setEdgeInsetsOnly(
                            bottom:
                                index != VideoSettings.getResolutionsMap().keys.length - 1 ? IZISizeUtil.SPACE_2X : 0),
                        child: Row(
                          children: [
                            Padding(
                              padding: IZISizeUtil.setEdgeInsetsOnly(right: IZISizeUtil.SPACE_1X),
                              child: Transform.scale(
                                scale: 1.2,
                                child: Radio<int>(
                                  visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity,
                                  ),
                                  value: index,
                                  groupValue: _groupValueSetting,
                                  onChanged: (value) {
                                    _groupValueSetting = value!;
                                    if (mounted) setState(() {});
                                  },
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                _data[_data.keys.toList()[index]].toString(),
                                style: Theme.of(context).textTheme.bodyLarge,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),

                  // Select button.
                  IZIButton(
                    isGradient: true,
                    margin: IZISizeUtil.setEdgeInsetsOnly(top: IZISizeUtil.SPACE_2X),
                    width: IZISizeUtil.setSizeWithWidth(percent: .5),
                    label: 'Select',
                    onTap: () {
                      _generateOnSelectSettings(widget.typeOfVideoSettings);
                    },
                    padding: IZISizeUtil.setEdgeInsetsSymmetric(vertical: IZISizeUtil.SPACE_2X),
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
