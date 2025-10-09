import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyColors {
  static const Color sorteadorOrange = Color(0xFFF97316);
  static Color sorteadorGrey = Color(0xFF333333);
  static Color sorteadorGreen = Color(0xFF22c55e);
  static Color sorteadorRed = Color(0xFFE11D48);
  static LinearGradient sorteadorGradient = LinearGradient(
    colors: <Color>[Color(0xFFF97316), Color(0xFFd946ef)],
  );
    static LinearGradient sorteadorGradient2 = LinearGradient(
    colors: <Color>[Color(0xFFF97316), Color(0xFF333333)],
  );
  static Color sorteadorBackground = Color(0xFFFFF7ED);
  static Color sorteadorPurpple = Color(0xFFd946ef);
  static const Color neutral50 = Color(0xFFfafafa);
  static const Color neutral100 = Color(0xFFf5f5f5);
  static const Color neutral200 = Color(0xFFe5e5e5);
  static const Color neutral300 = Color(0xFFd4d4d4);
  static const Color neutral400 = Color(0xFFa3a3a3);
  static const Color neutral500 = Color(0xFF737373);
  static const Color neutral600 = Color(0xFF525252);
  static const Color neutral700 = Color(0xFF404040);
  static const Color neutral800 = Color(0xFF262626);
  static const Color neutral900 = Color(0xFF171717);

  // Cores de status
  static const Color success = Color(0xFF22c55e);
  static const Color warning = Color(0xFFf97316);
  static const Color error = Color(0xFFef4444);
  static const Color info = Color(0xFF60a5fa);

  // Backgrounds de badges/alerts
  static const Color successBg = Color(0xFFecfdf5);
  static const Color successBorder = Color(0xFFa7f3d0);
  static const Color successText = Color(0xFF065f46);

  static const Color warningBg = Color(0xFFfff7ed);
  static const Color warningBorder = Color(0xFFfed7aa);
  static const Color warningText = Color(0xFF7a2e0e);

  static const Color infoBg = Color(0xFFdbeafe);
  static const Color infoBorder = Color(0xFF93c5fd);
  static const Color infoText = Color(0xFF1e3a8a);

  // Gradientes
  static final LinearGradient primaryGradient = LinearGradient(
    colors: [sorteadorOrange, sorteadorPurpple],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static final LinearGradient successGradient = LinearGradient(
    colors: [sorteadorGreen, const Color(0xFF16a34a)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static final LinearGradient avatarGradient = LinearGradient(
    colors: [sorteadorOrange, sorteadorPurpple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

