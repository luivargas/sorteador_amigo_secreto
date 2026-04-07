import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class LoadingOrError extends StatelessWidget {
  final bool isLoading;
  final AppError? error;
  final Widget child;
  final VoidCallback? onRetry;

  const LoadingOrError({
    super.key,
    required this.isLoading,
    required this.error,
    required this.child,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(color: SecretSantaColors.accent),
      );
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              error!.localize(context),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null)
              TextButton(
                onPressed: onRetry,
                child: Text(l10n.retry),
              ),
          ],
        ),
      );
    }

    return child;
  }
}
