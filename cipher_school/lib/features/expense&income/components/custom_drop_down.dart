import 'package:cipher_school/features/expense&income/expense_controller.dart';
import 'package:flutter/material.dart';



import '../../../theme/colors.dart';
import '../../../theme/styles.dart';

class DropDown{

  static CategoryDropDown({required ExpenseController expenseController}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: CustomColor.grey.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                icon: Image.asset(
                  'assets/images/arrow-down.png',
                  height: 32,
                  width: 32,
                  color: CustomColor.grey,
                ),
                hint: Text(
                  'Category',
                  style: Styles.inter_16_400.copyWith(color: CustomColor.grey),
                ),
                value: expenseController.selectedCategory,
                items: expenseController.category.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
                onChanged:(val){
                  expenseController.changeSelectedCategory(val!);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  static WalletDropDown({required ExpenseController expenseController}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: CustomColor.grey.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                icon: Image.asset(
                  'assets/images/arrow-down.png',
                  height: 32,
                  width: 32,
                  color: CustomColor.grey,
                ),
                hint: Text(
                  'Wallet',
                  style: Styles.inter_16_400.copyWith(color: CustomColor.grey),
                ),
                value: expenseController.selectedWallet,
                items: expenseController.wallet.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
                onChanged:(val){
                  expenseController.changeSelectedWallet(val!);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}