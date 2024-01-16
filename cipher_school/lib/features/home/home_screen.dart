import 'dart:developer';

import 'package:cipher_school/features/home/home_controller.dart';
import 'package:cipher_school/features/home/home_view.dart';
import 'package:cipher_school/features/transactions/transaction_screen.dart';
import 'package:cipher_school/theme/colors.dart';
import 'package:cipher_school/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'components/account_balance_widget.dart';
import 'components/transcaction_list.dart';

class HomeScreen extends StatelessWidget {
  final _homeController = Get.put(HomeController());

  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Obx(()=>_homeController.isLoading.value?Center(child:  CircularProgressIndicator(),):Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          children: [
            AccountBalanceWidget(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: SizedBox(
                height: 40,
                child: Obx(
                      () => selectTiming(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: SizedBox(
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Transaction',
                      style: Styles.inter_18_600
                          .copyWith(color: CustomColor.baseColor),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 2),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: CustomColor.violet.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(40)),
                      child: Center(
                        child: Text(
                          'See All',
                          style: Styles.inter_14_500
                              .copyWith(color: CustomColor.violet),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child:  _homeController.expenseList.isEmpty ? Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text('No transaction data available',style: Styles.inter_14_500.copyWith(color: CustomColor.baseColor)),
                )
                    :  TransactionList(data: _homeController.expenseList))
          ],
        ),
      )),
    ));
  }

  selectTiming() {
    List<Widget> row = [];
    for (int i = 0; i < _homeController.selectTime.length; i++) {
      row.add(
        GestureDetector(
          onTap: () {
            _homeController.changeSelectTimeIndex(i);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: _homeController.selectedTimeIndex == i
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: CustomColor.yellow,
                  )
                : null,
            child: Text(
              _homeController.selectTime[i],
              style: _homeController.selectedTimeIndex == i
                  ? Styles.inter_14_700.copyWith(color: CustomColor.textYellow)
                  : Styles.inter_14_500.copyWith(color: CustomColor.grey),
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: row,
    );
  }
}
