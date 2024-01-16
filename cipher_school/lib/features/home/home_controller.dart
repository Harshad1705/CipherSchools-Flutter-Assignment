import 'dart:async';
import 'dart:developer';

import 'package:cipher_school/features/home/home_screen.dart';
import 'package:cipher_school/features/profile/profile_screen.dart';
import 'package:cipher_school/features/transactions/transaction_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  List<String> selectTime = [
    'Today',
    'Week',
    'Month',
    'Year',
  ];
  RxInt selectedTimeIndex = 0.obs;
  List<Map<String, dynamic>> expenseList = [];
  RxBool isLoading = false.obs;

  int selectedIndex = 0;


  RxInt income  = 0.obs;
  RxInt expense  = 0.obs;

  HomeController() {
    _init();
  }




  Future<void> _init() async {

    isLoading.value = true;
    await fetchExpenseData();


    expenseList.sort((b,a) => (a['time'] as Timestamp).compareTo(b['time'] as Timestamp));
    expense.value = GetStorage().read('expense');
    income.value = GetStorage().read('income');

    isLoading.value = false;

    log(expenseList.toString(), name: 'Harry');
  }

  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;

    return user!.uid;

  }

  Future<void> fetchExpenseData() async {
    try {
      String userId =getCurrentUserUid(); // Replace with the actual user ID

      // Get all documents from the "expense" collection for the specified user
      QuerySnapshot expenseSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('expense')
          .get();

      // Clear the existing data in expenseList for the new user
      expenseList.clear();

      // Loop through each document in the "expense" collection
      for (QueryDocumentSnapshot expenseDoc in expenseSnapshot.docs) {
        Map<String, dynamic>? expenseData = expenseDoc.data() as Map<String, dynamic>?;

        if (expenseData != null) {
          expenseList.add(expenseData);
        }
      }
    } catch (error) {
      print('Error fetching data: $error');
    }

  }


  void changeSelectedIndex(int index) {
    selectedIndex = index;
    update();
  }

  changeSelectTimeIndex(int value) {
    selectedTimeIndex.value = value;
  }

  Widget getItemWidget(int pos) {
    switch (pos) {
      case 0:
        return HomeScreen();
      case 1:
        return const TransactionScreen();
      case 2:
        return HomeScreen();
      case 3 :
        return ProfileScreen();
      default:
        return const Text('Error');
    }
    update();
  }
}
