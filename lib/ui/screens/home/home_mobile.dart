import 'package:circle/resources/constants.dart';
import 'package:circle/resources/theme.dart';
import 'package:circle/ui/common/common_ui.dart';
import 'package:flutter/material.dart';

/// This class is the stateful widget for the Main Home Feed Screen for Mobile.
///
/// This checks if user is logged in and if so, displays the home feed.
/// Otherwise, it displays the login screen.

class HomeMobile extends StatefulWidget {
  const HomeMobile({super.key});

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: circleTopAppBar(context),
      backgroundColor: CircleTheme.primary.value,
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: const [
            Text('This is the Home Screen')
          ],
        ),
      )),
      bottomNavigationBar: navbar,
    );
  }
}
