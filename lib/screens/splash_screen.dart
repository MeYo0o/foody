import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody/constants/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 150.h),
          Image.asset(
            'assets/images/splash.png',
            height: 300,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20.h),
          const Center(
            child: CircularProgressIndicator(
              color: kMainAppColor,
            ),
          ),
        ],
      ),
    );
  }
}
