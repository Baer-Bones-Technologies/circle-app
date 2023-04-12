import 'package:circle/resources/constants.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.uid}) : super(key: key);
  final String? uid;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: const [Text('This is the Profile Screen')],
        ),
      )),
      bottomNavigationBar: navbar,
    );
  }
}
