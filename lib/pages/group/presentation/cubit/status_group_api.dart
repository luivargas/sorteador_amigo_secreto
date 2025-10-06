// import 'package:dio/dio.dart';

// String? extractApiMessage(DioException e) {
//   final res = e.response;
//   final data = res?.data;

//   if (data is Map<String, dynamic>) {
//     final v = data['message_code'];
//     if (v is String && v.trim().isNotEmpty) return v;
//   }
//   return null;
// }

String statusFallback(int? code) {
  switch (code) {
    case 400:
      return 'E-mail não encontrado.';
    case 401:
      return 'Não autorizado.';
    case 403:
      return 'Acesso negado.';
    case 404:
      return 'Recurso não encontrado.';
    case 422:
      return 'Dados inválidos.';
    case 429:
      return 'Muitas tentativas. Tente novamente em instantes.';
    case 500:
      return 'Erro no servidor. Tente mais tarde.';
    default:
      return 'Falha ao recuperar senha.';
  }
}
