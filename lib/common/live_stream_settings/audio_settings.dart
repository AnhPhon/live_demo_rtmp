import 'package:apivideo_live_stream/apivideo_live_stream.dart';

class AudioSettings {
  ///
  /// Generate channel of audio.
  ///
  static Map<Channel, String> getChannelMap() {
    Map<Channel, String> map = {};
    for (final res in Channel.values) {
      map[res] = res.toChannelPrettyAudioString();
    }
    return map;
  }

  ///
  /// Generate bitrate of audio.
  ///
  static Map<int, String> getBitrateMap() {
    final List<int> audioBitrateList = [32000, 64000, 128000, 192000];
    Map<int, String> map = {};
    for (final res in audioBitrateList) {
      map[res] = res.toBitratePrettyAudioString(bitrate: res);
    }
    return map;
  }

  ///
  /// Generate sample rate of audio.
  ///
  static Map<SampleRate, String> getSampleRatesMap() {
    Map<SampleRate, String> map = {};
    for (final res in SampleRate.values) {
      map[res] = res.toSampleRatePrettyString();
    }
    return map;
  }
}

///
/// Extension of audio channel.
///
extension ResolutionExtension on Channel {
  String toChannelPrettyAudioString() {
    var result = "";
    switch (this) {
      case Channel.mono:
        result = "Mono";
        break;
      case Channel.stereo:
        result = "Stereo";
        break;
      default:
        result = "Stereo";
        break;
    }
    return result;
  }
}

///
/// Extension of audio bitrate.
///
extension BitrateExtension on int {
  String toBitratePrettyAudioString({required bitrate}) {
    return "${bitrate / 1000} Kbps";
  }
}

///
/// Extension of audio sample rate.
///
extension SampleRateExtension on SampleRate {
  String toSampleRatePrettyString() {
    var result = "";
    switch (this) {
      case SampleRate.kHz_11:
        result = "11 kHz";
        break;
      case SampleRate.kHz_22:
        result = "22 kHz";
        break;
      case SampleRate.kHz_44_1:
        result = "44.1 kHz";
        break;
    }
    return result;
  }
}
