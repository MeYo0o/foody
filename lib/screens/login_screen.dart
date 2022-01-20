import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foody/constants/colors.dart';
import 'package:foody/models/form_field_type.dart';
import 'package:foody/screens/widgets/common/my_button.dart';
import 'package:foody/screens/widgets/common/my_text.dart';
import 'package:foody/screens/widgets/common/social_button.dart';
import 'package:foody/screens/widgets/common/span_text.dart';
import 'package:get/get.dart';

import 'widgets/login_screen/my_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: () {
      //       Get.back();
      //     },
      //   ),
      // ),
      body: SizedBox(
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: kMainAppColor,
                    ),
                    iconSize: 40.sp,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                // SizedBox(height: 70.h),
                MyText(
                  text: 'Login',
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  color: kFontHeadColor,
                ),
                SizedBox(height: 20.h),
                const MyText(
                  text: 'Add your details to login',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: kFontBodyColor,
                ),
                SizedBox(height: 40.h),
                MyTextFormField(
                  controller: _email,
                  hintText: 'Your Email',
                  formFieldType: FormFieldType.email,
                ),
                SizedBox(height: 30.h),
                MyTextFormField(
                  controller: _password,
                  hintText: 'Your Password',
                  formFieldType: FormFieldType.password,
                ),
                SizedBox(height: 30.h),
                MyButton(
                  text: 'Login',
                  isPrimary: true,
                  func: () {},
                ),
                SizedBox(height: 30.h),
                MyText(
                  text: 'Forgot your password?',
                  fontWeight: FontWeight.w500,
                  color: kFontBodyColor,
                  fontSize: 14.sp,
                ),
                SizedBox(height: 50.h),
                MyText(
                  text: 'or Login With',
                  fontWeight: FontWeight.w500,
                  color: kFontBodyColor,
                  fontSize: 14.sp,
                ),
                SizedBox(height: 30.sp),
                const SocialButton(
                  socialTitle: 'Login With '
                      'Facebook',
                  socialIcon: FontAwesomeIcons.facebookF,
                  socialColor: kFacebookButtonColor,
                ),
                SizedBox(height: 30.sp),
                const SocialButton(
                  socialTitle: 'Login With '
                      'Google',
                  socialIcon: FontAwesomeIcons.google,
                  socialColor: kGoogleButtonColor,
                ),
                SizedBox(height: 30.h),
                const SpanText(
                    firstText: "Don't have an Account?",
                    secondText: 'Sign Up'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
