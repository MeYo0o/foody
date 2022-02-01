import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody/constants/colors.dart';
import 'package:foody/controllers/auth_controller.dart';
import 'package:foody/models/form_field_type.dart';
import 'package:foody/screens/home_screen.dart';
import 'package:foody/screens/widgets/common/loading_widget.dart';
import 'package:get/get.dart';

import 'widgets/common/my_button.dart';
import 'widgets/common/my_text.dart';
import 'widgets/login_screen/my_text_form_field.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool init = true;

  @override
  void initState() {
    super.initState();
    if (init) {
      final authC = Get.find<AuthController>();
      if (!authC.user!.emailVerified) {
        authC.sendVerificationEmail();
        authC.getEmailVerificationStatus();
      }
      init = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (authC) {
        return Scaffold(
          body: authC.user!.emailVerified
              ? const HomeScreen()
              : SizedBox(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 70.h),
                        MyText(
                          text: 'Email Verification',
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w700,
                          color: kFontHeadColor,
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: MyText(
                            text: 'We have sent you a verification email , please '
                                'verify and come back here',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: kFontBodyColor,
                          ),
                        ),
                        SizedBox(height: 40.h),
                        MyButton(
                          text: 'Resend Email',
                          isPrimary: true,
                          func: authC.canResendEmailVerification
                              ? () async {
                                  final currentScope = FocusScope.of(context);
                                  if (currentScope.hasPrimaryFocus) {
                                    currentScope.unfocus();
                                  }
                                  await authC.sendVerificationEmail();
                                }
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
