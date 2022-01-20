import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody/constants/colors.dart';
import 'package:foody/models/form_field_type.dart';
import 'package:foody/screens/widgets/common/my_button.dart';
import 'package:foody/screens/widgets/common/my_text.dart';
import 'package:foody/screens/widgets/login_screen/my_text_form_field.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  _NewPasswordScreenState createState() =>
      _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController _password =
      TextEditingController();
  final TextEditingController _confirmPassword =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w),
                    child: const MyText(
                      text:
                          'Please enter your email to receive a  link to  create a new password via email',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kFontBodyColor,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  MyTextFormField(
                    controller: _password,
                    hintText: 'New Password',
                    formFieldType: FormFieldType.password,
                  ),
                  SizedBox(height: 25.h),
                  MyTextFormField(
                    controller: _confirmPassword,
                    hintText: 'Confirm Password',
                    formFieldType: FormFieldType.password,
                  ),
                  SizedBox(height: 40.h),
                  MyButton(
                    text: 'Next',
                    isPrimary: true,
                    func: () {},
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
