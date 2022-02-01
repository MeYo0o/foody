import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foody/core/services/firestore_user.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class GeneralController extends GetxController {
  final user = FirebaseAuth.instance.currentUser;
  DocumentSnapshot<Object?>? userData;

  Future<void> getUserData() async {
    userData = await FirestoreUser().getCurrentUser(user?.uid as String);
  }

  //Image Picking & Cropping Logic for Android/iOS ----> Adjust the Image Quality Later
  Future<void> getPicThenUpload(ImageSource source) async {
    try {
      final XFile? pickedImage = await ImagePicker().pickImage(
        source: source,
        imageQuality: 100,
        maxWidth: 700,
      );
      if (pickedImage != null) {
        File? pickedFile = await ImageCropper.cropImage(
          sourcePath: pickedImage.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 70,
          maxHeight: 700,
          maxWidth: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: const AndroidUiSettings(
            toolbarColor: Colors.white,
            toolbarTitle: "Crop your image",
          ),
        );
        FirebaseStorage storage = FirebaseStorage.instance;
        //First we make the Storage Ref. ready for uploading
        final Reference ref = storage
            .ref()
            .child('email_type_users_profilePic')
            .child(user!.uid + '.jpg');

        //Second we pass the image file to the Storage Ref. to be uploaded
        await ref.putFile(File(pickedImage.path)).whenComplete(() => null);

        //Third ... get the download link of that file
        final imageUrl = await ref.getDownloadURL();

        //Fourth & Finally ... update the user db imageUrl
        await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
          'imageUrl': imageUrl,
        });

        //----END of Profile Image Uploading-----//

        // OLD - CODE //
        // return pickedFile;
        //Upload the Profile Pic
        // firebase_storage.FirebaseStorage storage =
        //     firebase_storage.FirebaseStorage.instance;
        // //Email Type Users bucket "email_type_users_profilePic"
        // firebase_storage.Reference profPicRef = storage
        //     .ref()
        //     .child('email_type_users_profilePic')
        //     .child(userData!['id'].jpeg);
        //
        // File file = File(pickedImage.path);
        //
        // try {
        //   await firebase_storage.FirebaseStorage.instance
        //       .ref('email_type_users_profilePic/${userData!['id'].png}')
        //       .putFile(file);
        // } on FirebaseException catch (e) {
        //   print(e);
        //   // e.g, e.code == 'canceled'
        // }
        //
        // String imageUrl = await firebase_storage.FirebaseStorage.instance
        //     .ref()
        //     .child('email_type_users_profilePic')
        //     .child(userData!['id'].jpeg)
        //     .getDownloadURL();
        // final firestore = FirebaseFirestore.instance;
        // await firestore.collection('users').doc(userData!['id']).update({
        //   'imageUrl': imageUrl,
        // });
      }
    } catch (err) {
      // print(err);
    } finally {}
  }
}
