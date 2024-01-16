import 'dart:developer';

import 'package:cipher_school/features/home/home_controller.dart';
import 'package:cipher_school/features/home/home_screen.dart';
import 'package:cipher_school/features/home/home_view.dart';
import 'package:cipher_school/utils/enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../theme/colors.dart';

class ExpenseController extends GetxController {

RxBool isLoading = false.obs;
  String? selectedCategory;
  String? selectedWallet;
  TextEditingController description = TextEditingController();
  TextEditingController amountController = TextEditingController();


  int income = GetStorage().read('income');
  int expense = GetStorage().read('expense');


  List<String> wallet = [

  ];

  List<String> category = [
    'Food',
    'Travel',
    'Subscription',
    'Shopping',
  ];

  ExpenseController(){
    wallet.clear();
    int available = income-expense;
    wallet.add(available.toString());
    getCurrentUserUid();
  }

  Map<String,Color> getColorCode ={
    'Shopping' : CustomColor.yellow,
    'Subscription':CustomColor.lightPurple,
    'Travel':CustomColor.borderColor,
    'Food' : CustomColor.lightRed
  };
  Map<String,String> getIcon ={
    'Shopping' : 'shopping',
    'Subscription':'subscription',
    'Travel':'travel',
    'Food' :'food'
  };

  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;

    return user!.uid;

  }

  void changeSelectedCategory(String index) {
    selectedCategory = index;
    update();
  }

  void changeSelectedWallet(String index) {
    selectedWallet = index;
    update();
  }

  addExpenseEntry({required ScreenName type}) async {

    isLoading.value = true;
    String uid = getCurrentUserUid();

    if (!(amountController.text.isEmpty || description.text.isEmpty ||
        selectedWallet == null || selectedCategory == null)) {
      await FirebaseFirestore
          .instance
          .collection('users')
          .doc(uid)
          .collection(
          "expense")
          .add({
        'type':type==ScreenName.Income?'Income':'Expense',
        'category': selectedCategory,
        'amount': amountController.text,
        'desc': description.text,
        'time': DateTime.now(),
      });

      if(type==ScreenName.Income){
        GetStorage().write('income', income+int.parse(amountController.text));
      }else{
        GetStorage().write('expense', expense+int.parse(amountController.text));
      }


      await HomeController().fetchExpenseData();


      Get.offAll(HomeView());
    }

    isLoading.value = false;
  }

  String formatTime(DateTime dateTime) {
    String period = 'AM';
    int hour = dateTime.hour;

    if (hour >= 12) {
      period = 'PM';
      if (hour > 12) {
        hour -= 12;
      }
    }

    String formattedTime = '${_addLeadingZero(hour)}:${_addLeadingZero(dateTime.minute)} $period';

    return formattedTime;
  }

  String _addLeadingZero(int number) {
    return number.toString().padLeft(2, '0');
  }
}
