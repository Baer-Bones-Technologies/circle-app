import 'package:circle/resources/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// This is a button widget to be used throughout the application
class SingleLineInput extends StatelessWidget {
  const SingleLineInput(
      {Key? key,
      this.controller,
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
      this.height = 50,
      this.obscureText = false})
      : super(key: key);

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? label;
  final String? hintText;
  final BoxConstraints? constraints;
  final TextCapitalization textCapitalization;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onEditingComplete;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final double height;
  final double width;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        controller: controller,
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
        inputFormatters: inputFormatters,
        style: TextStyle(color: CircleTheme.secondary),
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: CircleTheme.secondaryGradientColor, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: CircleTheme.primaryGradientColor, width: 1),
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
    );
  }
}
