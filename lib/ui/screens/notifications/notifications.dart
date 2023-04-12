import 'package:circle/navigation/mobile_navigation/navbar.dart';
import 'package:circle/resources/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: const [
            Text('This is the Notifications Screen')
          ],
        ),
      )),
      bottomNavigationBar: navbar,
    );
  }
}
