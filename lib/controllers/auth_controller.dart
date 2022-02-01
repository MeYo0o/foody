import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:foody/constants/colors.dart';
import 'package:foody/core/services/firestore_user.dart';
import 'package:foody/models/user_model.dart';
import 'package:foody/screens/email_verification_screen.dart';
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
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
  }

  //Email Verification
  int _funcCount = 0;
  bool _isEmailVerified = false;
  bool get isEmailVerified => _isEmailVerified;
  bool _canResendEmailVerification = false;
  bool get canResendEmailVerification => _canResendEmailVerification;
  Timer? _timer;
  Future<void> getEmailVerificationStatus() async {
    // print(_funcCount++);
    // await Future.delayed(Duration.zero);

    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) async {
        //reloading the user so we can re-check if it's email verified
        _user.value = _auth.currentUser!..reload();
        Future.delayed(const Duration(seconds: 2));
        _isEmailVerified = user!.emailVerified;
        if (isEmailVerified) {
          // print('verified');
          timer.cancel();
          update();
          return;
        } else if (!isEmailVerified) {
          // print('not verified');
          if (!canResendEmailVerification) {
            _canResendEmailVerification = true;
            update();
          }
        }
      },
    );
    // if (isEmailVerified) {
    //   _timer!.cancel();
    //   update();
    //   Get.offAll(() => const HomeScreen());
    // } else if (!isEmailVerified) {
    //   _timer = Timer.periodic(
    //     const Duration(seconds: 5),
    //     (timer) async {
    //       if (!_canResendEmailVerification) {
    //         _canResendEmailVerification = true;
    //         update();
    //       }
    //     },
    //   );
    // }
  }

  Future<void> sendVerificationEmail() async {
    // print('sending verification email');
    try {
      await user!.sendEmailVerification();
      if (_canResendEmailVerification) {
        _canResendEmailVerification = false;
        update();
      }
      Get.snackbar(
        'Please Check your email : ',
        'A Verification email has been sent!',
        messageText: const MyText(
          text: 'A Verification email has been sent!',
          containerAlignment: Alignment.center,
          fontWeight: FontWeight.w800,
        ),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kMainAppColor,
      );
    } on PlatformException {
      Get.snackbar(
        'Error : ',
        'Network Error!',
        messageText: const MyText(
          text: 'Network Error!',
          containerAlignment: Alignment.center,
          fontWeight: FontWeight.w800,
        ),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kMainAppColor,
      );
    } catch (err) {
      Get.snackbar(
        'Error : ',
        err.toString(),
        messageText: MyText(
          text: err.toString(),
          containerAlignment: Alignment.center,
          fontWeight: FontWeight.w800,
        ),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kMainAppColor,
      );
    }
  }

  //Mobile Phone Verification
  // Future<void> verifyMobileNumber() async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: '+20 115 888 9193',
  //     verificationCompleted: (PhoneAuthCredential credential) {},
  //     verificationFailed: (FirebaseAuthException e) {},
  //     codeSent: (String verificationId, int? resendToken) {},
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //   );
  // }

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

      await _auth
          .signInWithCredential(googleAuthCredential)
          .then((UserCredential userCredential) async {
        await _saveUserToFirestore(userCredential);
        //Navigate To Home Screen
        Get.offAll(() => const EmailVerificationScreen());
      });
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
          (UserCredential userCredential) async {
            await _saveUserToFirestore(userCredential);
            //Navigate to Home Screen
            Get.offAll(() => const EmailVerificationScreen());
          },
        );
      }
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
        //Navigate to the Home Screen
        Get.offAll(() => const EmailVerificationScreen());
        return credentials;
      });

      // print(userCredential);
    } on SocketException {
      // print('network error');
      Get.snackbar(
        'Alert : ',
        'Network Error!',
        messageText: const MyText(
          text: 'Network Error!',
          containerAlignment: Alignment.center,
          fontWeight: FontWeight.w800,
        ),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kMainAppColor,
      );
      _changeLoadingStatus(false);

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
      await _auth
          .createUserWithEmailAndPassword(
        email: signupEmail.text.trim(),
        password: signupPassword.text,
      )
          .then(
        (UserCredential userCredential) async {
          await _saveUserToFirestore(userCredential);
          //Navigate to Home Screen
          Get.offAll(() => const EmailVerificationScreen());
        },
      );
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
          //google login pic
          : _signInType == AuthType.googleSignIn
              ? userCredential.user?.photoURL
                  ?.replaceAll('s96-c', 's400-c')
                  .toString()
              //facebook login pic
              : '${userCredential.user?.photoURL}?height=500',
      address: signupAddress.text,
      mobileNumber: signupMobileNumber.text,
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
        // print(errorCode);
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
    _changeLoadingStatus(true);
    try {
      final user = _auth.currentUser;
      final cred = EmailAuthProvider.credential(
          email: user?.email as String, password: currentPassword);
      await user!.reauthenticateWithCredential(cred);
      await user.updatePassword(newPassword);
      //Success, do something
      Get.snackbar(
        'Alert : ',
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
    } on SocketException {
      Get.snackbar(
        'Alert : ',
        'Network Error!',
        messageText: const MyText(
          text: 'Network Error!',
          containerAlignment: Alignment.center,
          fontWeight: FontWeight.w800,
        ),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kMainAppColor,
      );
    } catch (err) {
      //Error, show something
      Get.snackbar(
        'Alert : ',
        'Your Entered password is wrong!',
        messageText: const MyText(
          text: 'Your Entered password is wrong!',
          containerAlignment: Alignment.center,
          fontWeight: FontWeight.w800,
        ),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kMainAppColor,
      );
    } finally {
      _changeLoadingStatus(false);
    }
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
        // await _go.disconnect();
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
