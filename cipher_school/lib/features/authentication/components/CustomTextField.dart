import 'package:flutter/material.dart';

import '../../../theme/styles.dart';
import '../auth_controller.dart';
class CustomTextField extends StatelessWidget {
   CustomTextField({
    super.key,
    required this.controller,
    required this.title,
  }) ;

  TextEditingController controller;
  String title;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(
              width: 1,
            ),
          ),
          focusedBorder: Styles.outlineInputBorder,
          disabledBorder: Styles.outlineInputBorder,
          enabledBorder: Styles.outlineInputBorder,
          errorBorder: Styles.outlineInputBorder,
          focusedErrorBorder: Styles.outlineInputBorder,
          hintText: title,

          hintStyle: Styles.inter_16_400,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
        ),
      ),
    );
  }
}