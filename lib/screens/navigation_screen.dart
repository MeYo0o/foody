import 'package:flutter/material.dart';
import 'package:foody/controllers/auth_controller.dart';
import 'package:foody/controllers/navigation_controller.dart';
import 'package:foody/screens/auth_screen.dart';
import 'package:foody/screens/email_verification_screen.dart';
import 'package:foody/screens/home_screen.dart';
import 'package:foody/screens/splash_screen.dart';
import 'package:get/get.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      init: AuthController(),
      builder: (authC) {
        return authC.user != null
            ? const EmailVerificationScreen()
            : GetBuilder<NavigationController>(
                init: NavigationController(),
                builder: (navC) {
                  return FutureBuilder(
                    future: navC.appInitialization(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SplashScreen();
                      }
                      return const AuthScreen();
                    },
                  );
                },
              );
      },
    );
  }
}
