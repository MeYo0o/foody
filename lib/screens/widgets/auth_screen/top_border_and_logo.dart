import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopBorderAndLogo extends StatelessWidget {
  const TopBorderAndLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 485.h,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/orange_top_shape.png',
            height: 382.h,
            width: 375.w,
            fit: BoxFit.cover,
          ),
          Positioned(
            child: Image.asset('assets/images/logo.png'),
            height: 185.h,
            width: 218.w,
            top: 300.h,
            left: 80.w,
          ),
        ],
      ),
    );
  }
}
