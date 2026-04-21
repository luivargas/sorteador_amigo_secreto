import 'package:flutter/material.dart';
import 'package:sorteador_amigo_secreto/i18n/app_localizations.dart';

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
  unknown,
}

extension AppErrorLocalize on AppError {
  String localize(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    switch (this) {
      case AppError.badRequest:      return i18n.errorBadRequest;
      case AppError.unauthorized:    return i18n.errorUnauthorized;
      case AppError.forbidden:       return i18n.errorForbidden;
      case AppError.notFound:        return i18n.errorNotFound;
      case AppError.conflict:        return i18n.errorConflict;
      case AppError.unprocessable:   return i18n.errorUnprocessable;
      case AppError.tooManyRequests: return i18n.errorTooManyRequests;
      case AppError.serverError:     return i18n.errorServer;
      case AppError.timeout:         return i18n.errorTimeout;
      case AppError.noConnection:    return i18n.errorNoConnection;
      case AppError.unknown:          return i18n.errorUnknow;
    }
  }
}
