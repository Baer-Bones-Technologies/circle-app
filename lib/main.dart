import 'package:circle/navigation/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().whenComplete(() =>
      runApp(MaterialApp.router(
        routerConfig: router,
      ))
  );

}