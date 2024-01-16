import 'dart:math';

import 'package:cipher_school/features/expense&income/components/custom_text_field.dart';
import 'package:cipher_school/features/expense&income/expense_controller.dart';
import 'package:cipher_school/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/styles.dart';
import '../../utils/enum.dart';
import 'components/custom_drop_down.dart';

class ExpenseScreen extends StatefulWidget {
   ExpenseScreen({Key? key,required this.type}) : super(key: key);
   ScreenName type;


  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  ExpenseController expenseController = Get.put(ExpenseController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: widget.type==ScreenName.Expense ? CustomColor.blue : CustomColor.purple,
        appBar: AppBar(
          backgroundColor:widget.type==ScreenName.Expense ? CustomColor.blue : CustomColor.purple,
          centerTitle: true,
          leading: const BackButton(
            color: Colors.white,
          ),
          title: Text(
            widget.type==ScreenName.Expense? "Expense":"Income",
            style: Styles.inter_18_600.copyWith(color: Colors.white),
          ),
        ),
        body: GetBuilder<ExpenseController>(
          init: ExpenseController(),
          builder: (controller) => Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How much?',
                      style: Styles.inter_18_600
                          .copyWith(color: CustomColor.light.withOpacity(0.5)),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('\u{20B9}',
                            style: Styles.inter_64_600
                                .copyWith(color: CustomColor.light)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: TextField(
                              controller: controller.amountController,
                              keyboardType: TextInputType.number,
                              style: Styles.inter_64_600
                                  .copyWith(color: CustomColor.light),
                              decoration: InputDecoration(
                                hintText: '0',
                                hintStyle: Styles.inter_64_600
                                    .copyWith(color: CustomColor.light),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(32),
                      topLeft: Radius.circular(32),
                    ),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: DropDown.CategoryDropDown(
                              expenseController: controller),
                        ),
                         Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: CustomTextField2(controller: controller.description,),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child:
                          DropDown.WalletDropDown(expenseController: controller),
                        ),

                         Padding(
                          padding: EdgeInsets.only(top: 40.0, bottom: 20),
                          child: Divider(
                            color:widget.type==ScreenName.Expense ? CustomColor.blue : CustomColor.purple,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            controller.addExpenseEntry(type:widget.type);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: CustomColor.violet,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                                child:Obx(()=>expenseController.isLoading.value ? CircularProgressIndicator(color: Colors.white,): Text(
                                  'Continue',
                                  style: Styles.inter_18_600
                                      .copyWith(color: Colors.white),
                                ),)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
