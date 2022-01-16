import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody/screens/auth_screen.dart';
import 'package:get/get.dart';

import 'screens/splash_screen.dart';

void main() {
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const Foody(), // Wrap your app
  );

  // runApp(const Foody());
}

class Foody extends StatelessWidget {
  const Foody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        builder: (context, widget) {
          DevicePreview.appBuilder(context, widget);
          ScreenUtil.setContext(context);
          return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaleFactor: 1.0),
              child: widget!);
        },
        debugShowCheckedModeBanner: false,
        title: 'Foody',
        home: const AuthScreen(),
      ),
    );
  }
}
