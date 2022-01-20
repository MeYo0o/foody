import 'package:flutter/material.dart';
import 'package:foody/constants/colors.dart';

class SpanText extends StatelessWidget {
  const SpanText({
    Key? key,
    required this.firstText,
    required this.secondText,
  }) : super(key: key);

  final String firstText;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: firstText,
            style: const TextStyle(
              color: kFontBodyColor,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: 'Metropolis',
            ),
          ),
          const TextSpan(text: ' '),
          TextSpan(
            text: secondText,
            style: const TextStyle(
              color: kMainAppColor,
              fontWeight: FontWeight.w700,
              fontSize: 14,
              fontFamily: 'Metropolis',
            ),
          ),
        ],
      ),
    );
  }
}
