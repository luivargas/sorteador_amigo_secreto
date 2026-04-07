import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class SecretSantaAlert {
  static void show({
    required BuildContext context,
    required String message,
    String? title,
    required AlertType type,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _AnimatedBanner(
        message: message,
        type: type,
        icon: icon,
        duration: duration,
        onDismiss: () {
          overlayEntry.remove();
        }, title: title,
      ),
    );

    overlay.insert(overlayEntry);
  }
}

class _AnimatedBanner extends StatefulWidget {
  final String message;
  final AlertType type;
  final IconData? icon;
  final Duration duration;
  final String? title;
  final VoidCallback onDismiss;

  const _AnimatedBanner({
    required this.message,
    required this.type,
    this.icon,
    required this.duration,
    required this.onDismiss, this.title,
  });

  @override
  State<_AnimatedBanner> createState() => _AnimatedBannerState();
}

class _AnimatedBannerState extends State<_AnimatedBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );

    controller.forward();

    _startTimer();
  }

  void _startTimer() async {
    await Future.delayed(widget.duration);

    if (mounted) {
      await controller.reverse();
      widget.onDismiss();
    }
  }

  @override
  void dispose() {
    controller.dispose();
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
          position: slideAnimation,
          child: SecretSantaAlertTheme(
            message: widget.message,
            type: widget.type,
            icon: widget.icon, title: widget.title,
          ),
        ),
      ),
    );
  }
}

