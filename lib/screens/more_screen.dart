import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foody/screens/widgets/common/my_text.dart';
import 'package:foody/screens/widgets/more_screen/my_more_item.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 70.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    text: 'More',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                  ),
                  const Icon(Icons.shopping_cart),
                ],
              ),
              SizedBox(height: 40.h),
              MyMoreItem(
                iconData: FontAwesomeIcons.handHoldingUsd,
                text: 'Payment'
                    ' Details',
                func: () {},
              ),
              SizedBox(height: 15.h),
              MyMoreItem(
                iconData: FontAwesomeIcons.shoppingBag,
                text: 'My Orders',
                func: () {},
              ),
              SizedBox(height: 15.h),
              MyMoreItem(
                iconData: FontAwesomeIcons.solidBell,
                text: 'Notifications',
                notificationNumber: 15,
                func: () {},
              ),
              SizedBox(height: 15.h),
              MyMoreItem(
                iconData: FontAwesomeIcons.solidEnvelope,
                text: 'Inbox',
                func: () {},
              ),
              SizedBox(height: 15.h),
              MyMoreItem(
                iconData: FontAwesomeIcons.infoCircle,
                text: 'About Us',
                func: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
