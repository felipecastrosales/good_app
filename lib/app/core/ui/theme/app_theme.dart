import 'package:flutter/material.dart';

import 'package:good_app/app/core/ui/colors/app_colors.dart';

class AppTheme {
  AppTheme._();
  static ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.primary,
        ),
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: AppColors.primary,
            ),
      );
}
