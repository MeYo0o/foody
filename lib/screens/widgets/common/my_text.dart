import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? containerPadding;
  final Alignment? containerAlignment;
  final TextAlign? textAlign;

  const MyText({
    Key? key,
    required this.text,
    this.fontSize,
    this.color,
    this.textStyle,
    this.containerPadding,
    this.containerAlignment,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: containerAlignment ?? Alignment.center,
      padding: containerPadding ?? EdgeInsets.zero,
      child: Text(
        text,
        style: textStyle ??
            GoogleFonts.poppins(
              color: color ?? Colors.black,
              fontSize: fontSize ?? 18.sp,
            ),
        textAlign: textAlign ?? TextAlign.center,
      ),
    );
  }
}
