import 'package:sorteador_amigo_secreto/pages/auth/data/model/auth_login_model.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/model/auth_register_model.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/auth_forgot_password_entity.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/auth_get_user_entity.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/auth_login_entity.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/auth_logout_entity.dart';
import 'package:sorteador_amigo_secreto/pages/auth/domain/entities/auth_register_entity.dart';

abstract class AuthRepository {
  Future<AuthRegisterModel> register(AuthRegisterEntity entity);
  Future<AuthLoginModel> login(AuthLoginEntity entity);
  Future logout(AuthLogoutEntity entity);
  Future forgotPassword(AuthForgotPasswordEntity entity);
  Future getUser(AuthGetUserEntity entity);
}
