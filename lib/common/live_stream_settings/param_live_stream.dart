import 'package:apivideo_live_stream/apivideo_live_stream.dart';

class ParamsLiveStream {
  final VideoConfig video = VideoConfig.withDefaultBitrate();
  final AudioConfig audio = AudioConfig();

  // Camera position.
  CameraPosition cameraPosition = CameraPosition.front;

  // Mute.
  bool isMute = false;
}
