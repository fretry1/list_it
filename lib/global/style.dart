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

  static InputDecoration defaultTextFieldDecoration({required String labelText, Color? color}) {
    return InputDecoration(
      labelText: labelText,
      alignLabelWithHint: true,
      labelStyle: TextStyle(color: Colors.grey[500]),
      floatingLabelStyle: const TextStyle(color: AppColors.green_600),
      filled: true,
      fillColor: color ?? AppColors.grey_50,
      enabledBorder: AppStyles.defaultEnabledBorder,
      focusedBorder: AppStyles.defaultFocusBorder,
      isDense: true,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.red_600),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.red_600),
      ),
    );
  }

  static final OutlineInputBorder defaultEnabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide.none,
  );

  static final OutlineInputBorder defaultFocusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: AppColors.green_600),
  );
}