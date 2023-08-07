import 'package:demo_live_stream/common/base_widget/izi_button.dart';
import 'package:demo_live_stream/common/base_widget/izi_input.dart';
import 'package:demo_live_stream/exports/exports_path.dart';
import 'package:demo_live_stream/router/app_router.dart';
import 'package:flutter/material.dart';

class SetUpWatch extends StatefulWidget {
  const SetUpWatch({super.key});

  @override
  State<SetUpWatch> createState() => _SetUpWatchState();
}

class _SetUpWatchState extends State<SetUpWatch> {
  ///
  /// Declare the data.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // EndPoint live stream.
  final TextEditingController _endPointLiveController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize the data.
    _initializeTheData();
  }

  @override
  void dispose() {
    super.dispose();
    _endPointLiveController.dispose();
  }

  ///
  /// Initialize the data.
  ///
  void _initializeTheData() {
    if (!IZIValidate.nullOrEmpty(sl<SharedPreferenceHelper>().getUrlLive)) {
      _endPointLiveController.text = sl<SharedPreferenceHelper>().getUrlLive.toString();
    }
  }

  ///
  /// Validate join live.
  ///
  bool _validateJoinLive() {
    if (_endPointLiveController.text.trim().isEmpty) {
      IZIAlert(context).error(context, message: 'Live stream end point invalid');
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
            children: [
              //
              // EndPoint live stream.
              Padding(
                padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_COMPONENT),
                child: IZIInput(
                  placeHolder: 'Input your Live stream Endpoint',
                  label: 'Live stream Endpoint',
                  type: IZIInputType.TEXT,
                  controller: _endPointLiveController,
                  textInputAction: TextInputAction.next,
                ),
              ),

              // Join live stream button.
              IZIButton(
                margin: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_BIG_COMPONENT),
                isGradient: true,
                label: 'Join live stream',
                onTap: () {
                  if (_validateJoinLive()) {
                    Navigator.pushNamed(context, AppRouters.joinLiveStream,
                        arguments: _endPointLiveController.text.trim());

                    // Set endpoint live.
                    sl<SharedPreferenceHelper>().setUrlLive(urlLive: _endPointLiveController.text.trim());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
