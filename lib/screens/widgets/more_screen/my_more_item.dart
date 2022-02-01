import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foody/constants/colors.dart';
import 'package:foody/screens/widgets/common/my_text.dart';

class MyMoreItem extends StatelessWidget {
  const MyMoreItem({
    Key? key,
    required this.iconData,
    required this.text,
    required this.func,
    this.notificationNumber,
  }) : super(key: key);

  final IconData iconData;
  final String text;
  final int? notificationNumber;
  final void Function() func;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              height: 75.h,
              decoration: BoxDecoration(
                color: kContainerBGColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: kContainerIconBGColor,
                      radius: 50.r,
                      child: Icon(
                        iconData,
                        color: kContainerIconColor,
                      ),
                    ),
                    SizedBox(width: 20.w),
                    MyText(
                      text: text,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    const Spacer(),
                    if (text == 'Notifications') ...[
                      CircleAvatar(
                        radius: 10.r,
                        backgroundColor: Colors.red,
                        child: MyText(
                          text: notificationNumber.toString(),
                          fontSize: 13.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            // width: 20.w,
            decoration: BoxDecoration(
              color: kContainerBGColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
            ),
            child: const Icon(
              Icons.arrow_forward_ios,
              color: kFontBodyColor,
            ),
          ),
        ],
      ),
    );
  }
}
