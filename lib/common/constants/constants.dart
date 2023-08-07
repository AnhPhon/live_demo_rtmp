import 'package:demo_live_stream/exports/exports_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppConstants {
  //
  // Constants of LocalizationsDelegate
  static List<LocalizationsDelegate> localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    DefaultCupertinoLocalizations.delegate,
  ];

  // Map of gift.
  static Map<String, String> giftMap = {
    ImagePaths.giftIcon1: 'assets/icons/gift_1.json',
    ImagePaths.giftIcon2: 'assets/icons/gift_2.json',
    ImagePaths.giftIcon3: 'assets/icons/gift_3.json',
    ImagePaths.giftIcon4: 'assets/icons/gift_4.json',
  };
}
