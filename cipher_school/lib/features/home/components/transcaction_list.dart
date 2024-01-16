import 'package:cipher_school/features/expense&income/expense_controller.dart';
import 'package:cipher_school/theme/styles.dart';
import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

class TransactionList extends StatefulWidget {
  TransactionList({Key? key, required this.data}) : super(key: key);

  List data;

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  ExpenseController controller = ExpenseController();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          bool isIncome = widget.data[index]['type']=='Income';
          String formattedTime = controller.formatTime(widget.data[index]['time'].toDate());
          return Container(
            height: 60,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                   margin: EdgeInsets.only(right: 10),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color:
                        controller.getColorCode[widget.data[index]['category']],
                  ),
                  child: Center(
                      child: Image.asset(
                    'assets/images/${controller.getIcon[widget.data[index]['category']]}.png',
                    height: 30,
                    width: 30,
                  )),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.30,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.data[index]['category'],
                        style: Styles.inter_16_500
                            .copyWith(color: CustomColor.baseColor),
                      ),
                      Text(
                        widget.data[index]['desc'],
                        overflow: TextOverflow.ellipsis,
                        style:
                            Styles.inter_13_500.copyWith(color: CustomColor.grey,overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Column(crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${isIncome ? '+' : '-'} \u{20B9}${widget.data[index]['amount']}',
                      style: Styles.inter_16_600
                          .copyWith(color:isIncome ? CustomColor.green : CustomColor.red),
                    ),
                    Text(
                      formattedTime,
                      style:
                          Styles.inter_13_500.copyWith(color: CustomColor.grey),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
