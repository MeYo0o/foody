import 'package:flutter/material.dart';
import 'package:foody/screens/widgets/intro_screen/intro_page.dart';
import 'package:get/get.dart';

class IntroController extends GetxController {
  final _pageController = PageController(
    initialPage: 0,
    viewportFraction: 1.0,
    keepPage: true,
  );

  PageController get pageController => _pageController;

  late final List<Widget> _pages = [
    IntroPage(
      pageController: pageController,
      imagePath: 'assets/images/intro1.png',
      headText: 'Find Food You Love',
      bodyText:
          'Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep',
      nextPageIndex: 1,
    ),
    IntroPage(
      pageController: pageController,
      imagePath: 'assets/images/intro2.png',
      headText: 'Fast Delivery',
      bodyText:
          'Fast food delivery to your home, office wherever you are',
      nextPageIndex: 2,
    ),
    IntroPage(
      pageController: pageController,
      imagePath: 'assets/images/intro3.png',
      headText: 'Live Tracking',
      bodyText:
          'Real time tracking of your food on the app once you placed the order',
      nextPageIndex: 3,
    ),
  ];

  List<Widget> get pages => _pages;

  @override
  void dispose() {
    pageController.dispose();
    pages.clear();
    super.dispose();
  }
}
