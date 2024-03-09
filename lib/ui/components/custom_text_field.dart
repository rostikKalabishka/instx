// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    this.onChanged,
    this.obscureText,
    required this.hintText,
  }) : super(key: key);
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String hintText;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      //obscureText: obscureText,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.secondary)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.secondary)),
      ),
    );
  }
}
