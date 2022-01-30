import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody/constants/colors.dart';
import 'package:foody/constants/text_styles.dart';
import 'package:foody/controllers/general_controller.dart';
import 'package:get/get.dart';

class ProfileTextField extends StatelessWidget {
  const ProfileTextField({
    Key? key,
    required this.label,
    required this.dbField,
  }) : super(key: key);

  final String label;
  final String dbField;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (genC) {
      final field = genC.userData![dbField].toString();
      return TextField(
        enabled: false,
        controller: TextEditingController(
          text: dbField == 'mobileNumber' ? '0' + field : field,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: kBodyFontTextStyle.copyWith(
            fontSize: 18.sp,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          filled: true,
          fillColor: kTextFormFillColor,
        ),
      );
    });
  }
}
