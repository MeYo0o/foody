import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'my_text.dart';

class MyLightButton extends StatelessWidget {
  const MyLightButton({
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
          color: const Color(0xFFFC6011),
          fontSize: 16.sp,
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 15.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.r),
            side: const BorderSide(
              color: Color(0xFFFC6011),
            ),
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
