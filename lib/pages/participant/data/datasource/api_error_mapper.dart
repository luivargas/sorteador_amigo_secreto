import 'package:dio/dio.dart';

class ApiErrorMapper {
  static String map(DioException e) {
    // 1. Erro vindo da API (HTTP 4xx / 5xx)
    if (e.response != null) {
      final data = e.response!.data;

      // API retorna JSON
      if (data is Map<String, dynamic>) {
        return data['message'] ??
               data['errors'] ??
               data['error'] ??
               data['detail'] ??
               'Erro inesperado no servidor';
      }

      // API retorna texto puro
      if (data is String) {
        return data;
      }

      return 'Erro inesperado no servidor';
    }

    // 2. Erros de rede / Dio
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Tempo de conexão esgotado';
      case DioExceptionType.sendTimeout:
        return 'Erro ao enviar dados';
      case DioExceptionType.receiveTimeout:
        return 'Tempo de resposta esgotado';
      case DioExceptionType.connectionError:
        return 'Sem conexão com a internet';
      default:
        return 'Erro de comunicação';
    }
  }
}
