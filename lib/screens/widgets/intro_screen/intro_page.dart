import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody/constants/colors.dart';
import 'package:foody/constants/text_styles.dart';
import 'package:foody/screens/home_screen.dart';
import 'package:foody/screens/widgets/common/my_button.dart';
import 'package:foody/screens/widgets/common/my_text.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({
    Key? key,
    required this.pageController,
    required this.imagePath,
    required this.headText,
    required this.bodyText,
    required this.nextPageIndex,
  }) : super(key: key);

  final PageController pageController;
  final String imagePath;
  final String headText;
  final String bodyText;
  final int nextPageIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 100.h),
            Image.asset(
              imagePath,
              height: 350.h,
              width: 250.w,
              // fit: BoxFit.cover,
            ),
            SizedBox(height: 30.h),
            SmoothPageIndicator(
              controller: pageController,
              count: 3,
              onDotClicked: (index) {
                pageController.jumpToPage(index);
              },
              effect: JumpingDotEffect(
                spacing: 8.0.w,
                radius: 15.0.r,
                dotWidth: 15.0.r,
                dotHeight: 15.0.h,
                paintStyle: PaintingStyle.stroke,
                strokeWidth: 1.5.r,
                dotColor: Colors.grey,
                activeDotColor: kMainAppColor,
              ),
            ),
            SizedBox(height: 40.h),
            MyText(
              text: headText,
              textStyle: kHeadFontTextStyle,
            ),
            SizedBox(height: 20.h),
            MyText(
              text: bodyText,
              textStyle: kBodyFontTextStyle,
              containerPadding:
                  EdgeInsets.symmetric(horizontal: 40.w),
            ),
            SizedBox(height: 50.h),
            MyButton(
              text: 'Next',
              isPrimary: true,
              func: () {
                if (nextPageIndex == 1 || nextPageIndex == 2) {
                  pageController.animateToPage(
                    nextPageIndex,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                } else {
                  Get.offAll(() => const HomeScreen());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
