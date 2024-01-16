import 'package:cipher_school/theme/colors.dart';
import 'package:cipher_school/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/string_constant.dart';
import '../home_controller.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
    init: HomeController(),
        builder: (controller) => BottomNavigationBar(
          selectedLabelStyle: Styles.inter_10_600.copyWith(color: CustomColor.violet),
          unselectedLabelStyle: Styles.inter_10_500.copyWith(color: CustomColor.lightGrey),
          selectedItemColor: CustomColor.violet,
          unselectedItemColor: CustomColor.lightGrey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap:
            controller.changeSelectedIndex,

          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding:const  EdgeInsets.all(5),
                child: Image.asset(
                  'assets/images/home.png',
                  width: 32,
                  height: 32,
                  color: controller.selectedIndex==0  ? CustomColor.violet :CustomColor.lightGrey
                ),
              ),
              label: StringConstants.home,


            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  'assets/images/transaction.png',
                  width: 32,
                  height: 32,
                    color: controller.selectedIndex==1  ? CustomColor.violet :CustomColor.lightGrey
                ),
              ),
              label: StringConstants.transaction,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  'assets/images/pie.png',
                  width: 32,
                  height: 32,
                    color: controller.selectedIndex==2  ? CustomColor.violet :CustomColor.lightGrey
                ),
              ),
              label: StringConstants.budget,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  'assets/images/user.png',
                  width: 32,
                  height: 32,
                    color: controller.selectedIndex==3  ? CustomColor.violet :CustomColor.lightGrey
                ),
              ),
              label: StringConstants.profile,
            ),

          ],
        ),
      );
}
