import 'dart:ffi';

import 'package:cipher_school/features/expense&income/expense.dart';
import 'package:cipher_school/features/expense&income/expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/colors.dart';
import '../../utils/enum.dart';
import 'components/bottom_nav_bar.dart';
import 'home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (_controller) =>
              NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overScroll) {
              overScroll.disallowIndicator();
              return true;
            },
            child: Scaffold(
              // backgroundColor: ColorsValue.backgroundColor,
              body: SafeArea(
                child: _controller.getItemWidget(_controller.selectedIndex),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Get.to(ExpenseScreen(type: ScreenName.Expense,));
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 40,
                ),
                shape: CircleBorder(),
                backgroundColor: CustomColor.violet,
              ),

              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BottomNavBar(),
            ),
          ),
        ),
      );
}
