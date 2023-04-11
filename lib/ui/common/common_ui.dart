import 'package:circle/resources/strings.dart';
import 'package:circle/resources/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
/// This is the circle Logo
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
          child: Text(appTitle,
              style: TextStyle(
                color: CircleTheme.primary,
                fontSize: 30,
              )),
        ));
  }
}

/// This is a input field widget to be used throughout the application
class SingleLineInput extends StatelessWidget {
  const SingleLineInput(
      {Key? key,
      this.controller,
      this.focusNode,
      this.keyboardType,
      this.label,
      this.hintText,
      this.constraints,
      this.onChanged,
      this.onSubmitted,
      this.onEditingComplete,
      this.textCapitalization = TextCapitalization.sentences,
      this.enabled = true,
      this.inputFormatters,
      this.width = 300,
      this.height = 70,
      this.obscureText = false,
      this.onTap,
      this.errorText = '',
      this.errorThrown = false,
      this.readOnly = false})
      : super(key: key);

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final String? label;
  final String? hintText;
  final BoxConstraints? constraints;
  final TextCapitalization textCapitalization;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final bool enabled;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final double? height;
  final double? width;
  final bool obscureText;
  final String errorText;
  final bool errorThrown;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Column(
        children: [
          Visibility(
              visible: errorThrown,
              child: Text(errorText,
                  style: const TextStyle(color: Colors.red))),
          TextField(
            controller: controller,
            focusNode: focusNode,
            onTap: onTap,
            keyboardType: keyboardType,
            autocorrect: false,
            enableSuggestions: true,
            maxLines: 1,
            cursorColor: CircleTheme.primaryGradientColor,
            textAlign: TextAlign.start,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            onEditingComplete: onEditingComplete,
            enabled: enabled,
            readOnly: readOnly,
            inputFormatters: inputFormatters,
            style: TextStyle(color: CircleTheme.secondary),
            obscureText: obscureText,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: CircleTheme.secondaryGradientColor, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: CircleTheme.primaryGradientColor, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: CircleTheme.secondary, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              labelText: label,
              labelStyle: TextStyle(color: CircleTheme.secondary),
              hintText: hintText,
              hintStyle: TextStyle(color: CircleTheme.secondary),
            ),
            textCapitalization: textCapitalization,
          ),
        ],
      ),
    );
  }
}

/// This is the primary button used within the app
class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key,
      required this.onPressed,
      this.onLongPress,
      required this.text,
      this.width = 75,
      this.height = 40,
      this.elevation = 0.00,
      this.padding = 3.0,
      this.borderRadius = 8.0})
      : super(key: key);

  final Function() onPressed;
  final Function()? onLongPress;
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
              backgroundColor: MaterialStateProperty.all<Color>(
                  CircleTheme.secondaryGradientColor),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              elevation: MaterialStateProperty.all(elevation),
              padding: MaterialStateProperty.all(EdgeInsets.all(padding)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      side: BorderSide(
                          color: CircleTheme.secondaryGradientColor)))),
          child: Text(text)),
    );
  }
}

/// This is a labeled input field
class LabelTextInput extends StatelessWidget {
  const LabelTextInput(
      {Key? key,
      this.controller,
      this.focusNode,
      this.keyboardType,
      required this.label,
      this.hintText,
      this.constraints,
      this.onChanged,
      this.onSubmitted,
      this.onEditingComplete,
      this.textCapitalization = TextCapitalization.sentences,
      this.enabled = true,
      this.inputFormatters,
      this.width = 300,
      this.height = 100,
      this.obscureText = false,
      this.onTap,
      this.readOnly = false,
      this.errorText = '',
      this.errorThrown = false,
      this.maxLines = 1,
      this.textAlign = TextAlign.start})
      : super(key: key);

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final String label;
  final String? hintText;
  final BoxConstraints? constraints;
  final TextCapitalization textCapitalization;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onEditingComplete;
  final Function()? onTap;
  final bool enabled;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final double height;
  final double width;
  final bool obscureText;
  final String errorText;
  final bool errorThrown;
  final int maxLines;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
              visible: errorThrown,
              child: Text(errorText,
                  style: const TextStyle(color: Colors.red))),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ],
          ),
          TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            autocorrect: false,
            enableSuggestions: true,
            maxLines: maxLines,
            cursorColor: CircleTheme.primaryGradientColor,
            textAlign: textAlign,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            onEditingComplete: onEditingComplete,
            enabled: enabled,
            readOnly: readOnly,
            onTap: onTap,
            inputFormatters: inputFormatters,
            style: TextStyle(color: CircleTheme.secondary),
            obscureText: obscureText,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: CircleTheme.secondaryGradientColor, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: CircleTheme.primaryGradientColor, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: CircleTheme.secondary, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              labelStyle: TextStyle(color: CircleTheme.secondary),
              hintText: hintText,
              hintStyle: TextStyle(color: CircleTheme.secondary),
            ),
            textCapitalization: textCapitalization,
          ),
        ],
      ),
    );
  }
}