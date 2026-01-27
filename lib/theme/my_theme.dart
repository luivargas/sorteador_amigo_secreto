import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

ProgressIndicatorThemeData myProgressIndicator = ProgressIndicatorThemeData(
  color: MyColors.sorteadorOrange,
);

ThemeData myTheme = ThemeData(
  primaryColor: MyColors.sorteadorBackground,
  appBarTheme: AppBarTheme(backgroundColor: MyColors.sorteadorBackground),
  canvasColor: MyColors.sorteadorBackground,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    iconColor: MyColors.sorteadorPurpple,
    prefixIconColor: MyColors.sorteadorPurpple,
    labelStyle: TextStyle(color: MyColors.sorteadorOrange),
    hintStyle: TextStyle(color: MyColors.sorteadorOrange),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: MyColors.sorteadorOrange),
      borderRadius: BorderRadius.circular(15),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: MyColors.sorteadorOrange),
      borderRadius: BorderRadius.circular(15),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: MyColors.sorteadorOrange),
      borderRadius: BorderRadius.circular(15),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: MyColors.neutral700),
      borderRadius: BorderRadius.circular(15),
    ),
  ),
  textTheme: TextTheme(
    titleSmall: TextStyle(
      fontSize: 20,
      color: MyColors.sorteadorGrey,
      fontWeight: FontWeight.w800,
    ),
    titleMedium: TextStyle(
      fontSize: 35,
      color: MyColors.sorteadorGrey,
      fontWeight: FontWeight.w800,
    ),
    titleLarge: TextStyle(
      fontSize: 60,
      color: MyColors.sorteadorGrey,
      fontWeight: FontWeight.w800,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStateProperty<TextStyle?>.fromMap(
        <WidgetStatesConstraint, TextStyle?>{
          WidgetState.any: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        },
      ),
      backgroundColor: WidgetStateProperty<Color>.fromMap(
        <WidgetStatesConstraint, Color>{
          WidgetState.any: MyColors.sorteadorOrange,
        },
      ),
      foregroundColor: WidgetStateProperty<Color>.fromMap(
        <WidgetStatesConstraint, Color>{WidgetState.any: Colors.white},
      ),
      minimumSize: WidgetStateProperty<Size?>.fromMap(
        <WidgetStatesConstraint, Size?>{WidgetState.any: Size(0, 50)},
      ),
      iconSize: WidgetStateProperty<double?>.fromMap(
        <WidgetStatesConstraint, double?>{WidgetState.any: 20.0},
      ),
    ),
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: MyColors.sorteadorOrange,
    labelTextStyle: WidgetStateProperty<TextStyle?>.fromMap(
      <WidgetStatesConstraint, TextStyle?>{
        WidgetState.any: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      },
    ),
  ),
);
