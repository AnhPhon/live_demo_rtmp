// ignore_for_file: constant_identifier_names

enum PageTransitionType {
  fade,
  fadeIn,
  rightToLeft,
  leftToRight,
  upToDown,
  downToUp,
  native,
}

enum IZIInputType {
  TEXT,
  PASSWORD,
  NUMBER,
  DOUBLE,
  PRICE,
  EMAIL,
  PHONE,
  MULTILINE,
}

enum IZIPickerDate {
  MATERIAL,
  CUPERTINO,
}

enum IZIImageType {
  SVG,
  IMAGE,
  NOT_IMAGE,
}

enum IZIImageUrlType {
  NETWORK,
  ASSET,
  FILE,
  ICON,
  IMAGE_CIRCLE,
}

enum IZIButtonType {
  DEFAULT,
  OUTLINE,
}

enum TypeOfVideoSettings {
  //
  // Video.
  videoResolutions,
  videoFPS,
  videoPosition,
  muteLive,

  // Audio.
  channelAudio,
  bitrateAudio,
  sampleRateAudio,
}

///
/// Enum type of alert.
///
enum TypeOfAlert {
  ERROR,
  SUCCESS,
  INFO,
  WARRING,
}

///
/// Enum of socket.
///
enum SocketType {
  testSocket,
  donateGift,
  endLive,
}
