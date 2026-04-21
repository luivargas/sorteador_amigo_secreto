import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

enum AlertType { success, warning, info, error }

class AppAlert extends StatelessWidget {
  final String message;
  final AlertType type;
  final String? title;
  final IconData? icon;
  final List<Widget> actions;

  const AppAlert({
    super.key,
    required this.message,
    required this.type,
    this.title,
    this.icon,
    required this.actions,
  });

  static void showBanner(
    BuildContext context, {
    required String message,
    required AlertType type,
    String? title,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => _AnimatedBanner(
        message: message,
        type: type,
        title: title,
        icon: icon,
        duration: duration,
        onDismiss: () => entry.remove(),
      ),
    );

    overlay.insert(entry);
  }

  static Future<bool?> showAlertDialog(
    BuildContext context, {
    required String title,
    required String message,
    List<Widget>? actions,
  }) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title, style: SecretSantaTextStyles.titleSmall),
        content: Text(message),
        backgroundColor: SecretSantaColors.background,
        scrollable: true,
        actions: actions,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = _colorsFor(type);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.bg,
        borderRadius: BorderRadius.circular(SecretSantaRadius.xl),
        border: Border.all(color: colors.border, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Icon(icon ?? colors.defaultIcon, color: colors.text, size: 24),
          Expanded(
            child: Column(
              spacing: SecretSantaSpacing.xs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(title!),
                ],
                Text(message, style: SecretSantaTextStyles.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

_AlertColors _colorsFor(AlertType type) {
  switch (type) {
    case AlertType.success:
      return _AlertColors(
        bg: SecretSantaColors.successBg,
        text: SecretSantaColors.successText,
        border: SecretSantaColors.successBorder,
        defaultIcon: Icons.check_circle_outline,
      );
    case AlertType.warning:
      return _AlertColors(
        bg: SecretSantaColors.warningBg,
        text: SecretSantaColors.warningText,
        border: SecretSantaColors.warningBorder,
        defaultIcon: Icons.warning_amber_outlined,
      );
    case AlertType.info:
      return _AlertColors(
        bg: SecretSantaColors.infoBg,
        text: SecretSantaColors.infoText,
        border: SecretSantaColors.infoBorder,
        defaultIcon: Icons.info_outline,
      );
    case AlertType.error:
      return _AlertColors(
        bg: Colors.red.withAlpha(26),
        text: Colors.red,
        border: Colors.red.withAlpha(26),
        defaultIcon: Icons.error_outline,
      );
  }
}

class _AlertColors {
  final Color bg, text, border;
  final IconData defaultIcon;
  const _AlertColors({
    required this.bg,
    required this.text,
    required this.border,
    required this.defaultIcon,
  });
}

class _AnimatedBanner extends StatefulWidget {
  final String message;
  final AlertType type;
  final String? title;
  final IconData? icon;
  final Duration duration;
  final VoidCallback onDismiss;

  const _AnimatedBanner({
    required this.message,
    required this.type,
    this.title,
    this.icon,
    required this.duration,
    required this.onDismiss,
  });

  @override
  State<_AnimatedBanner> createState() => _AnimatedBannerState();
}

class _AnimatedBannerState extends State<_AnimatedBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
    _startTimer();
  }

  void _startTimer() async {
    await Future.delayed(widget.duration);
    if (mounted) {
      await _controller.reverse();
      widget.onDismiss();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: SlideTransition(
          position: _slide,
          child: AppAlert(
            message: widget.message,
            type: widget.type,
            title: widget.title,
            icon: widget.icon,
            actions: [],
          ),
        ),
      ),
    );
  }
}
