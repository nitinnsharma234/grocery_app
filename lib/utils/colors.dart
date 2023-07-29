import 'package:flutter/material.dart';

Color lightSkyBlue = Color(0xFF9DCEFF);
Color white = Colors.white;
Color black = Colors.black;
const blueGradient = LinearGradient(
    colors: [Color(0xFF92A3FD), Color(0xFF9DCEFF)],
    begin: Alignment.topLeft,
    end: Alignment.topRight);
const purpleGradient = LinearGradient(
    colors: [Color(0xFFC58BF2), Color(0xFFEEA4CE)],
    begin: Alignment.topLeft,
    end: Alignment.topRight);
final Shader textGradient = const LinearGradient(
  colors: <Color>[Color(0xFF92A3FD), Color(0xFF9DCEFF)],
).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));



const blueThemeColor = Color(0xFF92A3FD);
const blueThemeColor2 = Color(0xFF9DCEFF);
const grey1=Color(0xFF7B6F72);
const grey2=Color(0xFFADA4A5);
const grey3=Color(0xFFDDDADA);
const borderColor=Color(0xFFF7F8F8);
const inputBorderColor=Color(0xFFFDFDFD);