import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sorteador_amigo_secreto/core/network/contants.dart';
import 'package:sorteador_amigo_secreto/pages/splash_screen/data/model/auth_login_model.dart';
import 'package:sorteador_amigo_secreto/pages/splash_screen/data/model/auth_register_model.dart';
import 'package:sorteador_amigo_secreto/pages/splash_screen/domain/entities/auth_get_user_entity.dart';
import 'package:sorteador_amigo_secreto/pages/splash_screen/domain/entities/auth_login_entity.dart';
import 'package:sorteador_amigo_secreto/pages/splash_screen/domain/entities/auth_logout_entity.dart';
import 'package:sorteador_amigo_secreto/pages/splash_screen/domain/entities/auth_register_entity.dart';
import 'package:sorteador_amigo_secreto/pages/splash_screen/domain/repository/auth_repository.dart';

class AuthDatasource extends AuthRepository {
  final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
  final dio = Dio(BaseOptions());

  @override
  Future<AuthRegisterModel> register(AuthRegisterEntity entity) async {
    Response response;
    response = await dio.post(registerUrl, data: entity.toJson());
    final raw = response.data;
    final model = AuthRegisterModel.fromJson(raw);
    return model;
  }

  @override
  Future<AuthLoginModel> login(AuthLoginEntity entity) async {
    Response response;
    response = await dio.post(loginUrl, data: entity.toJson());
    final raw = response.data;
    final model = AuthLoginModel.fromJson(raw);
    return model;
  }

  @override
  Future logout(AuthLogoutEntity entity) async {
    final bearerToken = asyncPrefs.getString('jwt');
    Response response;
    response = await dio.post(
      logoutUrl,
      options: Options(headers: {'Authorization': bearerToken}),
      data: entity.toJson(),
    );
    final raw = response.data;
    return raw;
  }

  @override
  Future getUser(AuthGetUserEntity entity) async {
    final bearerToken = asyncPrefs.getString('jwt');
    Response response;
    response = await dio.get(
      getUserUrl,
      options: Options(headers: {'Authorization': bearerToken}),
      data: entity.toJson(),
    );
    final raw = response.data;
    return raw;
  }
}
