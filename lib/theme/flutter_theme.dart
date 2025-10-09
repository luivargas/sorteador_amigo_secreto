import 'package:flutter/material.dart';

/// Secret Santa Design System
///
/// Este arquivo contém todo o design system baseado no site principal
/// do Secret Santa, incluindo cores, tipografia, componentes e estilos.

// ============================================================================
// CORES
// ============================================================================

class SecretSantaColors {
  // Cores principais (gradientes)
  static const Color accent = Color(0xFFf97316); // orange
  static const Color accent2 = Color(0xFFd946ef); // fuchsia
  static const Color accent3 = Color(0xFF22c55e); // emerald
  static const Color accent4 = Color(0xFF60a5fa); // blue

  // Escala neutral
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
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [accent, accent2],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [accent3, Color(0xFF16a34a)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient avatarGradient = LinearGradient(
    colors: [accent, accent2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// ============================================================================
// TIPOGRAFIA
// ============================================================================

class SecretSantaTextStyles {
  // Headings
  static const TextStyle h1 = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w900,
    height: 1.1,
    letterSpacing: -0.5,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w900,
    height: 1.1,
    letterSpacing: -0.5,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    height: 1.2,
  );

  static const TextStyle h4 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    height: 1.2,
  );

  // Body
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.75,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  // Labels
  static const TextStyle label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // Badge
  static const TextStyle badge = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3,
    height: 1.2,
  );

  // Button
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  static const TextStyle buttonLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
}

// ============================================================================
// SOMBRAS
// ============================================================================

class SecretSantaShadows {
  static const List<BoxShadow> small = [
    BoxShadow(
      color: Color.fromRGBO(17, 24, 39, 0.04),
      offset: Offset(0, 1),
      blurRadius: 3,
    ),
  ];

  static const List<BoxShadow> medium = [
    BoxShadow(
      color: Color.fromRGBO(17, 24, 39, 0.06),
      offset: Offset(0, 14),
      blurRadius: 40,
    ),
  ];

  static const List<BoxShadow> large = [
    BoxShadow(
      color: Color.fromRGBO(17, 24, 39, 0.08),
      offset: Offset(0, 20),
      blurRadius: 60,
    ),
  ];

  static const List<BoxShadow> button = [
    BoxShadow(
      color: Color.fromRGBO(249, 115, 22, 0.25),
      offset: Offset(0, 16),
      blurRadius: 40,
    ),
  ];

  static const List<BoxShadow> buttonHover = [
    BoxShadow(
      color: Color.fromRGBO(249, 115, 22, 0.35),
      offset: Offset(0, 20),
      blurRadius: 50,
    ),
  ];
}

// ============================================================================
// TEMA PRINCIPAL
// ============================================================================

class SecretSantaTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,

      // Cores
      colorScheme: ColorScheme.light(
        primary: SecretSantaColors.accent,
        secondary: SecretSantaColors.accent2,
        tertiary: SecretSantaColors.accent3,
        surface: Colors.white,
        error: SecretSantaColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: SecretSantaColors.neutral900,
        onError: Colors.white,
      ),

      // Tipografia
      textTheme: TextTheme(
        displayLarge: SecretSantaTextStyles.h1.copyWith(
          color: SecretSantaColors.neutral900,
        ),
        displayMedium: SecretSantaTextStyles.h2.copyWith(
          color: SecretSantaColors.neutral900,
        ),
        displaySmall: SecretSantaTextStyles.h3.copyWith(
          color: SecretSantaColors.neutral900,
        ),
        headlineMedium: SecretSantaTextStyles.h4.copyWith(
          color: SecretSantaColors.neutral900,
        ),
        bodyLarge: SecretSantaTextStyles.bodyLarge.copyWith(
          color: SecretSantaColors.neutral700,
        ),
        bodyMedium: SecretSantaTextStyles.body.copyWith(
          color: SecretSantaColors.neutral700,
        ),
        bodySmall: SecretSantaTextStyles.bodySmall.copyWith(
          color: SecretSantaColors.neutral600,
        ),
        labelLarge: SecretSantaTextStyles.label.copyWith(
          color: SecretSantaColors.neutral700,
        ),
        labelMedium: SecretSantaTextStyles.labelSmall.copyWith(
          color: SecretSantaColors.neutral600,
        ),
      ),

      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: SecretSantaColors.neutral200,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: SecretSantaColors.neutral200,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: SecretSantaColors.accent,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: SecretSantaColors.error,
            width: 1,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),

      // Cards
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: SecretSantaColors.neutral200,
            width: 1,
          ),
        ),
        shadowColor: Color.fromRGBO(17, 24, 39, 0.06),
      ),

      // Dividers
      dividerTheme: DividerThemeData(
        color: SecretSantaColors.neutral200,
        thickness: 1,
        space: 1,
      ),
    );
  }
}

// ============================================================================
// COMPONENTES CUSTOMIZADOS
// ============================================================================

/// Botão com gradiente (Primary)
class GradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLarge;
  final IconData? icon;
  final bool isLoading;

  const GradientButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLarge = false,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: SecretSantaColors.primaryGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: SecretSantaShadows.button,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isLarge ? 40 : 28,
              vertical: isLarge ? 18 : 14,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null && !isLoading) ...[
                  Icon(icon, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                ],
                if (isLoading)
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                else
                  Text(
                    text,
                    style: (isLarge
                            ? SecretSantaTextStyles.buttonLarge
                            : SecretSantaTextStyles.button)
                        .copyWith(color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Botão secundário
class SecondaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isSmall;
  final IconData? icon;

  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isSmall = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: isSmall ? 16 : 28,
          vertical: isSmall ? 8 : 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        side: BorderSide(
          color: SecretSantaColors.neutral200,
          width: 1,
        ),
        backgroundColor: SecretSantaColors.neutral100,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: SecretSantaColors.neutral900),
            SizedBox(width: 8),
          ],
          Text(
            text,
            style: (isSmall
                    ? SecretSantaTextStyles.bodySmall
                    : SecretSantaTextStyles.button)
                .copyWith(color: SecretSantaColors.neutral900),
          ),
        ],
      ),
    );
  }
}

/// Card com sombra e borda
class SecretSantaCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  const SecretSantaCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: SecretSantaColors.neutral200,
          width: 1,
        ),
        boxShadow: SecretSantaShadows.medium,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: padding ?? EdgeInsets.all(24),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Badge colorido
class SecretSantaBadge extends StatelessWidget {
  final BadgeType type;

  const SecretSantaBadge({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    Color borderColor;
    String text;

    switch (type) {
      case BadgeType.pending:
        bgColor = SecretSantaColors.warningBg;
        textColor = SecretSantaColors.warningText;
        borderColor = SecretSantaColors.warningBorder;
        text = 'Aguardando Sorteio';
        break;
      case BadgeType.raffled:
        bgColor = SecretSantaColors.successBg;
        textColor = SecretSantaColors.successText;
        borderColor = SecretSantaColors.successBorder;
        text = 'Sorteio Realizado';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Text(
        text.toUpperCase(),
        style: SecretSantaTextStyles.badge.copyWith(color: textColor),
      ),
    );
  }
}

enum BadgeType {
  pending,
  raffled,
}

/// Avatar circular com gradiente
class GradientAvatar extends StatelessWidget {
  final String initials;
  final double size;

  const GradientAvatar({
    super.key,
    required this.initials,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: SecretSantaColors.avatarGradient,
        shape: BoxShape.circle,
        boxShadow: size > 80
            ? [
                BoxShadow(
                  color: Color.fromRGBO(249, 115, 22, 0.3),
                  offset: Offset(0, 20),
                  blurRadius: 60,
                )
              ]
            : null,
      ),
      child: Center(
        child: Text(
          initials.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.4,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

/// Alert/Banner informativo
class SecretSantaAlert extends StatelessWidget {
  final String title;
  final String message;
  final AlertType type;
  final IconData? icon;

  const SecretSantaAlert({
    super.key,
    required this.title,
    required this.message,
    required this.type,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    Color borderColor;
    IconData defaultIcon;

    switch (type) {
      case AlertType.success:
        bgColor = SecretSantaColors.successBg;
        textColor = SecretSantaColors.successText;
        borderColor = SecretSantaColors.successBorder;
        defaultIcon = Icons.check_circle_outline;
        break;
      case AlertType.warning:
        bgColor = SecretSantaColors.warningBg;
        textColor = SecretSantaColors.warningText;
        borderColor = SecretSantaColors.warningBorder;
        defaultIcon = Icons.warning_amber_outlined;
        break;
      case AlertType.info:
        bgColor = SecretSantaColors.infoBg;
        textColor = SecretSantaColors.infoText;
        borderColor = SecretSantaColors.infoBorder;
        defaultIcon = Icons.info_outline;
        break;
    }

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon ?? defaultIcon,
            color: textColor,
            size: 24,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: SecretSantaTextStyles.label.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  message,
                  style: SecretSantaTextStyles.bodySmall.copyWith(
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum AlertType {
  success,
  warning,
  info,
}

/// Input customizado
class SecretSantaTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final bool isRequired;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final int? maxLines;

  const SecretSantaTextField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.isRequired = false,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isRequired ? '$label *' : label,
          style: SecretSantaTextStyles.label.copyWith(
            color: SecretSantaColors.neutral700,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: SecretSantaTextStyles.body.copyWith(
              color: SecretSantaColors.neutral400,
            ),
          ),
        ),
      ],
    );
  }
}



// ============================================================================
// ESPAÇAMENTOS PADRÃO
// ============================================================================

class SecretSantaSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;
}

// ============================================================================
// BORDER RADIUS PADRÃO
// ============================================================================

class SecretSantaRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double full = 999;
}
