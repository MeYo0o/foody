import 'package:flutter/material.dart';
import 'package:foody/constants/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: kMainAppColor,
        ),
      ),
    );
  }
}
