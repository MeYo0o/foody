import 'package:flutter/material.dart';
import 'package:foody/controllers/intro_controller.dart';
import 'package:get/get.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<IntroController>(
        builder: (introC) {
          return PageView.builder(
            controller: introC.pageController,
            itemCount: introC.pages.length,
            itemBuilder: (_, index) => introC.pages[index],
          );
        },
      ),
    );
  }
}
