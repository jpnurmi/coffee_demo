import 'package:flutter/material.dart';

import 'constants.dart';

final baseTheme = ThemeData.light();
final kTextColor = Colors.grey[900];

final theme = baseTheme.copyWith(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.white,
      onPrimary: kTextColor,
      padding: const EdgeInsets.all(kSpacing),
      minimumSize: const Size(4 * kPadding, kPadding),
      textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  textTheme: baseTheme.textTheme.merge(
    TextTheme(
      button: TextStyle(color: kTextColor),
      headline4: TextStyle(
        color: kTextColor,
        fontSize: 36,
        fontWeight: FontWeight.w500,
      ),
      bodyText1: TextStyle(
        color: kTextColor,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      bodyText2: TextStyle(
        color: kTextColor,
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
      subtitle1: TextStyle(
        color: kTextColor,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
);
