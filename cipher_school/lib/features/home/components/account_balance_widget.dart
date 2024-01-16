import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../../theme/colors.dart';
import '../../../theme/styles.dart';
import 'income_expense_box.dart';

class AccountBalanceWidget extends StatelessWidget {
   AccountBalanceWidget({
    super.key,
  });

  GetStorage storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    int income = storage.read('income');
    int expense = storage.read('expense');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: CustomColor.lemon,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/avatar.png',
                height: 32,
                width: 32,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/arrow-down.png',
                    height: 24,
                    width: 24,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'January',
                    style: Styles.inter_14_500
                        .copyWith(color: CustomColor.baseColor),
                  ),
                ],
              ),
              Image.asset(
                'assets/images/notifiaction.png',
                height: 32,
                width: 32,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Account Balance',
            style:
            Styles.inter_14_500.copyWith(color: CustomColor.grey),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '\u{20B9}${income-expense}',
            style: Styles.inter_40_600
                .copyWith(color: CustomColor.baseColor),
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: IncomeExpenseWidget(title: 'Income',imagePath: 'assets/images/income.png',amount: income,clr: CustomColor.green,)),
              SizedBox(width: 20,),

              Expanded(child: IncomeExpenseWidget(title: 'Expenses',imagePath: 'assets/images/expenses.png',amount: expense,clr: CustomColor.red,)),
            ],
          ),
          const SizedBox(height: 15,),
        ],
      ),
    );
  }
}