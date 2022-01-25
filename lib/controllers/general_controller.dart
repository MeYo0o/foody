import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foody/core/services/firestore_user.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart'
    as firebase_storage;

class GeneralController extends GetxController {
  final user = FirebaseAuth.instance.currentUser;
  var userData;

  @override
  void onInit() async {
    super.onInit();
    userData = await FirestoreUser()
        .getCurrentUser(user?.uid as String);
    print(userData['id']);
  }

  //Image Picking & Cropping Logic for Android/iOS ----> Adjust the Image Quality Later
  Future<File?> getProfPicNUpload(
      ImageSource source) async {
    try {
      final PickedFile? pickedImage =
          await ImagePicker().getImage(
        source: source,
        imageQuality: 100,
        maxWidth: 700,
      );
      if (pickedImage != null) {
        File? pickedFile;
        pickedFile = await ImageCropper.cropImage(
          sourcePath: pickedImage.path,
          aspectRatio:
              const CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 70,
          maxHeight: 700,
          maxWidth: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: const AndroidUiSettings(
            toolbarColor: Colors.white,
            toolbarTitle: "Crop your image",
          ),
        );
        // return pickedFile;
        //Upload the Profile Pic
        firebase_storage.FirebaseStorage storage =
            firebase_storage.FirebaseStorage.instance;
        //Email Type Users bucket "email_type_users_profilePic"
        firebase_storage.Reference profPicRef = storage
            .ref()
            .child('email_type_users_profilePic')
            .child(userData['id'].jpeg);

        String imageUrl = await firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('email_type_users_profilePic')
            .child(userData['id'].jpeg)
            .getDownloadURL();
        final firestore = FirebaseFirestore.instance;
        await firestore
            .collection('users')
            .doc(userData['id'])
            .update({
          'imageUrl': imageUrl,
        });
      }
    } catch (err) {
      print(err);
    } finally {}
  }
}
