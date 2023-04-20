import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CircleTheme {
  bool _lightMode = false;
  static ValueNotifier<Color> primary =  ValueNotifier(const Color(0xFF131313));
  static ValueNotifier<Color> primaryGradientColor = ValueNotifier(const Color(0xFFA4DBED));
  static ValueNotifier<Color> secondaryGradientColor =  ValueNotifier(const Color(0xFF8462CD));
  static LinearGradient primaryGradient = LinearGradient(
    colors: [primaryGradientColor.value, secondaryGradientColor.value],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static ValueNotifier<Color> secondary = ValueNotifier(const Color(0xFFFFFFFF));
  static ValueNotifier<Color> tertiary = ValueNotifier(const Color(0x05D9D9D9));

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
    primary.value = color;
  }

  /// Changes the secondary color of the app
  void changeSecondaryColor(Color color) {
    secondary.value = color;
  }

  /// Changes the tertiary color of the app
  void changeTertiaryColor(Color color) {
    tertiary.value = color;
  }

  /// Changes the primary gradient color
  void changePrimaryGradientColor(Color color) {
    primaryGradientColor.value = color;
  }

  /// Changes the secondary gradient color
  void changeSecondaryGradientColor(Color color) {
    secondaryGradientColor.value = color;
  }

  /// Save theme settings to local settings file
  void saveThemeSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('primary', primary.value.value);
    await prefs.setInt('secondary', secondary.value.value);
    await prefs.setInt('tertiary', tertiary.value.value);
    await prefs.setInt('primaryGradient', primaryGradientColor.value.value);
    await prefs.setInt('secondaryGradientColor', secondaryGradientColor.value.value);
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
      primary.value = Color(primaryValue);
    }
    if(secondaryValue != null){
      secondary.value = Color(secondaryValue);
    }
    if(tertiaryValue != null){
      tertiary.value = Color(tertiaryValue);
    }
    if(primaryGradientValue != null){
      primaryGradientColor.value = Color(primaryGradientValue);
    }
    if(secondaryGradientValue != null){
      secondaryGradientColor.value = Color(secondaryGradientValue);
    }
  }
}
