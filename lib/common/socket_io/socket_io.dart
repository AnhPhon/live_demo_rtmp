// ignore_for_file: library_prefixes
import 'package:demo_live_stream/exports/exports_path.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIO {
  IO.Socket socket = IO.io(
      sl<SharedPreferenceHelper>().getSocketServer.toString(),
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          // .setExtraHeaders({'authorization': 'Bearer ${sl.get<SharedPreferenceHelper>().getJwtToken}'}) // headers
          .enableAutoConnect()
          .build());

  ///
  /// _init
  ///
  void init() {
    if (!IZIValidate.nullOrEmpty(sl<SharedPreferenceHelper>().getSocketServer)) {
      if (socket.disconnected) {
        socket.connect();
        socket.onConnect(
          (_) {},
        );
      }
    }
  }

  ///
  /// Reset socket.
  ///
  void reSetSocket() {
    socket = IO.io(
      sl<SharedPreferenceHelper>().getSocketServer.toString(),
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          // .setExtraHeaders({'authorization': 'Bearer ${sl.get<SharedPreferenceHelper>().getJwtToken}'}) // headers
          .enableAutoConnect()
          .build(),
    );
  }

  ///
  /// Destroy socket.
  ///
  void destroySocket() {
    socket.close();
    socket.destroy();
    socket.dispose();
  }
}
