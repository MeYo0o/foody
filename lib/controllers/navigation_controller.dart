import 'package:flutter/material.dart';
import 'package:foody/screens/auth_screen.dart';
import 'package:foody/screens/email_verification_screen.dart';
import 'package:foody/screens/splash_screen.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  //wait for initialization then go for Auth Screen
  Future<void> appInitialization() async {
    await Future.delayed(const Duration(seconds: 2));
    getCurrentScreen(1);
  }

  //First Screen as currentScreen
  // Widget _currentScreen = const SplashScreen();
  // int _screenIndex = 0;
  // int get screenIndex => _screenIndex;

  //get the current screen
  Widget getCurrentScreen(int screenIndex) {
    switch (screenIndex) {
      case 0:
        return const SplashScreen();
      case 1:
        return const AuthScreen();
      default:
        return const SplashScreen();
    }
  }
}
