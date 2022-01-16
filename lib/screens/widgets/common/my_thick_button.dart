import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'my_text.dart';

class MyThickButton extends StatelessWidget {
  const MyThickButton({
    Key? key,
    required this.buttonText,
  }) : super(key: key);

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ElevatedButton(
        child: MyText(
          text: buttonText,
          color: Colors.white,
          fontSize: 16.sp,
        ),
        style: ElevatedButton.styleFrom(
          primary: const Color(0xFFFC6011),
          padding: EdgeInsets.symmetric(vertical: 15.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.r),
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
