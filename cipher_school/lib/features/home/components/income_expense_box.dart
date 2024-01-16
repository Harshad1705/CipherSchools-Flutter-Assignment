
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../theme/colors.dart';
import '../../../theme/styles.dart';
import '../../../utils/enum.dart';
import '../../expense&income/expense.dart';

class IncomeExpenseWidget extends StatelessWidget {
   IncomeExpenseWidget({
    super.key,
    required this.title,
     required this.imagePath,
    required this.amount,
     required this.clr
  });
  String title;
  String imagePath;
  int amount;
  Color clr;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        if(title=='Income')
        Get.to(ExpenseScreen(type: ScreenName.Income,));
        else
        Get.to(ExpenseScreen(type: ScreenName.Expense,));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: clr,
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              height: 48,
              width: 48,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Styles.inter_14_500
                      .copyWith(color: Colors.white),
                ),
                Text(
                  '\u{20B9}${amount}',
                  style: Styles.inter_22_600
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
