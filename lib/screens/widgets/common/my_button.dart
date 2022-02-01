import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'my_text.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.text,
    required this.isPrimary,
    required this.func,
  }) : super(key: key);

  final String text;
  final bool isPrimary;
  final void Function()? func;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ElevatedButton(
        child: MyText(
          text: text,
          color: isPrimary ? Colors.white : const Color(0xFFFC6011),
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        style: ElevatedButton.styleFrom(
          primary: isPrimary ? const Color(0xFFFC6011) : Colors.white,
          padding: EdgeInsets.symmetric(vertical: 15.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.r),
            side: isPrimary
                ? BorderSide.none
                : const BorderSide(color: Color(0xFFFC6011)),
          ),
          fixedSize: Size(307.w, 56.h),
        ),
        onPressed: func,
      ),
    );
  }
}
