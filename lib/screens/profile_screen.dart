import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foody/constants/colors.dart';
import 'package:foody/controllers/general_controller.dart';
import 'package:foody/screens/widgets/common/my_text.dart';
import 'package:foody/screens/widgets/profile_screen/profile_text_field.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (genC) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 50.h),
                MyText(
                  text: 'Profile',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  containerAlignment: Alignment.topLeft,
                ),
                SizedBox(height: 10.h),
                if (genC.userData!['imageUrl'] == 'default')
                  Center(
                    child: InkWell(
                      onTap: () {
                        genC.getProfPicNUpload(ImageSource.camera);
                      },
                      child: CircleAvatar(
                        // backgroundColor: Colors.transparent,
                        radius: 70.r,
                        child: Stack(
                          children: [
                            Image.asset('assets/images/default_avatar.png'),
                            Positioned(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20.r),
                                    bottomRight: Radius.circular(20.r),
                                  ),
                                ),
                                height: 30.h,
                                width: 70.w,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 25.sp,
                                  color: Colors.white,
                                ),
                              ),
                              top: 103.h,
                              left: 17.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 14.h),
                InkWell(
                  onTap: () {
                    //TODO - Go to Edit Profile Screen
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.pen,
                        size: 12.sp,
                        color: kMainAppColor,
                      ),
                      SizedBox(width: 5.w),
                      MyText(
                        text: 'Edit Profile',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: kMainAppColor,
                        containerPadding: EdgeInsets.only(
                          top: 4.h,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14.h),
                MyText(
                  text: 'Hi there ' + genC.userData!['name'] + '!',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  containerPadding: EdgeInsets.symmetric(horizontal: 80.w),
                ),
                SizedBox(height: 50.h),
                const ProfileTextField(
                  label: 'Name',
                  dbField: 'name',
                ),
                SizedBox(height: 20.h),
                const ProfileTextField(
                  label: 'Email',
                  dbField: 'email',
                ),
                SizedBox(height: 20.h),
                const ProfileTextField(
                  label: 'Address',
                  dbField: 'address',
                ),
                SizedBox(height: 20.h),
                const ProfileTextField(
                  label: 'Mobile Number',
                  dbField: 'mobileNumber',
                ),
                SizedBox(height: 20.h),
                const ProfileTextField(
                  label: 'Points',
                  dbField: 'points',
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
