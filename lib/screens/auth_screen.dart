import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody/screens/widgets/auth_screen/top_border_and_logo.dart';
import 'package:foody/screens/widgets/common/my_light_button.dart';
import 'package:foody/screens/widgets/common/my_thick_button.dart';
import 'package:foody/screens/widgets/common/my_text.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TopBorderAndLogo(),
          MyText(
            text: 'Discover the best foods from over 1,'
                '000 restaurants and fast delivery '
                'to your doorstep.',
            containerPadding:
                EdgeInsets.symmetric(horizontal: 50.w),
            textStyle: TextStyle(
              fontSize: 13.sp,
              fontFamily: 'Metropolis',
            ),
          ),
          SizedBox(height: 20.h),
          const MyThickButton(buttonText: 'login'),
          SizedBox(height: 15.h),
          const MyLightButton(
              buttonText: 'Create An Account'),
        ],
      ),
    );
  }
}
