
import 'package:sorteador_amigo_secreto/core/network/api_result.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/model/auth_group_model.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/request_token_entity.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/validate_token_entity.dart';

abstract class AuthRepository {
  Future<ApiResult>request(RequestToken entity);
  Future<ApiResult<AuthGroupModel>>validate(ValidateToken entity);
}
