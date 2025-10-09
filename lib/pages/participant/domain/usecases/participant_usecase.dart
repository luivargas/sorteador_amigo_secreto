import 'package:sorteador_amigo_secreto/pages/participant/data/model/create_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/show_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/data/model/update_participant_model.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/update_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/repository/participant_repository.dart';

class ParticipantUsecase {
  final ParticipantRepository repository;
  ParticipantUsecase(this.repository);
  Future<CreateParticipantModel> create(CreateParticipantEntity entity, int id) =>
      repository.create(entity, id);
  Future<UpdateParticipantModel> update(UpdateParticipantEntity entity, int id) =>
      repository.update(entity, id);
  Future<ShowParticipantModel> show(int id) => repository.show(id);
}
