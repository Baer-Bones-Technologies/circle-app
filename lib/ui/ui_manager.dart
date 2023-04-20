import 'package:circle/resources/strings.dart';
import 'package:circle/utility/auth_handler.dart';
import 'package:flutter/material.dart';

const double _defaultWidth = 1.0;
const double _defaultHeight = 1.0;

class UIManager {
  final BuildContext _context;

  /// This class is used to manage the UI of the app and get the current screen size, width, height, and platform
  /// the app is running on. This class is also used to get the desired screen width
  /// and height for a widget to use.
  UIManager(this._context);

  Platform _platform = Platform.unknown;

  /// This function returns the current screen size
  Size getScreenSize() {
    return MediaQuery.of(_context).size;
  }

  /// This function returns the current screen width
  double getScreenWidth() {
    return getScreenSize().width;
  }

  /// This function returns the current screen height screen height
  double getScreenHeight() {
    return getScreenSize().height;
  }

  Size topBarSize() {
    return Size(getScreenWidth(), getMaxHeight(height: 0.1));
  }

  /// This function is used to get return the desired screen width for a widget
  /// to use, will default to max width if no width is provided.
  /// To set the width of the screen pass in a float equivalent to the percentage
  /// of the screen width you want the widget to take up.
  /// Example: 0.5 = 50% of the screen width
  /// Example: 0.25 = 25% of the screen width
  /// Example: 0.75 = 75% of the screen width

  double getMaxWidth({double width = _defaultWidth}) {
    double tempWidth = width;
    if (tempWidth > 1) {
      tempWidth = 1;
    }
    tempWidth = getScreenWidth() * tempWidth;
    return tempWidth;
  }

  /// This function is used to get return the desired screen height for a widget
  /// to use, will default to max height if no height is provided.
  /// To set the height of the screen pass in a float equivalent to the percentage
  /// of the screen height you want the widget to take up.
  ///
  /// **Example**:
  /// 0.5 = 50% of the screen height,
  /// 0.25 = 25% of the screen height,
  /// 0.75 = 75% of the screen height,

  double getMaxHeight({double height = _defaultHeight}) {
    double tempHeight = height;
    if (tempHeight > 1) {
      tempHeight = 1;
    }
    tempHeight = getScreenHeight() * tempHeight;
    return tempHeight;
  }

  /// This function returns the current platform the app is running on
  /// *i.e.: Android, iOS, Web, etc.*

  Platform getPlatform() {
    if (Theme.of(_context).platform == TargetPlatform.android) {
      return Platform.android;
    } else if (Theme.of(_context).platform == TargetPlatform.iOS) {
      return Platform.ios;
    } else {
      return Platform.web;
    }
  }

  /// This function checks if user is using a mobile device

  bool isMobile() {
    return getPlatform() == Platform.android || getPlatform() == Platform.ios;
  }

  /// function that checks which platform and returns widget accordingly
  Widget checkPlatform({Widget? web, Widget? mobile}) {
    return checkPlatformVerbose(
        web: web,
        mobile: mobile,
        loggedOutFallbackMobile: mobile,
        loggedOutFallbackWeb: web,
        authState: AuthenticationHandler().getAuthenticationState());
  }

  /// function that checks which platform and returns widget accordingly
  Widget checkPlatformVerbose(
      {Widget? web,
      Widget? mobile,
      Widget? loggedOutFallbackMobile,
      Widget? loggedOutFallbackWeb,
      required AuthState authState}) {
    _platform = getPlatform();
    switch (authState) {
      case AuthState.loggedIn:
        switch (_platform) {
          case Platform.web:
            return web ?? const Placeholder(child: Text(impossibleScreenError));
          case Platform.android:
          case Platform.ios:
            return mobile ??
                const Placeholder(child: Text(impossibleScreenError));
          case Platform.unknown:
            return const Placeholder(child: Text(unsupportedPlatformError));
        }

      case AuthState.loggedOut:
        switch (_platform) {
          case Platform.web:
            return loggedOutFallbackWeb ??
                web ??
                const Placeholder(child: Text(impossibleScreenError));
          case Platform.android:
          case Platform.ios:
            return loggedOutFallbackMobile ??
                mobile ??
                const Placeholder(child: Text(impossibleScreenError));
          case Platform.unknown:
            return const Placeholder(child: Text(unsupportedPlatformError));
        }
    }
  }
}

/// Enum for the platforms the app is running on
/// *i.e.: Android, iOS, Web, etc.*
///
/// values are:
/// ```dart
/// android,
/// ios,
/// web
/// ```
enum Platform { android, ios, web, unknown }
