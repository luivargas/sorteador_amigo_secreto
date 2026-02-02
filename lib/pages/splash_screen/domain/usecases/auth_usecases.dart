

import 'package:sorteador_amigo_secreto/pages/splash_screen/data/model/auth_login_model.dart';
import 'package:sorteador_amigo_secreto/pages/splash_screen/data/model/auth_register_model.dart';
import 'package:sorteador_amigo_secreto/pages/splash_screen/domain/entities/auth_get_user_entity.dart';
import 'package:sorteador_amigo_secreto/pages/splash_screen/domain/entities/auth_login_entity.dart';
import 'package:sorteador_amigo_secreto/pages/splash_screen/domain/entities/auth_logout_entity.dart';
import 'package:sorteador_amigo_secreto/pages/splash_screen/domain/entities/auth_register_entity.dart';
import 'package:sorteador_amigo_secreto/pages/splash_screen/domain/repository/auth_repository.dart';

class AuthUsecases {
  final AuthRepository repository;

  AuthUsecases(this.repository);
  Future<AuthRegisterModel> register(AuthRegisterEntity entity) =>
      repository.register(entity);
  Future<AuthLoginModel> login(AuthLoginEntity entity) =>
      repository.login(entity);
  Future logout(AuthLogoutEntity entity) => repository.logout(entity);
  Future getUser(AuthGetUserEntity entity) => repository.getUser(entity);
}
