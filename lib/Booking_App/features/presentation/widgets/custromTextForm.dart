import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormFiled extends StatelessWidget {
  TextEditingController controller;
  final TextInputType type;
  final String? labeltext;
  final String hintText;
  final IconData? suffix;
  final Widget? prefix;
  final bool obscureText;
  final VoidCallback? suffixFun;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  String? Function(String?)? onSubmited;
  TextStyle? style;
  final Color color;
  String? Function(String?)? validation;


  CustomTextFormFiled({
    required  this.controller,
    required this.type,
    required this.labeltext,
    required  this.hintText,
    this.suffix,
    this.prefix,
    required this.obscureText,
    this.suffixFun,
    this.onChanged,
    this.onTap,
    this.onSubmited,
    this.style,
    required   this.color,
    this.validation});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style,
      validator: validation,
      controller: controller,
      keyboardType: type,
      obscureText: obscureText,
      onChanged: onChanged,
      onFieldSubmitted: onSubmited,
      onTap: onTap,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color),
        ),
        border: OutlineInputBorder(),
        labelText: labeltext,
        hintText: hintText,
        hintStyle: TextStyle(color: Color(0xFF8D8E98)),
        labelStyle: TextStyle(color: color),
        prefixIcon: prefix,
        suffixIcon: IconButton(
            icon: Icon(suffix, color: color), onPressed: suffixFun),
      ),
    );
  }
}
