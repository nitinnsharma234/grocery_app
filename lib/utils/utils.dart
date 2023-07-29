import 'package:flutter/material.dart';
import 'package:grocery_app/utils/textStyles.dart';

import 'colors.dart';



final Map<int, Color> _yellow700Map = {
  50: const Color(0xFF92A3FD),
  100: Colors.yellow[100]!,
  200: Colors.yellow[200]!,
  300: Colors.yellow[300]!,
  400: Colors.yellow[400]!,
  500: Colors.yellow[500]!,
  600: Colors.yellow[600]!,
  700: Colors.yellow[800]!,
  800: Colors.yellow[900]!,
  900: Colors.yellow[700]!,
};

final MaterialColor customSwatch =
    MaterialColor(Colors.yellow[50]!.value, _yellow700Map);


Widget gradientButton(String tittle,Function()onPressed) => Container(
  decoration:  BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: blueGradient),
  child: ElevatedButton(
    onPressed:onPressed,
    style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(30),
        foregroundColor: blueThemeColor,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent, shadowColor: Colors.transparent,),
    child: Text(tittle,style: whiteH4Bold,),
  ),
);

Widget shadeButton(String tittle,Function()onPressed) => Container(
  decoration:  BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color:Colors.pinkAccent[100]),
  child: ElevatedButton(
    onPressed:onPressed,
    style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(30),
        foregroundColor: blueThemeColor,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent, shadowColor: Colors.transparent,),
    child: Text(tittle,style: whiteH4Bold,),
  ),
);











//TextStyles
