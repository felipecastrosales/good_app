import 'package:flutter/material.dart';

extension MediaQueryExt on BuildContext {
  Size get mediaQuerySize => MediaQuery.of(this).size;

  double get width => mediaQuerySize.width;

  double get height => mediaQuerySize.height;
}
