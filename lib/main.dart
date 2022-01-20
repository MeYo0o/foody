import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody/constants/dependencies/app_bindings.dart';
import 'package:foody/firebase_options.dart';
import 'package:foody/screens/navigation_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Foody());
}

class Foody extends StatelessWidget {
  const Foody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => GetMaterialApp(
        initialBinding: AppBindings(),
        builder: (context, widget) {
          ScreenUtil.setContext(context);
          return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaleFactor: 1.0),
              child: widget!);
        },
        debugShowCheckedModeBanner: false,
        title: 'Foody',
        home: const NavigationScreen(),
      ),
    );
  }
}
