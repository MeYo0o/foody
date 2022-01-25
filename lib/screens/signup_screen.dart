import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody/constants/colors.dart';
import 'package:foody/controllers/auth_controller.dart';
import 'package:foody/models/form_field_type.dart';
import 'package:foody/screens/login_screen.dart';
import 'package:foody/screens/widgets/common/my_button.dart';
import 'package:foody/screens/widgets/common/my_text.dart';
import 'package:foody/screens/widgets/common/span_text.dart';
import 'package:foody/screens/widgets/login_screen/my_text_form_field.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  // final TextEditingController _name = TextEditingController();
  //
  // final TextEditingController _email = TextEditingController();
  // final TextEditingController _mobileNumber =
  //     TextEditingController();
  // final TextEditingController _address = TextEditingController();
  // final TextEditingController _password =
  //     TextEditingController();
  // final TextEditingController _confirmPassword =
  //     TextEditingController();
  //
  // final _formKey = GlobalKey<FormState>();

  // @override
  // void dispose() {
  //   _name.dispose();
  //   _email.dispose();
  //   _address.dispose();
  //   _mobileNumber.dispose();
  //   _password.dispose();
  //   _confirmPassword.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (authC) {
          return Scaffold(
            body: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Form(
                  key: authC.signupFormKey,
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
                      // SizedBox(height: 10.h),
                      MyText(
                        text: 'Sign Up',
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                        color: kFontHeadColor,
                      ),
                      SizedBox(height: 18.h),
                      const MyText(
                        text: 'Add your details to Sign up',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: kFontBodyColor,
                      ),
                      SizedBox(height: 18.h),
                      MyTextFormField(
                        controller: authC.signupName,
                        hintText: 'Name',
                        formFieldType: FormFieldType.text,
                      ),
                      SizedBox(height: 18.h),
                      MyTextFormField(
                        controller: authC.signupEmail,
                        hintText: 'Email',
                        formFieldType: FormFieldType.text,
                      ),
                      SizedBox(height: 18.h),
                      MyTextFormField(
                        controller: authC.signupMobileNumber,
                        hintText: 'Mobile No',
                        formFieldType: FormFieldType.number,
                      ),
                      SizedBox(height: 18.h),
                      MyTextFormField(
                        controller: authC.signupAddress,
                        hintText: 'Address',
                        formFieldType: FormFieldType.text,
                      ),
                      SizedBox(height: 18.h),
                      MyTextFormField(
                        controller: authC.signupPassword,
                        hintText: 'Password',
                        formFieldType: FormFieldType.password,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 18.h),
                      MyTextFormField(
                        controller: authC.signupConfirmPassword,
                        passwordController: authC.signupPassword,
                        hintText: 'Confirm Password',
                        formFieldType: FormFieldType.password,
                      ),
                      SizedBox(height: 25.h),
                      MyButton(
                        text: 'Sign Up',
                        isPrimary: true,
                        func: () {
                          final bool isValid = authC
                              .signupFormKey.currentState!
                              .validate();
                          if (isValid) {
                            // print('signing up...');
                            authC.signUpWithEmailAndPassword();
                          }
                        },
                      ),
                      SizedBox(height: 25.h),
                      InkWell(
                        onTap: () {
                          Get.off(() => const LoginScreen());
                        },
                        child: const SpanText(
                          firstText: 'Already have an Account?',
                          secondText: 'Login',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
