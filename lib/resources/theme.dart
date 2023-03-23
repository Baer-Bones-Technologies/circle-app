import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CircleTheme {
  bool _lightMode = false;
  static Color primary = const Color(0xFF131313);
  static Color primaryGradientColor = const Color(0xFFA4DBED);
  static Color secondaryGradientColor = const Color(0xFF8462CD);
  static LinearGradient primaryGradient = LinearGradient(
    colors: [primaryGradientColor, secondaryGradientColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static Color secondary = const Color(0xFFFFFFFF);
  static Color tertiary = const Color(0x05D9D9D9);

  /// Toggles dark theme across the app
  void toggleLightTheme() {
    _lightMode = !_lightMode;
  }

  /// Returns current light mode
  bool isLightMode() {
    return _lightMode;
  }

  /// Changes the primary color of the app
  void changePrimaryColor(Color color) {
    primary = color;
  }

  /// Changes the secondary color of the app
  void changeSecondaryColor(Color color) {
    secondary = color;
  }

  /// Changes the tertiary color of the app
  void changeTertiaryColor(Color color) {
    tertiary = color;
  }

  /// Changes the primary gradient color
  void changePrimaryGradientColor(Color color) {
    primaryGradientColor = color;
  }

  /// Changes the secondary gradient color
  void changeSecondaryGradientColor(Color color) {
    secondaryGradientColor = color;
  }

  /// Save theme settings to local settings file
  void saveThemeSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('primary', primary.value);
    await prefs.setInt('secondary', secondary.value);
    await prefs.setInt('tertiary', tertiary.value);
    await prefs.setInt('primaryGradient', primaryGradientColor.value);
    await prefs.setInt('secondaryGradientColor', secondaryGradientColor.value);
  }

  /// Load theme settings from local settings file
  void loadThemeSettings() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? primaryValue = prefs.getInt('primary');
    int? secondaryValue = prefs.getInt('secondary');
    int? tertiaryValue = prefs.getInt('tertiary');
    int? primaryGradientValue = prefs.getInt('primaryGradient');
    int? secondaryGradientValue = prefs.getInt('secondaryGradientColor');
    if(primaryValue != null){
      primary = Color(primaryValue);
    }
    if(secondaryValue != null){
      secondary = Color(secondaryValue);
    }
    if(tertiaryValue != null){
      tertiary = Color(tertiaryValue);
    }
    if(primaryGradientValue != null){
      primaryGradientColor = Color(primaryGradientValue);
    }
    if(secondaryGradientValue != null){
      secondaryGradientColor = Color(secondaryGradientValue);
    }
  }
}
