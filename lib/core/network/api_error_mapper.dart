import 'package:dio/dio.dart';
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';

/// Converte um [DioException] em uma mensagem amigável para o usuário.
///
/// Nunca expõe o corpo da resposta da API — mapeia apenas o status HTTP
/// e o tipo de erro de rede para mensagens genéricas e seguras.
class ApiErrorMapper {
  static AppError map(DioException e) {
    // Erro com resposta HTTP → mapeia pelo status code
    final statusCode = e.response?.statusCode;
    if (statusCode != null) {
      return _fromStatusCode(statusCode);
    }

    // Erro de rede / sem resposta → mapeia pelo tipo do erro
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppError.timeout;
      case DioExceptionType.connectionError:
        return AppError.noConnection;
      default:
        return AppError.unknow;
    }
  }

  static AppError _fromStatusCode(int code) {
    switch (code) {
      case 400:
        return AppError.badRequest;
      case 401:
        return AppError.unauthorized;
      case 403:
        return AppError.forbidden;
      case 404:
        return AppError.notFound;
      case 409:
        return AppError.conflict;
      case 422:
        return AppError.unprocessable;
      case 429:
        return AppError.tooManyRequests;
      case 500:
      case 502:
      case 503:
      case 504:
        return AppError.serverError;
      default:
        return AppError.unknow;
    }
  }
}
