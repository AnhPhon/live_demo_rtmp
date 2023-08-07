import 'package:apivideo_live_stream/apivideo_live_stream.dart';

class VideoSettings {
  ///
  /// Generate video resolution map.
  ///
  static Map<Resolution, String> getResolutionsMap() {
    Map<Resolution, String> map = {};
    for (final res in Resolution.values) {
      map[res] = res.toResolutionPrettyString();
    }
    return map;
  }

  ///
  /// Generate video FPS map.
  ///
  static Map<int, String> getFPSMap() {
    final List<int> valueFPS = [15, 20, 24, 30];
    Map<int, String> map = {};
    for (final e in valueFPS) {
      map[e] = e.toFPSPrettyString();
    }
    return map;
  }

  ///
  /// Generate video position map.
  ///
  static Map<CameraPosition, String> getPositionMap() {
    Map<CameraPosition, String> map = {};
    for (final e in CameraPosition.values) {
      if (e != CameraPosition.other) map[e] = e.toCameraPositionPrettyString();
    }
    return map;
  }

  ///
  /// Generate mute live.
  ///
  static Map<bool, String> getMuteMap() {
    final List<bool> dataMute = [false, true];
    Map<bool, String> map = {};
    for (final e in dataMute) {
      map[e] = e.toMutePrettyString();
    }
    return map;
  }
}

///
/// Extension of video resolution.
///
extension ResolutionExtension on Resolution {
  String toResolutionPrettyString() {
    var result = "";
    switch (this) {
      case Resolution.RESOLUTION_240:
        result = "352x240";
        break;
      case Resolution.RESOLUTION_360:
        result = "640x360";
        break;
      case Resolution.RESOLUTION_480:
        result = "858x480";
        break;
      case Resolution.RESOLUTION_720:
        result = "1280x720";
        break;
      case Resolution.RESOLUTION_1080:
        result = "1920x1080";
        break;
      default:
        result = "1280x720";
        break;
    }
    return result;
  }
}

///
/// Extension of video FPS.
///
extension FPSExtension on int {
  String toFPSPrettyString() {
    var result = "";
    switch (this) {
      case 15:
        result = "15 fps";
        break;
      case 20:
        result = "20 fps";
        break;
      case 24:
        result = "24 fps";
        break;
      case 30:
        result = "30 fps";
        break;
      default:
        result = "30 fps";
        break;
    }
    return result;
  }
}

///
/// Extension of position of video FPS.
///
extension PositionExtension on CameraPosition {
  String toCameraPositionPrettyString() {
    var result = "";
    switch (this) {
      case CameraPosition.front:
        result = "Front";
        break;
      case CameraPosition.back:
        result = "Back";
        break;

      default:
        result = "Front";
        break;
    }
    return result;
  }
}

///
/// Extension of mute or unmute.
///
extension MuteExtension on bool {
  String toMutePrettyString() {
    var result = "";
    switch (this) {
      case true:
        result = "Mute";
        break;
      case false:
        result = "Unmute";
        break;

      default:
        result = "Unmute";
        break;
    }
    return result;
  }
}
