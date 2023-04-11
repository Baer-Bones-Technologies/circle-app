import 'package:circle/navigation/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().whenComplete(() =>
      runApp(MaterialApp.router(
           routerConfig: router,
         ))
  );
}