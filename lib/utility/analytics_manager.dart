import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsManager{
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// This function is used to log an event to Firebase Analytics
void logEvent(String name, Map<String, dynamic> parameters) {
  _analytics.logEvent(name: name, parameters: parameters);
}

}