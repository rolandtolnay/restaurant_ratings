import 'package:flutter/material.dart';

extension BuildContextTheme on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  double get topSafeArea => MediaQuery.of(this).padding.top;

  double get bottomSafeArea => MediaQuery.of(this).padding.bottom;

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Color get disabledColor => Theme.of(this).disabledColor;
}

extension BuildContextNavigatorConvenience on BuildContext {
  bool get isTopMostRoute => ModalRoute.of(this)?.isCurrent ?? false;

  bool get canPop => ModalRoute.of(this)?.canPop ?? false;
}

extension CommonColors on ColorScheme {
  Color get offWhite => const Color(0xFFF8F8F8);
}
