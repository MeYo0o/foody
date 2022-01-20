import 'package:flutter/material.dart';
import 'package:foody/constants/colors.dart';
import 'package:foody/controllers/intro_controller.dart';
import 'package:foody/screens/widgets/intro_screen/intro_page.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<IntroController>(builder: (introC) {
        return PageView.builder(
          controller: introC.pageController,
          itemCount: introC.pages.length,
          itemBuilder: (_, index) => introC.pages[index],
        );
      }),
    );
  }
}
