import 'package:flutter/material.dart';
Widget txt(
    Color color,
    String text,
    double size,
    ) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.bold,
    ),);
}