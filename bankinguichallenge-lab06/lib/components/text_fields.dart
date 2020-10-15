import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Text Field to be used by multiple forms in TwoTP
class AdvancedFormTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function validator;
  final Function onChanged;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final bool enabled;

  AdvancedFormTextField(
      {this.controller,
        this.keyboardType,
        this.validator,
        this.onChanged,
        this.enabled,
        this.hintText = "",
        this.labelText,
        this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validator,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        enabled: enabled,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          filled: true,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.transparent
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.transparent
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.transparent
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.transparent
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.transparent
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.transparent
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        onChanged: onChanged);
  }
}
