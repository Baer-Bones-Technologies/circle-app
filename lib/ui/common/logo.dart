import 'package:circle/resources/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:circle/resources/strings.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        gradient: CircleTheme.primaryGradient,
        borderRadius: BorderRadius.circular(50),
        ),
      child: Center(
        child: Text(appTitle, style: TextStyle(
          color: CircleTheme.primary,
          fontSize: 30,
        )),
      )
    );
  }
}
