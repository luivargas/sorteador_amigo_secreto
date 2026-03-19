
import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';

class LoadingOrError extends StatelessWidget {
  final bool isLoading;
  final String? error;
  final Widget child;

  const LoadingOrError({
    super.key,
    required this.isLoading,
    required this.error,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(color: myProgressIndicator.color),
      );
    }
    if (error != null) {
      return Center(child: Text('Tente novamente'));
    }
    return child;
  }
}
