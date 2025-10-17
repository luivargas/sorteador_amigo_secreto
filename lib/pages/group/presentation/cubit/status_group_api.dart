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
