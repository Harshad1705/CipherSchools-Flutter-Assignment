import 'package:cipher_school/features/home/home_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../authentication/auth_screen.dart';

class ProfileController extends GetxController{

  RxBool isLoading = false.obs;

  TextEditingController nameController = TextEditingController();

  String capitalize(String s) {
    return s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
  }

  GetStorage storage = GetStorage();

  Future<void> signOutMethod()async{
    isLoading.value =true;
    await updateDocument();
    await FirebaseAuth.instance.signOut();
    storage.write('email', null);
    storage.write('isGoogle', null);

    Get.offAll(()=>const AuthScreen());
    isLoading.value = false;
  }

  Future<void> updateName()async {
    try {
      String name = nameController.text;
      GetStorage().write('name', name);
      String uid = FirebaseAuth.instance.currentUser!.uid;
      Map<String,String> updatedData = {
        'name' : name,
      };
      DocumentReference userReference =
      FirebaseFirestore.instance.collection('users').doc(uid);

      // Update the document with the specified data
      await userReference.update(updatedData);

      print('Document updated successfully.');
    } catch (error) {
      print('Error updating document: $error');
    }

    Get.offAll(HomeView());
  }


  Future<void> updateDocument() async {
    try {
      int income = GetStorage().read('income');
      int expense = GetStorage().read('expense');
      String uid = FirebaseAuth.instance.currentUser!.uid;
      Map<String,int> updatedData = {
        'income':income,
        'expense':expense
      };
      DocumentReference userReference =
      FirebaseFirestore.instance.collection('users').doc(uid);

      // Update the document with the specified data
      await userReference.update(updatedData);

      print('Document updated successfully.');
    } catch (error) {
      print('Error updating document: $error');
    }
  }

}