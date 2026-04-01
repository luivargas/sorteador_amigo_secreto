import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';

enum AppError {
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  conflict,
  unprocessable,
  tooManyRequests,
  serverError,
  timeout,
  noConnection,
  unknow,
}

extension AppErrorLocalize on AppError {
  String localize(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case AppError.badRequest:      return l10n.errorBadRequest;
      case AppError.unauthorized:    return l10n.errorUnauthorized;
      case AppError.forbidden:       return l10n.errorForbidden;
      case AppError.notFound:        return l10n.errorNotFound;
      case AppError.conflict:        return l10n.errorConflict;
      case AppError.unprocessable:   return l10n.errorUnprocessable;
      case AppError.tooManyRequests: return l10n.errorTooManyRequests;
      case AppError.serverError:     return l10n.errorServer;
      case AppError.timeout:         return l10n.errorTimeout;
      case AppError.noConnection:    return l10n.errorNoConnection;
      case AppError.unknow:          return l10n.errorUnknow;
    }
  }
}
