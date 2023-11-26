

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping_app/utils/constants.dart';

import '../model/user_model.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {

  static AuthController instance = Get.find<AuthController>();
  late Rx<User?> firebaseUser;
  FirebaseAuth auth = FirebaseAuth.instance;

  late UserCredential userCredential;

  String? verificationCode;

  late Rx<GoogleSignInAccount?> googleSignInAccount;
  GoogleSignIn googleSign = GoogleSignIn();

  List<String> cartValues = [];
  String usersCollection = "users";
  Rx<UserModel> userModel = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      firebaseUser = Rx<User?>(auth.currentUser);
      googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);

      firebaseUser.bindStream(auth.userChanges());


      googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);


      ever(firebaseUser, _setInitialScreen);
    });
  }

  _setInitialScreen(User? user) {
    if (user != null) {
      userModel.bindStream(listenToUser());
    }
  }

  Future signInWithGoogle() async {
    try {
      await googleSign.signOut();
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        Loader.show(Get.overlayContext!);
        final UserCredential authResult = await auth.signInWithCredential(
            credential);

        final User? user = authResult.user;

        //check if user is existing or not
        if (authResult.additionalUserInfo!.isNewUser) {
          Loader.hide();
          saveUserInfoToFirebase(user);
          if (user != null) {
            Get.offAllNamed(Routes.HOME);
          }
        } else {
          Loader.hide();
          listenToUser();
          Get.offAllNamed(Routes.HOME);
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e.toString());
    }
  }

  bool isEmailVerified(String emailId) {
    // Null or empty string is invalid
    if (emailId == null || emailId.isEmpty) {
      return false;
      // isEmailVerify(false);
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (regExp.hasMatch(emailId)) {
      return true;
    } else {
      return false;
    }
  }


  Future<UserCredential> register(String email, password) async {
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (firebaseAuthException) {
      Get.snackbar("User", "User message",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          titleText: const Text(
            "Account creation failed",
            style: TextStyle(
                color: Colors.white
            ),
          )
      );
    }

    return userCredential;
  }

  Future<UserCredential> login(String email, password) async {
    try {
      userCredential =
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (firebaseAuthException) {
      Get.snackbar("User", "User message",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          titleText: const Text(
            "User Not found",
            style: TextStyle(
                color: Colors.white
            ),
          )
      );
    }

    return userCredential;
  }

  Future signOut(BuildContext context) async {
    await auth.signOut().then((value) =>
    {
      Get.offAllNamed(Routes.LOGIN),
    });
  }

  void saveUserInfoToFirebase(User? firebaseUser) {
    //save user info once registered
    FirebaseFirestore.instance.collection("users").doc(firebaseUser!.uid).set({
      'id': firebaseUser.uid,
      'name': firebaseUser.email!.trim(),
      'email': firebaseUser.email!.trim(),
      'cart': []
    }).then((value) =>
    {
      userModel.bindStream(listenToUser()),
    });
  }

  void showSnackbar(String message, [int seconds = 2]) {
    GetSnackBar(
        messageText: Text(
          message,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
              fontSize: 11.5),
        ),
        duration: Duration(seconds: seconds),
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM)
        .show();
  }

  Stream<UserModel> listenToUser() {
    return FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(firebaseUser.value!.uid)
        .snapshots()
        .map((snapshot) => UserModel.fromSnapshot(snapshot));
  }

  updateUserData(Map<String, dynamic> data) {
    FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(firebaseUser.value!.uid)
        .update(data);
  }

  updateQuantity(String? cartItemId,int? newQuantity,double? price) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    DocumentSnapshot userDoc = await users.doc(firebaseUser.value!.uid).get();

    // Get the 'cart' array from the document
    List<dynamic> cart = userDoc['cart'];

    // Find the index of the item with the specified cartItemId
    int indexOfItemToUpdate = cart.indexWhere((item) => item['id'] == cartItemId);

    if (indexOfItemToUpdate != -1) {
      // Update the quantity of the item at the found index
      cart[indexOfItemToUpdate]['quantity'] = newQuantity;
      cart[indexOfItemToUpdate]['cost'] = price! * newQuantity!;

      // Update the 'cart' array in the document
      await users.doc(firebaseUser.value!.uid).update({
        'cart': cart,
      });

    } else {

    }
  }

}