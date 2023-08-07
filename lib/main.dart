import 'package:demo_live_stream/common/constants/constants.dart';
import 'package:demo_live_stream/router/app_router.dart';
import 'package:demo_live_stream/theme/app_theme.dart';
import 'package:demo_live_stream/theme/type_of_theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../di_container.dart' as di_container;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Register get it.
  await di_container.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: MaterialApp(
            initialRoute: AppRouters.splash,
            onGenerateRoute: AppRouters.onGenerateRoute,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppConstants.localizationsDelegates,
            theme: AppTheme.light,
            builder: (context, widget) {
              return Theme(
                data: lightTheme,
                child: MediaQuery(
                  //
                  // Setting font does not change with system font size
                  data: MediaQuery.of(context).copyWith(
                    textScaleFactor: 1.0,
                    boldText: false,
                  ),
                  child: widget!,
                ),
              );
            },
            home: child,
          ),
        );
      },
    );
  }
}
