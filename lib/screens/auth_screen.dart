import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody/screens/login_screen.dart';
import 'package:foody/screens/signup_screen.dart';
import 'package:foody/screens/widgets/auth_screen/top_border_and_logo.dart';
import 'package:foody/screens/widgets/common/my_button.dart';
import 'package:foody/screens/widgets/common/my_text.dart';
import 'package:get/get.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TopBorderAndLogo(),
          SizedBox(height: 50.h),
          MyText(
            text: 'Discover the best foods from over 1,'
                '000 restaurants and fast delivery '
                'to your doorstep.',
            containerPadding:
                EdgeInsets.symmetric(horizontal: 50.w),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF7C7D7E),
          ),
          SizedBox(height: 50.h),
          MyButton(
            text: 'login',
            isPrimary: true,
            func: () {
              Get.to(() => const LoginScreen());
            },
          ),
          SizedBox(height: 15.h),
          MyButton(
            text: 'Create An Account',
            isPrimary: false,
            func: () {
              Get.to(() => const SignUpScreen());
            },
          ),
        ],
      ),
    );
  }
}
