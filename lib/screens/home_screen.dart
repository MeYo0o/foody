import 'package:flutter/material.dart';
import 'package:foody/controllers/auth_controller.dart';
import 'package:foody/controllers/general_controller.dart';
import 'package:foody/screens/widgets/common/loading_widget.dart';
import 'package:foody/screens/widgets/common/my_text.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (authC) {
        return GetBuilder<GeneralController>(
          init: GeneralController(),
          builder: (genC) {
            return Scaffold(
              appBar: AppBar(
                title: const MyText(text: 'Home Screen'),
              ),
              body: authC.isLoading
                  ? const LoadingWidget()
                  : Center(
                      child: ElevatedButton(
                        child: const Text('Logout'),
                        onPressed: () async {
                          await authC.signOut();
                          // await authC.verifyMobileNumber();
                        },
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}
