/// Resultado genérico de operações de Grupo (status + mensagem + erros de campo).
/// Não é o “dados do grupo”; é um carrier de status para API/DB.
///
/// Convenções de nomenclatura:
/// - Classes/Enums: PascalCase
/// - Métodos/variáveis: camelCase
/// - Enum values: lowerCamelCase
///
/// Exemplo de uso:
///   final res = await datasource.create(entity);
///   if (res.ok) { ... } else { showError(res.message); }
library;

enum OperationStage {
  api,     // falha/sucesso na camada de rede/servidor
  db,      // falha/sucesso na persistência local
  both,    // sucesso total (api + db)
  unknown, // não foi possível determinar a etapa
}

class GroupModel {
  /// true = operação concluída com sucesso
  final bool ok;
  /// Código HTTP quando houver (operações de rede).
  final int? statusCode;
  /// Mensagem humana para feedback (sucesso/erro).
  final String message;
  /// Etapa da operação (API, DB, BOTH, UNKNOWN).
  final OperationStage stage;
  /// Erros de validação por campo (quando API retornar validação, ex.: 422/400).
  /// Ex.: {"name": "Nome é obrigatório", "email": "Formato inválido"}
  final Map<String, String>? fieldErrors;

  const GroupModel._({
    required this.ok,
    required this.message,
    required this.stage,
    this.statusCode,
    this.fieldErrors,
  });

  /// Sucesso (por padrão, considera sucesso “both” — API + DB).
  factory GroupModel.success({
    int? statusCode,
    OperationStage stage = OperationStage.both,
    String message = 'OK',
  }) {
    return GroupModel._(
      ok: true,
      statusCode: statusCode,
      message: message,
      stage: stage,
      fieldErrors: null,
    );
  }

  /// Falha (permite informar etapa e erros de campo).
  factory GroupModel.failure({
    int? statusCode,
    OperationStage stage = OperationStage.unknown,
    required String message,
    Map<String, String>? fieldErrors,
  }) {
    return GroupModel._(
      ok: false,
      statusCode: statusCode,
      message: message,
      stage: stage,
      fieldErrors: (fieldErrors == null || fieldErrors.isEmpty)
          ? null
          : Map.unmodifiable(fieldErrors),
    );
  }

  // ========== HELPERS COERENTES ==========

  /// Mensagem de erro para um campo específico (ou null).
  String? errorFor(String field) => fieldErrors?[field];

  /// Indica se há erro para um campo específico.
  bool hasErrorFor(String field) => fieldErrors?.containsKey(field) ?? false;

  /// Indica se existem erros de validação em qualquer campo.
  bool get hasFieldErrors => fieldErrors?.isNotEmpty ?? false;

  /// Falha originada na camada de API (rede/servidor).
  bool get isApiError => !ok && stage == OperationStage.api;

  /// Falha originada na camada de banco/local.
  bool get isDbError => !ok && stage == OperationStage.db;

  // ========== COPIES / MERGE ==========

  GroupModel copyWith({
    bool? ok,
    int? statusCode,
    String? message,
    OperationStage? stage,
    Map<String, String>? fieldErrors,
  }) {
    return GroupModel._(
      ok: ok ?? this.ok,
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      stage: stage ?? this.stage,
      fieldErrors: fieldErrors ?? this.fieldErrors,
    );
  }

  /// Mescla erros de campo (útil para combinar validação local + servidor).
  GroupModel mergeFieldErrors(Map<String, String> newErrors) {
    final merged = <String, String>{};
    if (fieldErrors != null) merged.addAll(fieldErrors!);
    merged.addAll(newErrors);
    return copyWith(fieldErrors: Map.unmodifiable(merged));
  }

  // ========== DEBUG/COMPARE ==========

  @override
  String toString() {
    return 'GroupModel(ok=$ok, statusCode=$statusCode, stage=$stage, '
        'message="$message", fieldErrors=$fieldErrors)';
  }

  @override
  int get hashCode =>
      ok.hashCode ^
      (statusCode ?? 0).hashCode ^
      message.hashCode ^
      stage.hashCode ^
      _mapHash(fieldErrors);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GroupModel &&
        other.ok == ok &&
        other.statusCode == statusCode &&
        other.message == message &&
        other.stage == stage &&
        _mapEquals(other.fieldErrors, fieldErrors);
  }

  static bool _mapEquals(Map<String, String>? a, Map<String, String>? b) {
    if (identical(a, b)) return true;
    if (a == null || b == null) return a == b;
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (a[key] != b[key]) return false;
    }
    return true;
  }

  static int _mapHash(Map<String, String>? m) {
    if (m == null) return 0;
    var h = 0;
    m.forEach((k, v) {
      h = h ^ k.hashCode ^ v.hashCode;
    });
    return h;
  }
}
