import 'package:sorteador_amigo_secreto/core/network/api_result.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/model/auth_model.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/request_token_entity.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/validate_token_entity.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/repository/auth_repository.dart';

class AuthUsecases {
  final AuthRepository repository;
  AuthUsecases(this.repository);

  Future<ApiResult<AuthModel>> validate(ValidateToken entity) =>
      repository.validate(entity);
  Future<ApiResult> request(RequestToken entity) => repository.request(entity);
}
