import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody/constants/colors.dart';
import 'package:foody/models/form_field_type.dart';
import 'package:foody/screens/widgets/common/my_button.dart';
import 'package:foody/screens/widgets/common/my_text.dart';
import 'package:foody/screens/widgets/common/span_text.dart';
import 'package:foody/screens/widgets/login_screen/my_text_form_field.dart';
import 'package:foody/screens/widgets/otp_screen/otp_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _formKey = GlobalKey<FormState>();
  var onTapRecognizer;

  TextEditingController textEditingController =
      TextEditingController();
  // ..text = "123456";

  late StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 70.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: MyText(
                  text: 'We have sent an OTP to your Mobile',
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  color: kFontHeadColor,
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: const MyText(
                  text:
                      'Please check your mobile number 071*****12 continue to reset your password',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: kFontBodyColor,
                ),
              ),
              SizedBox(height: 60.h),
              const PinCodeVerificationScreen(),
              SizedBox(height: 45.h),
              MyButton(
                text: 'Next',
                isPrimary: true,
                func: () {},
              ),
              SizedBox(height: 30.h),
              const SpanText(
                firstText: "Didn't Receive?",
                secondText: 'Click Here',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
