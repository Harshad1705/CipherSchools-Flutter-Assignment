import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../../theme/styles.dart';

class CustomTextField2 extends StatelessWidget {
   CustomTextField2({
    super.key,
    required this.controller
  });

  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: CustomColor.grey.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        controller: controller,
        style: Styles.inter_14_700,
        decoration: InputDecoration(
          hintText: 'Description',
          hintStyle: Styles.inter_16_400.copyWith(color: CustomColor.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }
}