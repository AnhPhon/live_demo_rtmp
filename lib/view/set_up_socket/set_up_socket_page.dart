import 'package:demo_live_stream/common/base_widget/izi_button.dart';
import 'package:demo_live_stream/common/base_widget/izi_input.dart';
import 'package:demo_live_stream/data/socket_response.dart/socket_response.dart';
import 'package:demo_live_stream/exports/exports_path.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SetUpSocket extends StatefulWidget {
  const SetUpSocket({super.key});

  @override
  State<SetUpSocket> createState() => _SetUpSocketState();
}

class _SetUpSocketState extends State<SetUpSocket> {
  ///
  /// Declare the data.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final SocketIO _socketIO = GetIt.I.get<SocketIO>();

  // Socket.
  final TextEditingController _socketServerController = TextEditingController();
  final TextEditingController _channelSocketController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // Bool data.
  bool _isLoading = true;

  // Data test socket.
  String _sendMessage = '';
  String _receiverMessage = '';

  @override
  void initState() {
    super.initState();

    // Initializes the data.
    _initializeTheData();
  }

  @override
  void dispose() {
    super.dispose();
    _socketServerController.dispose();
    _channelSocketController.dispose();
    _messageController.dispose();
    _socketIO.destroySocket();
  }

  ///
  /// Initializes the data.
  ///
  Future<void> _initializeTheData() async {
    if (!IZIValidate.nullOrEmpty(sl<SharedPreferenceHelper>().getChannelSocket)) {
      _channelSocketController.text = sl<SharedPreferenceHelper>().getChannelSocket!;
    }

    if (!IZIValidate.nullOrEmpty(sl<SharedPreferenceHelper>().getSocketServer)) {
      _socketServerController.text = sl<SharedPreferenceHelper>().getSocketServer!;

      if (_socketServerController.text.trim().isNotEmpty) {
        await _connectSocket().whenComplete(() {
          if (_isLoading) {
            _isLoading = false;
            setState(() {});
          }
        });
      }
    } else {
      _isLoading = false;
      setState(() {});
    }
  }

  ///
  /// Connect to socket.
  ///
  Future<void> _connectSocket() async {
    //
    // Init socket.
    _socketIO.socket.connect();
    _socketIO.socket.onConnect((data) {
      _isLoading = false;
      setState(() {});
    });

    _socketIO.socket.on(
      _channelSocketController.text,
      (data) {
        if (!IZIValidate.nullOrEmpty(data)) {
          final SocketResponse socketResponse = SocketResponse.fromMap(data as Map<String, dynamic>);
          if (socketResponse.type.toString() == SocketType.testSocket.name) {
            _receiverMessage = socketResponse.message.toString();
            setState(() {});
          }
        }
      },
    );
  }

  ///
  /// Reconnect socket.
  ///
  void _reconnectSocket() {
    //
    // Save socket server.
    sl<SharedPreferenceHelper>().setSocketServer(socketServer: _socketServerController.text.trim());
    sl<SharedPreferenceHelper>().setChannelSocket(isChannelSocket: _channelSocketController.text.trim());

    // Reconnect socket.
    _socketIO.reSetSocket();

    // Connect socket.
    _socketIO.socket.connect();
    _socketIO.socket.onConnect((data) {
      setState(() {});
    });

    _socketIO.socket.on(
      _channelSocketController.text,
      (data) {
        final SocketResponse socketResponse = SocketResponse.fromMap(data as Map<String, dynamic>);
        if (socketResponse.type == SocketType.testSocket.name) {
          _receiverMessage = socketResponse.message.toString();
          setState(() {});
        }
      },
    );
  }

  ///
  /// Validate connect socket.
  ///
  bool _validateConnectSocket() {
    if (_socketServerController.text.trim().isEmpty) {
      IZIAlert(context).error(context, message: 'Invalid server socket.');
      return false;
    }

    if (_channelSocketController.text.trim().isEmpty) {
      IZIAlert(context).error(context, message: 'Invalid channel socket.');
      return false;
    }
    return true;
  }

  ///
  /// Validate send message.
  ///
  bool _validateSendMessage() {
    if (_messageController.text.trim().isEmpty) {
      IZIAlert(context).error(context, message: 'Invalid message.');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: const BaseAppBar(
        title: 'Set up Socket IO',
        leading: SizedBox(),
        backgroundColor: ColorResources.backGround,
      ),
      body: _isLoading
          ? const Center(child: LoadingApp(titleLoading: 'Loading...'))
          : SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: IZISizeUtil.setEdgeInsetsSymmetric(horizontal: IZISizeUtil.SPACE_HORIZONTAL_SCREEN),
                child: Column(
                  children: [
                    //
                    // Socket server.
                    _socketServer(context),

                    // Test socket button.
                    _testSocketButton(),

                    // Test socket.
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //
                        // Info socket.
                        _infoSocket(context),

                        // Response.
                        _responseSocket()
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  ///
  /// Socket server.
  ///
  Padding _socketServer(BuildContext context) {
    return Padding(
      padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_COMPONENT),
      child: Column(
        children: [
          Padding(
            padding: IZISizeUtil.setEdgeInsetsOnly(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Socket server',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: ColorResources.black,
                        ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: IZISizeUtil.setEdgeInsetsOnly(right: IZISizeUtil.SPACE_1X),
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: !_socketIO.socket.connected ? ColorResources.red : ColorResources.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: !_socketIO.socket.connected ? 'Disconnected' : 'Connected',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: !_socketIO.socket.connected ? ColorResources.red : ColorResources.green,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_SMALL_COMPONENT),
            child: IZIInput(
              placeHolder: 'Input your Socket server',
              type: IZIInputType.TEXT,
              controller: _socketServerController,
              textInputAction: TextInputAction.next,
            ),
          ),

          // Channel of socket.
          IZIInput(
            label: 'Channel of Socket',
            placeHolder: 'Input your Socket server',
            type: IZIInputType.TEXT,
            controller: _channelSocketController,
            textInputAction: TextInputAction.next,
          ),
        ],
      ),
    );
  }

  ///
  /// Test socket button.
  ///
  Column _testSocketButton() {
    return Column(
      children: [
        if (!_socketIO.socket.connected)
          IZIButton(
            margin: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_COMPONENT),
            isGradient: true,
            label: 'Connect socket',
            onTap: () {
              if (_validateConnectSocket()) {
                _reconnectSocket();
              }
            },
          )
        else
          Padding(
            padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_COMPONENT),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IZIButton(
                  width: IZISizeUtil.setSizeWithWidth(percent: .45),
                  isGradient: true,
                  fontSizedLabel: IZISizeUtil.BIG_CONTENT_FONT_SIZE,
                  label: 'Reconnect',
                  onTap: () {
                    if (_validateConnectSocket()) {
                      _reconnectSocket();
                    }
                  },
                ),
                IZIButton(
                  width: IZISizeUtil.setSizeWithWidth(percent: .45),
                  colorBG: ColorResources.grey,
                  label: 'Disconnect',
                  fontSizedLabel: IZISizeUtil.BIG_CONTENT_FONT_SIZE,
                  onTap: () {
                    _socketIO.destroySocket();
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }

  ///
  /// Info socket.
  ///
  Column _infoSocket(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_COMPONENT),
          child: Text(
            'Test Socket',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),

        // Message.
        Padding(
          padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_COMPONENT),
          child: IZIInput(
            label: 'Message',
            placeHolder: 'Input your message',
            type: IZIInputType.TEXT,
            controller: _messageController,
            textInputAction: TextInputAction.done,
          ),
        ),

        // Test socket button.
        IZIButton(
          margin: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_BIG_COMPONENT),
          isGradient: true,
          label: 'Send message',
          onTap: () {
            if (_validateSendMessage()) {
              if (_socketIO.socket.connected) {
                final SocketResponse socketResponse =
                    SocketResponse(type: SocketType.testSocket.name, message: _messageController.text);

                _socketIO.socket.emit(_channelSocketController.text, socketResponse.toMap());
                _sendMessage = _messageController.text;
              } else {
                IZIAlert(context).error(context, message: 'Please connect socket.');
              }
            }
          },
        ),
      ],
    );
  }

  ///
  ///  Response.
  ///
  Column _responseSocket() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_COMPONENT),
          child: Text(
            'Response',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),

        // Send message.
        _sendMessageResponse(),

        // Received message.
        _receivedMessage(),
      ],
    );
  }

  ///
  /// Send message.
  ///
  Padding _sendMessageResponse() {
    return Padding(
      padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_3X),
      child: Column(
        children: [
          Padding(
            padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_1X),
            child: Row(
              children: [
                Container(
                  margin: IZISizeUtil.setEdgeInsetsOnly(right: IZISizeUtil.SPACE_1X),
                  padding: IZISizeUtil.setEdgeInsetsAll(3),
                  decoration: BoxDecoration(
                    borderRadius: IZISizeUtil.setBorderRadiusAll(radius: 5),
                    color: ColorResources.blue,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_upward_outlined,
                      size: 20,
                      color: ColorResources.white,
                    ),
                  ),
                ),
                Text(
                  'Send',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
          Container(
            width: IZISizeUtil.getMaxWidth(),
            padding: IZISizeUtil.setEdgeInsetsSymmetric(
              vertical: IZISizeUtil.SPACE_2X,
              horizontal: IZISizeUtil.SPACE_1X,
            ),
            decoration: BoxDecoration(
                color: ColorResources.white,
                borderRadius: IZISizeUtil.setBorderRadiusAll(radius: IZISizeUtil.SPACE_1X),
                border: Border.all(color: ColorResources.grey)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _sendMessage,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  ///
  ///  Received message.
  ///
  Column _receivedMessage() {
    return Column(
      children: [
        Padding(
          padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_1X),
          child: Row(
            children: [
              Container(
                margin: IZISizeUtil.setEdgeInsetsOnly(right: IZISizeUtil.SPACE_1X),
                padding: IZISizeUtil.setEdgeInsetsAll(3),
                decoration: BoxDecoration(
                  borderRadius: IZISizeUtil.setBorderRadiusAll(radius: 5),
                  color: ColorResources.yellow,
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_downward_outlined,
                    size: 20,
                    color: ColorResources.white,
                  ),
                ),
              ),
              Text(
                'Received',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
        Container(
          width: IZISizeUtil.getMaxWidth(),
          padding: IZISizeUtil.setEdgeInsetsSymmetric(
            vertical: IZISizeUtil.SPACE_2X,
            horizontal: IZISizeUtil.SPACE_1X,
          ),
          decoration: BoxDecoration(
              color: ColorResources.white,
              borderRadius: IZISizeUtil.setBorderRadiusAll(radius: IZISizeUtil.SPACE_1X),
              border: Border.all(color: ColorResources.grey)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _receiverMessage,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        )
      ],
    );
  }
}
