// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get refreshCompleted => 'Atualizado!';

  @override
  String get refreshing => 'Atualizando...';

  @override
  String get homeTitle => 'Meus Grupos';

  @override
  String get homeSubtitle => 'Gerencie seus grupos de amigo secreto';

  @override
  String get searchGroup => 'Buscar grupo';

  @override
  String get shareGroup => 'Compartilhar';

  @override
  String errorLoadingGroups(String error) {
    return 'Erro ao carregar grupos: $error';
  }

  @override
  String get noGroupsFound => 'Nenhum grupo encontrado';

  @override
  String get createGroupTitle => 'Crie seu grupo agora!';

  @override
  String get createGroupSubtitle => 'Preencha os dados abaixo';

  @override
  String groupCreatedSuccess(String name) {
    return 'Grupo $name criado com sucesso!';
  }

  @override
  String get createGroupButton => 'Criar grupo';

  @override
  String get edit => 'Editar';

  @override
  String errorTryAgain(String error) {
    return 'Erro: $error, tente novamente';
  }

  @override
  String get notDefined => 'Não definido';

  @override
  String get noDescription => 'Sem descrição';

  @override
  String get drawButton => 'Sortear';

  @override
  String get viewGroupSubtitle => 'Detalhes do grupo';

  @override
  String get editGroupTitle => 'Edição do grupo!';

  @override
  String get editGroupSubtitle => 'Atualize as informações do grupo';

  @override
  String get selectDate => 'Selecione a data';

  @override
  String get cancel => 'Cancelar';

  @override
  String get selectTime => 'Selecione o horário';

  @override
  String get save => 'Salvar';

  @override
  String get ok => 'OK';

  @override
  String get yourName => 'Seu nome';

  @override
  String get email => 'E-mail';

  @override
  String get phoneField => 'DDD + Celular';

  @override
  String get groupName => 'Nome do Grupo';

  @override
  String get nameHint => 'Ex: João da Silva';

  @override
  String get groupNameHint => 'Ex: Amigo Secreto do Escritório';

  @override
  String get eventLocation => 'Local do Evento';

  @override
  String get minGiftValue => 'Valor Mínimo';

  @override
  String get maxGiftValue => 'Valor Máximo';

  @override
  String get dateAndTime => 'Data e Hora';

  @override
  String get groupDescription => 'Descrição do Grupo';

  @override
  String get locationHint => 'Escolha um local';

  @override
  String get minValueHint => 'Ex: R\$ 100,00';

  @override
  String get maxValueHint => 'Ex: R\$ 150,00';

  @override
  String get dateHint => 'dd/mm/aaaa hh:mm';

  @override
  String get eventDate => 'Data do encontro';

  @override
  String get suggestedValue => 'Valor sugerido';

  @override
  String get location => 'Local';

  @override
  String get description => 'Descrição';

  @override
  String get addParticipantTitle => 'Adicionar participante';

  @override
  String get addParticipantSubtitle => 'Adicione alguém ao grupo';

  @override
  String participantAddedSuccess(String name) {
    return 'Participante $name adicionado com sucesso!';
  }

  @override
  String get errorTitle => 'Erro';

  @override
  String get participantTitle => 'Participante';

  @override
  String get participantSubtitle => 'Veja e edite os dados';

  @override
  String participantUpdatedSuccess(String name) {
    return 'Participante $name atualizado com sucesso!';
  }

  @override
  String get name => 'Nome';

  @override
  String get addParticipantButton => 'Adicionar participante';

  @override
  String participants(int count) {
    return 'Participantes ($count)';
  }

  @override
  String get viewAll => 'Ver todos';

  @override
  String get viewLess => 'Ver menos';

  @override
  String get badgePending => 'Aguardando Sorteio';

  @override
  String get badgeRaffled => 'Sorteio Realizado';

  @override
  String get validatorInvalidEmail => 'E-mail inválido';

  @override
  String get validatorRequired => 'Campo obrigatório';

  @override
  String get validatorEnterEmail => 'Informe seu e-mail';

  @override
  String get validatorFixValues => 'Corrija os valores';

  @override
  String get onboardingTitle => 'Sorteio Grátis e Rápido!';

  @override
  String get onboardingWhatsapp => 'Participe pelo WhatsApp!';

  @override
  String get onboardingHowItWorks => 'Como funciona?';

  @override
  String get onboardingStep1Title => 'Crie um grupo';

  @override
  String get onboardingStep1Desc => 'Defina nome, valor e regras do sorteio';

  @override
  String get onboardingStep2Title => 'Adicione participantes';

  @override
  String get onboardingStep2Desc => 'Preencha nome, telefone e e-mail';

  @override
  String get onboardingStep3Title => 'Realize o sorteio';

  @override
  String get onboardingStep3Desc => 'O sistema sorteia automaticamente';

  @override
  String get onboardingStep4Title => 'Receba os resultados';

  @override
  String get onboardingStep4Desc =>
      'Cada participante recebe seu amigo secreto por email ou whatsapp (plano Premium)';

  @override
  String get contactNotValid => 'Este contato precisa ter nome e telefone';

  @override
  String get contactsTitle => 'Selecionar Participantes';

  @override
  String get contactsSubtitle => 'Escolha os contatos para o sorteio';

  @override
  String get searchContacts => 'Buscar contatos';

  @override
  String get yourContacts => 'Seus Contatos';

  @override
  String get contactPermissionDenied => 'Permissão de contato não concedida';

  @override
  String confirmButton(int count) {
    return 'Confirmar ($count)';
  }

  @override
  String errorAddingContact(String name, String message) {
    return 'Erro ao adicionar $name: $message';
  }

  @override
  String get groupCode => 'Código do grupo';

  @override
  String get groupCodeHint => 'Coloque aqui o código do grupo';

  @override
  String get shareLinkTitle => 'Link do meu site';

  @override
  String get selectedLabel => 'Selecionados';

  @override
  String selectedCount(int count) {
    return '$count selecionados';
  }

  @override
  String get noParticipantsSelected => 'Nenhum participante selecionado';

  @override
  String get fieldRequired => 'Obrigatório';

  @override
  String get phone => 'Telefone';

  @override
  String get selectPhone => 'Selecione o telefone';

  @override
  String get countryLabel => 'País';

  @override
  String get selectEmail => 'Selecione o e-mail';

  @override
  String get select => 'Selecionar';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get sessionExpired => 'Sessão expirada.';

  @override
  String get verificationTitle => 'Verificação de acesso';

  @override
  String get verificationSubtitle => 'Enviaremos um código para o seu e-mail';

  @override
  String get sendCodeButton => 'Enviar código';

  @override
  String get almostThereTitle => 'Quase lá!';

  @override
  String get almostThereSubtitle =>
      'Digite o código que enviamos para o seu e-mail';

  @override
  String get confirmCodeButton => 'Confirmar código';

  @override
  String get noName => 'Sem nome';
}
