import 'package:circle/navigation/mobile_navigation/navbar.dart';
import 'package:circle/resources/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: const [
            Text('This is the Create Screen')
          ],
        ),
      )),
      bottomNavigationBar: navbar,
    );
  }
}
