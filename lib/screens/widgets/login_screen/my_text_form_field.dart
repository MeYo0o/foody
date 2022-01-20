import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody/constants/colors.dart';
import 'package:foody/models/form_field_type.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.formFieldType,
    this.textInputAction,
    this.padding,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final FormFieldType formFieldType;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 30.w),
      child: TextFormField(
        controller: controller,
        cursorColor: kMainAppColor,
        keyboardType: formFieldType == FormFieldType.email
            ? TextInputType.emailAddress
            : formFieldType == FormFieldType.number
                ? TextInputType.number
                : TextInputType.text,
        obscureText: formFieldType == FormFieldType.password
            ? true
            : false,
        textInputAction: textInputAction ??
            (formFieldType == FormFieldType.password
                ? TextInputAction.done
                : TextInputAction.next),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.sp),
            borderSide: const BorderSide(
              color: kTextFormFillColor,
              width: 5,
            ),
          ),
          focusColor: kMainAppColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.sp),
            borderSide: const BorderSide(
              color: kMainAppColor,
            ),
          ),
          filled: true,
          fillColor: kTextFormFillColor,
          contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w, vertical: 20.h),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: kRegularFontColor,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            fontFamily: 'Metropolis',
          ),
        ),
      ),
    );
  }
}
