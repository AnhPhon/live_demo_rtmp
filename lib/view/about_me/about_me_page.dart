import 'package:clipboard/clipboard.dart';
import 'package:demo_live_stream/exports/exports_path.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({super.key});

  @override
  State<AboutMePage> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  ///
  /// Declare the data.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: const BaseAppBar(
        title: 'Live Demo - RTMP',
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
              // Logo app.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IZIImage(
                    ImagePaths.logoNoBG,
                    width: IZISizeUtil.setSize(percent: .1),
                  ),
                ],
              ),

              // App Description.
              Padding(
                padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_COMPONENT),
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: IZISizeUtil.setEdgeInsetsOnly(right: IZISizeUtil.SPACE_1X),
                          child: ClipOval(
                            child: IZIImage(
                              ImagePaths.user,
                              width: IZISizeUtil.setSize(percent: .04),
                              height: IZISizeUtil.setSize(percent: .04),
                            ),
                          ),
                        ),
                      ),
                      TextSpan(
                        text: 'Live Demo - RTMP',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text:
                            ' is a versatile application designed for creating and experiencing live streaming sessions. With a combination of Real-Time Messaging Protocol (RTMP) technology and modern features, this application allows users to effortlessly create, view, and interact within live video streams in an easy and engaging manner.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),

              // Source code.
              Padding(
                padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_COMPONENT),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_SMALL_COMPONENT),
                      child: Text(
                        'Source code',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    Container(
                      padding: IZISizeUtil.setEdgeInsetsSymmetric(
                        vertical: IZISizeUtil.SPACE_2X,
                        horizontal: IZISizeUtil.SPACE_1X,
                      ),
                      width: IZISizeUtil.getMaxWidth(),
                      decoration: BoxDecoration(
                        color: ColorResources.white,
                        borderRadius: IZISizeUtil.setBorderRadiusAll(radius: IZISizeUtil.SPACE_1X),
                        border: Border.all(color: ColorResources.grey),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                if (!await launchUrl(Uri.parse('https://github.com/AnhPhon/live_demo_rtmp'))) {
                                  throw Exception('Could not launch https://github.com/AnhPhon/live_demo_rtmp');
                                }
                              },
                              child: Text(
                                'https://github.com/AnhPhon/live_demo_rtmp'
                                    .substring(0, 'https://github.com/AnhPhon/live_demo_rtmp'.length - 5),
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      decoration: TextDecoration.underline,
                                      fontStyle: FontStyle.italic,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Padding(
                            padding: IZISizeUtil.setEdgeInsetsOnly(right: IZISizeUtil.SPACE_2X),
                            child: InkWell(
                              onTap: () {
                                FlutterClipboard.copy('https://github.com/AnhPhon/live_demo_rtmp').then((value) {
                                  IZIAlert(context).success(context, message: 'Copy successful.');
                                });
                              },
                              child: Icon(
                                Icons.copy,
                                size: IZISizeUtil.setSize(percent: .03),
                                color: ColorResources.grey,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Share.share('https://github.com/AnhPhon/live_demo_rtmp');
                            },
                            child: Icon(
                              Icons.share,
                              size: IZISizeUtil.setSize(percent: .03),
                              color: ColorResources.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Contact me.
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_SMALL_COMPONENT),
                    child: Text(
                      'Contact me via',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),

                  // Email.
                  Padding(
                    padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_2X),
                    child: Row(
                      children: [
                        Padding(
                          padding: IZISizeUtil.setEdgeInsetsOnly(right: IZISizeUtil.SPACE_1X),
                          child: IZIImage(
                            ImagePaths.gmailLogo,
                            width: IZISizeUtil.setSize(percent: .025),
                            height: IZISizeUtil.setSize(percent: .025),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'ngotrananhphon.flutter.dev@gmail.com',
                            style: Theme.of(context).textTheme.bodyLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),

                  // Facebook.
                  Padding(
                    padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_2X),
                    child: InkWell(
                      onTap: () async {
                        if (!await launchUrl(Uri.parse('https://www.facebook.com/anhphon.99/'))) {
                          throw Exception('Could not launch https://www.facebook.com/anhphon.99/');
                        }
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: IZISizeUtil.setEdgeInsetsOnly(right: IZISizeUtil.SPACE_1X),
                            child: IZIImage(
                              ImagePaths.facebookLogo,
                              width: IZISizeUtil.setSize(percent: .025),
                              height: IZISizeUtil.setSize(percent: .025),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'https://www.facebook.com/anhphon.99/',
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    decoration: TextDecoration.underline,
                                    fontStyle: FontStyle.italic,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  // Tiktok.
                  InkWell(
                    onTap: () async {
                      if (!await launchUrl(Uri.parse('https://www.tiktok.com/@tech_mind_official'))) {
                        throw Exception('Could not launch https://www.tiktok.com/@tech_mind_official');
                      }
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: IZISizeUtil.setEdgeInsetsOnly(right: IZISizeUtil.SPACE_1X),
                          child: IZIImage(
                            ImagePaths.tiktokLogo,
                            width: IZISizeUtil.setSize(percent: .025),
                            height: IZISizeUtil.setSize(percent: .025),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'https://www.tiktok.com/@tech_mind_official',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  decoration: TextDecoration.underline,
                                  fontStyle: FontStyle.italic,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
