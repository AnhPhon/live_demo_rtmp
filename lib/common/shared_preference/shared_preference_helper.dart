import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // Shared pref instance.
  final SharedPreferences _sharedPreference;

  // Constructor
  SharedPreferenceHelper(this._sharedPreference);

  // splash: ----------------------------------------------------------
  bool get getSplash {
    return _sharedPreference.getBool(Preferences.isSplash) ?? false;
  }

  void setSplash({required bool status}) {
    _sharedPreference.setBool(Preferences.isSplash, status);
  }

  // Socket server: ----------------------------------------------------------
  String? get getSocketServer {
    return _sharedPreference.getString(Preferences.isSocketServer);
  }

  void setSocketServer({required String socketServer}) {
    _sharedPreference.setString(Preferences.isSocketServer, socketServer);
  }

  // Channel socket: ----------------------------------------------------------
  String? get getChannelSocket {
    return _sharedPreference.getString(Preferences.isChannelSocket);
  }

  void setChannelSocket({required String isChannelSocket}) {
    _sharedPreference.setString(Preferences.isChannelSocket, isChannelSocket);
  }

  // RTMP EndPoint: ----------------------------------------------------------
  String? get getRTMPEndPoint {
    return _sharedPreference.getString(Preferences.rtmpEndPoint);
  }

  void setRTMPEndPoint({required String rtmpEndPoint}) {
    _sharedPreference.setString(Preferences.rtmpEndPoint, rtmpEndPoint);
  }

  // Stream key: ----------------------------------------------------------
  String? get getStreamKey {
    return _sharedPreference.getString(Preferences.streamKey);
  }

  void setStreamKey({required String streamKey}) {
    _sharedPreference.setString(Preferences.streamKey, streamKey);
  }

  // Url live: ----------------------------------------------------------
  String? get getUrlLive {
    return _sharedPreference.getString(Preferences.urlLive);
  }

  void setUrlLive({required String urlLive}) {
    _sharedPreference.setString(Preferences.urlLive, urlLive);
  }
}
