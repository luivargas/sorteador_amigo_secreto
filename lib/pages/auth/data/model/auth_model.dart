import 'package:sorteador_amigo_secreto/pages/auth/data/model/auth_groups_model.dart';

class AuthModel {
  final String email;
  final List<AuthGroupModel>? groups;
  final int totalGroups;

  AuthModel({required this.email, this.groups, required this.totalGroups});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    List<AuthGroupModel> group(List<dynamic> raw) {
      return raw
          .map((e) => AuthGroupModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return AuthModel(
      email: json['email'],
      groups: group(json['groups']),
      totalGroups: json['total_groups'],
    );
  }
}
