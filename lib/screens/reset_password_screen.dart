import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody/constants/colors.dart';
import 'package:foody/models/form_field_type.dart';
import 'package:foody/screens/widgets/common/my_button.dart';
import 'package:foody/screens/widgets/common/my_text.dart';
import 'package:foody/screens/widgets/login_screen/my_text_form_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState
    extends State<ResetPasswordScreen> {
  final TextEditingController _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 70.h),
                MyText(
                  text: 'Reset Password',
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  color: kFontHeadColor,
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.w),
                  child: const MyText(
                    text: 'Please enter your email to receive a '
                        'link to  create a new password via email',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kFontBodyColor,
                  ),
                ),
                SizedBox(height: 80.h),
                MyTextFormField(
                  controller: _email,
                  hintText: 'Email',
                  formFieldType: FormFieldType.email,
                ),
                SizedBox(height: 40.h),
                MyButton(
                  text: 'Send',
                  isPrimary: true,
                  func: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
