import 'package:circle/resources/constants.dart';
import 'package:flutter/material.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: const [
            Text('This is the Explore Screen')
          ],
        ),
      )),
      bottomNavigationBar: navbar,
    );
  }
}
