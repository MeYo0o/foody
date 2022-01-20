import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foody/constants/colors.dart';
import 'package:foody/screens/widgets/common/my_text.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    Key? key,
    required this.socialTitle,
    required this.socialIcon,
    required this.socialColor,
  }) : super(key: key);

  final String socialTitle;
  final IconData socialIcon;
  final Color socialColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              socialIcon,
              size: 20.sp,
            ),
            SizedBox(width: 20.w),
            MyText(
              text: socialTitle,
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          primary: socialColor,
          padding: EdgeInsets.symmetric(vertical: 15.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.r),
          ),
          fixedSize: Size(307.w, 56.h),
        ),
        onPressed: () {},
      ),
    );
  }
}
