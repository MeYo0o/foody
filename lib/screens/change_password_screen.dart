import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody/constants/colors.dart';
import 'package:foody/controllers/auth_controller.dart';
import 'package:foody/models/form_field_type.dart';
import 'package:foody/screens/widgets/common/my_button.dart';
import 'package:foody/screens/widgets/common/my_text.dart';
import 'package:foody/screens/widgets/login_screen/my_text_form_field.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _currentPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (authC) {
          return Scaffold(
            body: SizedBox(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 70.h),
                      MyText(
                        text: 'New Password',
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                        color: kFontHeadColor,
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: MyText(
                          text:
                              'Please enter your email to receive a  link to  create a new password via email',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: kFontBodyColor,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      MyTextFormField(
                        controller: _currentPassword,
                        hintText: 'Current Password',
                        formFieldType: FormFieldType.password,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 25.h),
                      MyTextFormField(
                        controller: _newPassword,
                        hintText: 'New Password',
                        formFieldType: FormFieldType.password,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 25.h),
                      MyTextFormField(
                        controller: _confirmPassword,
                        passwordController: _newPassword,
                        hintText: 'Confirm New Password',
                        formFieldType: FormFieldType.password,
                      ),
                      SizedBox(height: 40.h),
                      MyButton(
                        text: 'Change Password',
                        isPrimary: true,
                        func: () {
                          final currentScope = FocusScope.of(context);
                          if (currentScope.hasPrimaryFocus) {
                            currentScope.unfocus();
                          }
                          final isValid = _formKey.currentState!.validate();

                          if (isValid) {
                            authC.changePassword(
                              _currentPassword.text,
                              _newPassword.text,
                            );
                          }
                        },
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
