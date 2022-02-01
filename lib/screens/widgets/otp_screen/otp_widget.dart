import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody/constants/colors.dart';
import 'package:foody/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeVerificationWidget extends StatefulWidget {
  const PinCodeVerificationWidget({Key? key}) : super(key: key);

  @override
  _PinCodeVerificationWidgetState createState() => _PinCodeVerificationWidgetState();
}

class _PinCodeVerificationWidgetState extends State<PinCodeVerificationWidget> {
  late final onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  late StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: PinCodeTextField(
        appContext: context,
        pastedTextStyle: TextStyle(
          color: Colors.yellow.shade600,
          fontWeight: FontWeight.bold,
        ),
        length: 6,
        obscureText: false,
        obscuringCharacter: '*',
        animationType: AnimationType.fade,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        // textInputAction: TextInputAction.next,
        validator: (v) {
          if (v!.length < 6) {
            return "OTP is not completed";
          } else {
            return null;
          }
        },
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5.r),
          fieldHeight: 60.h,
          fieldWidth: 50.w,
          activeFillColor: hasError ? Colors.orange : Colors.white,
          inactiveColor: kRegularFontColor,
          activeColor: kMainAppColor,
          selectedColor: kMainAppColor,
        ),
        cursorColor: Colors.black,
        animationDuration: const Duration(milliseconds: 300),
        textStyle: TextStyle(fontSize: 20.sp, height: 1.6.h),
        // backgroundColor: Colors.blue.shade50,
        // enableActiveFill: true,

        errorAnimationController: errorController,
        controller: textEditingController,
        keyboardType: TextInputType.number,
        boxShadows: const [
          BoxShadow(
            offset: Offset(0, 0),
            color: Colors.black12,
            blurRadius: 10,
          )
        ],
        onCompleted: (v) {
          // print("Completed");
          final authC = Get.find<AuthController>();
        },
        // onTap: () {
        //   print("Pressed");
        // },
        onChanged: (value) {
          // print(value);
          setState(() {
            currentText = value;
          });
        },
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
          return true;
        },
      ),
    );
  }
}
