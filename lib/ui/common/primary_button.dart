import 'package:circle/resources/theme.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({Key? key, required this.onPressed, this.onLongPress,this.controller, required this.text, this.width = 75, this.height = 40, this.elevation = 0.00, this.padding = 3.0, this.borderRadius = 8.0}) : super(key: key);

  final Function() onPressed;
  final Function()? onLongPress;
  final MaterialStatesController? controller;
  final String text;
  final double height;
  final double width;
  final double elevation;
  final double padding;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(CircleTheme.secondaryGradientColor),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            elevation: MaterialStateProperty.all(elevation),
            padding: MaterialStateProperty.all(EdgeInsets.all(padding)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      side: BorderSide(color: CircleTheme.secondaryGradientColor)
                  )
              )
          ),
          statesController: controller,
          child: Text(text)
      ),
    );
  }
}
