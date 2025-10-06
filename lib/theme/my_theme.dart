import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/theme/my_colors.dart';

ThemeData myTheme = ThemeData(
  useMaterial3: true,
  primaryColor: MyColors.sorteadorBackground,
  appBarTheme: AppBarTheme(
    backgroundColor: MyColors.sorteadorOrange,
    titleSpacing: 100,
  ),
  canvasColor: MyColors.sorteadorBackground,
  inputDecorationTheme: InputDecorationTheme(
    iconColor: MyColors.sorteadorRoxo,
    prefixIconColor: MyColors.sorteadorRoxo,
    labelStyle: TextStyle(color: MyColors.sorteadorOrange),
    hintStyle: TextStyle(color: MyColors.sorteadorOrange),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: MyColors.sorteadorGrey),
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
  ),
  textTheme: TextTheme(
    titleSmall: TextStyle(
      fontSize: 20,
      color: MyColors.sorteadorGrey,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      fontSize: 30,
      color: MyColors.sorteadorGrey,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      fontSize: 40,
      color: MyColors.sorteadorGrey,
      fontWeight: FontWeight.bold,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStateProperty<TextStyle?>.fromMap(
        <WidgetStatesConstraint, TextStyle?>{
          WidgetState.any: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
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
