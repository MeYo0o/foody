import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foody/controllers/auth_controller.dart';
import 'package:foody/controllers/general_controller.dart';
import 'package:foody/core/services/firestore_user.dart';
import 'package:foody/screens/widgets/common/my_text.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(
      builder: (genC) {
        return Scaffold(
          appBar: AppBar(
            title: const MyText(text: 'Home Screen'),
          ),
          body: Center(
            child: ElevatedButton(
              child: const Text('Test Button'),
              onPressed: () {},
            ),
          ),
        );
      },
    );
  }
}
