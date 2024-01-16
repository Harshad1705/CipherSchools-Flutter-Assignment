import 'dart:developer';
import 'package:cipher_school/features/home/home_screen.dart';
import 'package:cipher_school/features/home/home_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/enum.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  Rx<Varient> varient = Varient.signUp.obs;
  RxBool isChecked = false.obs;
  RxBool isLoading = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final storage = GetStorage();




  void changeCheckBoxValue() {
    isChecked.value = !isChecked.value;
  }

  void clearValues() {
    emailController.text = "";
    passwordController.text = "";
    nameController.text = "";
    changeCheckBoxValue();
  }

  void changeVarient() {
    varient.value =
        (varient.value == Varient.signUp) ? Varient.login : Varient.signUp;
  }

  void showSnackBar(
      {String title = "Error",
      String subtitle = "something went wrong",
      Color color = Colors.red}) {
    Get.snackbar(
      title,
      subtitle,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 3),
      backgroundColor: color,
      colorText: Colors.white,
      borderRadius: 8.0,
      animationDuration: Duration(milliseconds: 500),
    );
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }

  signUpWithEmailAndPassword() async {
    isLoading.value = true;

    if (!isChecked.value ||
        emailController.text == '' ||
        nameController.text == '' ||
        passwordController.text == '') {
      showSnackBar(subtitle: 'Fill in all the fields');
      isLoading.value = false;
      return;
    }

    if (!isValidEmail(emailController.text)) {
      showSnackBar(subtitle: 'Email is invalid');
      isLoading.value = false;
      return;
    }

    if (passwordController.text.length < 6) {
      showSnackBar(subtitle: 'password is weak');
      isLoading.value = false;
      return;
    }

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      String uid = credential.user!.uid.toString();
      addDataToCollection(uid: uid);
      storage.write('name', nameController.text);
      clearValues();
      showSnackBar(
          color: Colors.blue,
          title: 'Success',
          subtitle: 'User registered successfully');
      changeVarient();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(subtitle: 'User not found');
      } else if (e.code == 'wrong-password') {
        showSnackBar(subtitle: 'Wrong password');
      } else {
        showSnackBar();
      }
    } catch (e) {
      showSnackBar();
    } finally {
      isLoading.value = false; // Set isLoading to false in the finally block
    }
  }

  addDataToCollection({
    required String uid,
  }) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    users
        .doc(uid)
        .set({
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'id': uid,
          'income': 0,
          'expense': 0,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));

    storage.write('uid', uid);
  }
  loginWithEmailAndPassword() async {
    isLoading.value = true;

    if (!isChecked.value ||
        emailController.text == '' ||
        passwordController.text == '') {
      showSnackBar(subtitle: 'Fill in all the fields');
      isLoading.value = false; // Corrected: Set isLoading to false
      return;
    }

    if (!isValidEmail(emailController.text)) {
      showSnackBar(subtitle: 'Email is invalid');
      isLoading.value = false; // Corrected: Set isLoading to false
      return;
    }


    if (passwordController.text.length < 6) {
      showSnackBar(subtitle: 'password is weak');
      isLoading.value = false;
      return;
    }

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      String? name = credential.user?.displayName.toString();

      fetchUserData(uid: credential.user!.uid);

      if (credential.user != null) {
        showSnackBar(
          color: Colors.blue,
          title: 'Success',
          subtitle: 'Login successful',
        );
        storage.write('email', emailController.text);
        storage.write('name', name);

        storage.write('income', 0);
        storage.write('expense', 0);

        clearValues();

        Get.offAll(
              () => HomeView(),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(subtitle: 'User not found');
      } else if (e.code == 'wrong-password') {
        showSnackBar(subtitle: 'Wrong password');
      } else {
        showSnackBar();
      }
    } catch (e) {
      showSnackBar();
    } finally {
      isLoading.value = false;
    }
  }

  void signInWithGoogle() async {
    try {
      isLoading.value = true;

      FirebaseAuth auth = FirebaseAuth.instance;
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final UserCredential userCredential =
      await auth.signInWithCredential(credential);

      String name = (userCredential.user!.displayName.toString());
      String email = (userCredential.user!.email.toString());

      storage.write('email', email);
      storage.write('name', name);

      nameController.text = name;
      emailController.text = email;
      passwordController.text = '';

      String? uid = FirebaseAuth.instance.currentUser?.uid;

      if (varient == Varient.login) {
        fetchUserData(uid: uid!);
        Get.offAll(() => const HomeView());
        return;
      }

      addDataToCollection(uid: uid!);

      log(credential.toString());

      if (credential != null) {
        showSnackBar(
          color: Colors.blue,
          title: 'Success',
          subtitle: 'Login successfully',
        );
        storage.write('income', 0);
        storage.write('expense', 0);

        
        clearValues();

        Get.offAll(() => HomeView());
      }
    } catch (e) {
      showSnackBar(subtitle: 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }


  void fetchUserData({required String uid}) async {
    try {
      DocumentReference userReference =
          FirebaseFirestore.instance.collection('users').doc(uid);

      // Get the document snapshot
      DocumentSnapshot userSnapshot = await userReference.get();

      // Check if the document exists
      if (userSnapshot.exists) {
        // Retrieve the data from the document
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;

        storage.write('name', userData!['name']);
        storage.write('income', userData!['income']);
        storage.write('expense', userData!['expense']);
        // return userData;
      } else {
        print('Document does not exist');
        return null;
      }
    } catch (error) {
      print('Error fetching document data: $error');
      return null;
    }
  }
}
