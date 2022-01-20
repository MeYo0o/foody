import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:foody/screens/navigation_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthType {
  emailSignIn,
  googleSignIn,
  facebookSignIn,
}

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthType _signInType = AuthType.emailSignIn;

  late final Rxn<User?> _user;
  User? get user => _user.value;

  @override
  void onInit() {
    _user.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  //Google SignIn
  void signInWithGoogle() async {
    //define signIn Method
    _signInType = AuthType.googleSignIn;
    try {
      //Trigger the authentication flow
      final googleUser = await GoogleSignIn().signIn();
      // print(googleUser);

      //obtain the auth details from the user
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      //create a new credential for the user's device
      final AuthCredential googleAuthCredential =
          GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // print(credential);

      // await _auth
      //     .signInWithCredential(googleAuthCredential)
      //     .then((UserCredential userCredential) async =>
      //         await _saveUserToFirestore(userCredential));
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthException(e.code);
    } on PlatformException catch (e) {
      handleFirebaseAuthException(e.code);
      return;
    } catch (e) {
      //print(e);
    }
  }

  void signInWithFacebook() async {
    //define signIn Method
    _signInType = AuthType.facebookSignIn;

    try {
      // Trigger the sign-in flow
      final LoginResult loginResult =
          await FacebookAuth.instance.login();

      if (loginResult.accessToken != null) {
        // Create a credential from the access token
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(
                loginResult.accessToken!.token);

        //TODO : Once signed in, return the UserCredential
        // await _auth
        //     .signInWithCredential(facebookAuthCredential)
        //     .then((UserCredential userCredential) async =>
        //         await _saveUserToFirestore(userCredential));
      }
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthException(e.code);
    } on PlatformException catch (e) {
      handleFirebaseAuthException(e.code);
    } catch (e) {
      //print(e);
    }
  }

  //email & password
  Future<void> signInWithEmailAndPassword(
      String email, String password) async {
    //define signIn Method
    _signInType = AuthType.emailSignIn;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      )
          .then((credentials) async {
        //in case the user deleted the app along with it's local data
        // or signed out and lost his/her local data
        // he needs it back
        //first we retrieve the data from the cloud
        // await FirestoreUser()
        //     .getCurrentUser(credentials.user!.uid)
        //     .then((userDocumentSnapshot) async {
        //   // print('UserData : ${userDocumentSnapshot.data()}');
        //   await _localDataStorage.setUserData(UserModel.fromJson(
        //       userDocumentSnapshot.data()
        //           as Map<String, dynamic>?));
        // });
        return credentials;
      });
      //TODO : Navigate to Control View
      // Get.offAll(() => const LoginControlView());
      // print(userCredential);
    } on SocketException {
      //print('network error');
      return;
    } on FirebaseAuthException catch (e) {
      // if (e.code == 'user-not-found') {
      //   print('No user found for that email.');
      // } else if (e.code == 'wrong-password') {
      //   print('Wrong password provided for that user.');
      // }
      // Get.snackbar(
      //   'Error : ',
      //   e.code,
      //   colorText: Colors.black,
      //   snackPosition: SnackPosition.BOTTOM,
      // );
      handleFirebaseAuthException(e.code);
    }
  }

  void signUpWithEmailAndPassword() async {
    // //define signIn Method
    // _signInType = AuthType.emailSignIn;
    // try {
    //   await FirebaseAuth.instance
    //       .createUserWithEmailAndPassword(
    //         email: email!.trim(),
    //         password: password!,
    //       )
    //       .then((UserCredential userCredential) async =>
    //           await _saveUserToFirestore(userCredential));
    //
    //   //Navigate to Home View
    //   Get.offAll(() => const LoginControlView());
    // } on FirebaseAuthException catch (e) {
    //   // if (e.code == 'weak-password') {
    //   //   print('The password provided is too weak.');
    //   // } else if (e.code == 'email-already-in-use') {
    //   //   print('The account already exists for that email.');
    //   // }
    //   handleFirebaseAuthException(e.code);
    // } catch (e) {
    //   //print(e);
    // }
  }
  //
  // Future<void> _saveUserToFirestore(
  //     UserCredential userCredential) async {
  //   final UserModel userModel = UserModel(
  //     userId: userCredential.user?.uid,
  //     name: name ?? userCredential.user?.displayName,
  //     email: userCredential.user?.email,
  //     profilePic: _signInType == AuthType.emailSignIn
  //         ? 'default'
  //         //google login
  //         : _signInType == AuthType.googleSignIn
  //             ? userCredential.user?.photoURL
  //                 ?.replaceAll('s96-c', 's400-c')
  //                 .toString()
  //             //facebook login
  //             : '${userCredential.user?.photoURL}?height=500',
  //   );
  //
  //   // print(userCredential.user?.photoURL);
  //
  //   //TODO : Save the userData to the CloudFireStore
  //   // await FirestoreUser().addUserToFirestore(userModel);
  //   //TODO :Save the userData to the LocalDataStorage Too
  //   // await _saveUserToLocalStorage(userModel);
  // }
  //
  // Future<void> _saveUserToLocalStorage(
  //     UserModel userModel) async {
  //   await _localDataStorage.setUserData(userModel);
  // }

  //FirebaseException Handling
  static void handleFirebaseAuthException(String? errorCode) {
    String? errorMessage;
    switch (errorCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        errorMessage = "Email already used.";
        break;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        errorMessage = "Wrong email/password combination.";
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        errorMessage = "No user found with this email.";
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        errorMessage = "User disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        errorMessage =
            "Too many requests to log into this account.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        errorMessage = "Server error, please try again later.";
        break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        errorMessage = "Email address is invalid.";
        break;
      default:
        errorMessage =
            "Login failed. Please Check your Internet Connetion.";
        break;
    }
    Get.snackbar(
      'Error : ',
      errorMessage,
      colorText: Colors.black,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void signOut() {
    //sign out from google account
    GoogleSignIn().signOut();
    //sign out from email/password
    _auth.signOut();
    //clear the local user data storage
    //TODO - Some Localstorage clear here
    //reset the state user value so we can go back to the login screen
    _user.value = null;
    //print(user);
    Get.offAll(() => const NavigationScreen());
  }
}
