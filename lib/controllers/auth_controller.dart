import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:foody/constants/colors.dart';
import 'package:foody/core/services/firestore_user.dart';
import 'package:foody/models/user_model.dart';
import 'package:foody/screens/home_screen.dart';
import 'package:foody/screens/navigation_screen.dart';
import 'package:foody/screens/widgets/common/my_text.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthType {
  emailSignIn,
  googleSignIn,
  facebookSignIn,
}

class AuthController extends GetxController {
  //Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthType _signInType = AuthType.emailSignIn;
  final Rxn<User> _user = Rxn<User>();
  User? get user => _user.value;

  //Loading Indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void _changeLoadingStatus(bool newValue) {
    _isLoading = newValue;
    update();
  }

  //Login
  final TextEditingController loginEmail = TextEditingController();
  final TextEditingController loginPassword = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  //Sign Up
  final TextEditingController signupName = TextEditingController();
  final TextEditingController signupEmail = TextEditingController();
  final TextEditingController signupMobileNumber = TextEditingController();
  final TextEditingController signupAddress = TextEditingController();
  final TextEditingController signupPassword = TextEditingController();
  final TextEditingController signupConfirmPassword = TextEditingController();
  final signupFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    loginEmail.dispose();
    loginPassword.dispose();
    signupName.dispose();
    signupMobileNumber.dispose();
    signupAddress.dispose();
    signupConfirmPassword.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
  }

  //Google SignIn
  void signInWithGoogle() async {
    //Start Loading
    _changeLoadingStatus(true);
    //define signIn Method
    _signInType = AuthType.googleSignIn;
    try {
      //Trigger the authentication flow
      final googleUser = await GoogleSignIn().signIn();
      // print(googleUser);

      //obtain the auth details from the user
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      //create a new credential for the user's device
      final AuthCredential googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // print(credential);

      await _auth.signInWithCredential(googleAuthCredential).then(
          (UserCredential userCredential) async =>
              await _saveUserToFirestore(userCredential));

      //Navigate To Home Screen
      Get.offAll(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthException(e.code);
    } on PlatformException catch (e) {
      handleFirebaseAuthException(e.code);
      return;
    } catch (e) {
      //print(e);
    } finally {
      _changeLoadingStatus(false);
    }
  }

  //Facebook SignIn
  Future<void> signInWithFacebook() async {
    //Start Loading
    _changeLoadingStatus(true);

    //define signIn Method
    _signInType = AuthType.facebookSignIn;

    // print('here we sign fb');

    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.accessToken != null) {
        // Create a credential from the access token
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);

        await _auth.signInWithCredential(facebookAuthCredential).then(
            (UserCredential userCredential) async =>
                await _saveUserToFirestore(userCredential));
      }

      //Navigate to Home Screen
      Get.offAll(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthException(e.code);
    } on PlatformException catch (e) {
      handleFirebaseAuthException(e.code);
    } catch (e) {
      //print(e);
    } finally {
      _changeLoadingStatus(false);
    }
  }

  //email & password
  Future<void> signInWithEmailAndPassword() async {
    //Start Loading
    _changeLoadingStatus(true);
    //define signIn Method
    _signInType = AuthType.emailSignIn;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: loginEmail.text.trim(),
        password: loginPassword.text,
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

      //Navigate to the Home Screen
      Get.offAll(() => const HomeScreen());
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
    } finally {
      _changeLoadingStatus(false);
    }
  }

  Future<void> signUpWithEmailAndPassword() async {
    //Start Loading
    _changeLoadingStatus(true);
    //define signIn Method
    _signInType = AuthType.emailSignIn;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: loginEmail.text.trim(),
            password: loginPassword.text,
          )
          .then((UserCredential userCredential) async =>
              await _saveUserToFirestore(userCredential));

      //Navigate to Home Screen
      Get.offAll(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      // if (e.code == 'weak-password') {
      //   print('The password provided is too weak.');
      // } else if (e.code == 'email-already-in-use') {
      //   print('The account already exists for that email.');
      // }
      handleFirebaseAuthException(e.code);
    } catch (e) {
      // print(e);
    } finally {
      _changeLoadingStatus(false);
    }
  }

  Future<void> _saveUserToFirestore(UserCredential userCredential) async {
    final UserModel userModel = UserModel(
      id: userCredential.user?.uid,
      name: _signInType == AuthType.emailSignIn
          ? signupName.text
          : userCredential.user!.displayName,
      email: userCredential.user?.email!,
      imageUrl: _signInType == AuthType.emailSignIn
          ? 'default'
          //google login
          : _signInType == AuthType.googleSignIn
              ? userCredential.user?.photoURL
                  ?.replaceAll('s96-c', 's400-c')
                  .toString()
              //facebook login
              : '${userCredential.user?.photoURL}?height=500',
      address: signupAddress.text,
      mobileNumber: int.tryParse(signupMobileNumber.text) ?? 0,
      points: 0,
      payments: [],
      orders: [],
    );

    // print(userCredential.user?.photoURL);

    await FirestoreUser().addUserToFirestore(userModel);
    //TODO :Save the userData to the LocalDataStorage Too
    await _saveUserToLocalStorage(userModel);
  }

  Future<void> _saveUserToLocalStorage(UserModel userModel) async {
    // await _localDataStorage.setUserData(userModel);
  }

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
        errorMessage = "Too many requests to log into this account.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        errorMessage = "Server error, please try again later.";
        break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        errorMessage = "Email address is invalid.";
        break;
      default:
        errorMessage = "Login failed. Please Check your Internet Connetion.";
        break;
    }
    Get.snackbar(
      'Error : ',
      errorMessage,
      messageText: MyText(
        text: errorMessage,
        containerAlignment: Alignment.center,
        fontWeight: FontWeight.w800,
      ),
      colorText: Colors.black,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: kMainAppColor,
    );
  }

  void changePassword(String currentPassword, String newPassword) async {
    final user = _auth.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user?.email as String, password: currentPassword);

    user!.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((_) async {
        //Success, do something
        Get.snackbar(
          'Error : ',
          'Password is Changed Successfully.',
          messageText: const MyText(
            text: 'Password is Changed Successfully.',
            containerAlignment: Alignment.center,
            fontWeight: FontWeight.w800,
          ),
          colorText: Colors.black,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kMainAppColor,
        );
        await signOut();
      }).catchError((error) {
        //Error, show something
        Get.snackbar(
          'Error : ',
          'There was an error!',
          messageText: const MyText(
            text: 'There was an error!',
            containerAlignment: Alignment.center,
            fontWeight: FontWeight.w800,
          ),
          colorText: Colors.black,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kMainAppColor,
        );
      });
    }).catchError((err) {
      Get.snackbar(
        'Error : ',
        'There was an error!',
        messageText: const MyText(
          text: 'There was an error!',
          containerAlignment: Alignment.center,
          fontWeight: FontWeight.w800,
        ),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kMainAppColor,
      );
    });
  }

  Future<void> signOut() async {
    switch (_signInType) {
      case AuthType.emailSignIn:
        //sign out from email/password
        await _auth.signOut();
        break;
      case AuthType.facebookSignIn:
        final _fa = FacebookAuth.instance;
        await _fa.logOut();
        break;
      case AuthType.googleSignIn:
        //sign out from google account
        final _go = GoogleSignIn();
        await _go.signOut();
        await _go.disconnect();
        break;
    }

    //clear the local user data storage
    //TODO - Some Local storage clear here
    //reset the state user value so we can go back to the login screen
    _user.value = null;
    //print(user);
    Get.offAll(() => const NavigationScreen());
  }
}
