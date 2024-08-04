import 'package:flutter/material.dart';
import 'package:list_it/global/color.dart';

class AppStyles {
  static final ButtonStyle defaultButton = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(AppColors.green_600),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      )
    )
  );
  static final ButtonStyle defaultDisabledButton = ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(AppColors.grey_300),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
          )
      )
  );
}