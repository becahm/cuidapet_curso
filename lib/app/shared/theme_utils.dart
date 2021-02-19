import 'package:flutter/material.dart';

class ThemeUtils {
  static ThemeData theme;
  static Color primaryColor;
  static Color primaryColorDark;
  static Color primaryColorLight;
  static Color accentColor;

  static void init(BuildContext context) {
    theme = Theme.of(context);
    primaryColor = theme.primaryColor;
    primaryColorDark = theme.primaryColorDark;
    primaryColorLight = theme.primaryColorLight;
    accentColor = theme.accentColor;
  }
}
