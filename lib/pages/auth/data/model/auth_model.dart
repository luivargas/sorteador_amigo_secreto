import 'package:sorteador_amigo_secreto/pages/group/data/model/show_group_model.dart';

class AuthModel {
  final String email;
  final List<ShowGroupModel> groups;
  final String total;

  AuthModel({required this.email, required this.groups, required this.total});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    List<ShowGroupModel> parseGroups(List<dynamic> raw) {
      return raw.map((e) => ShowGroupModel.fromJson(e)).toList();
    }

    return AuthModel(
      email: json['email'],
      groups: parseGroups(json['groups']),
      total: json['total_groups'],
    );
  }
}
