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
  String get homeTitle => 'Seus Grupos';

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
  String get createGroupTitle => 'Crie seu grupo';

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
  String get delete => 'Excluir';

  @override
  String get archive => 'Arquivar';

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
  String get addParticipantSubtitle =>
      'Preencha os dados do novo participante do seu amigo secreto';

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
  String participantDeletedSuccess(String name) {
    return 'Participante $name excluído com sucesso!';
  }

  @override
  String get name => 'Nome';

  @override
  String get addParticipantButton => 'Adicionar participante';

  @override
  String get participants => 'Participantes';

  @override
  String participantsSubtitle(int count) {
    return '$count pessoas cadastradas ao grupo';
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
  String get validatorEmailOrPhone => 'Informe o e-mail ou o telefone';

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
  String get contactList => 'LISTA DE CONTATOS';

  @override
  String get contactsTitle => 'Selecionar Participantes';

  @override
  String get contactsSubtitle => 'Escolha os contatos para o sorteio';

  @override
  String get searchParticipants => 'Buscar participantes';

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
  String get verificationSubtitle =>
      'Digite seu e-mail e receba o código de acesso do seu Amigo Secreto';

  @override
  String get sendCodeButton => 'Enviar código';

  @override
  String get almostThereTitle => 'Verifique o seu e-mail';

  @override
  String get almostThereSubtitle =>
      'Digite o código de 6 dígitos que enviamos para o seu e-mail';

  @override
  String get pasteCode => 'Colar código';

  @override
  String get confirmCodeButton => 'Confirmar código';

  @override
  String get noName => 'Sem nome';

  @override
  String get errorBadRequest =>
      'Dados inválidos. Verifique as informações e tente novamente.';

  @override
  String get errorUnauthorized => 'Sessão expirada. Faça login novamente.';

  @override
  String get errorForbidden =>
      'Você não tem permissão para realizar esta ação.';

  @override
  String get errorNotFound => 'O recurso solicitado não foi encontrado.';

  @override
  String get errorConflict => 'Esta informação já existe.';

  @override
  String get errorUnprocessable =>
      'Dados inválidos. Verifique as informações e tente novamente.';

  @override
  String get errorTooManyRequests =>
      'Muitas tentativas. Aguarde um momento e tente novamente.';

  @override
  String get errorServer => 'Erro no servidor. Tente novamente mais tarde.';

  @override
  String get errorTimeout =>
      'Tempo limite excedido. Verifique sua internet e tente novamente.';

  @override
  String get errorNoConnection => 'Sem conexão com a internet.';

  @override
  String get errorUnknow => 'Ocorreu um erro inesperado. Tente novamente.';

  @override
  String get statusConfirmed => 'Confirmado';

  @override
  String get statusPending => 'Pendente';

  @override
  String get filterAll => 'Todos';

  @override
  String get needMoreParticipants =>
      'Adicione pelo menos 2 participantes para realizar o sorteio';

  @override
  String get filterTitle => 'Filtros';

  @override
  String get filterRaffled => 'Grupos já sorteados';

  @override
  String get filterParticipating => 'Grupos que participa';

  @override
  String get filterManaging => 'Grupos que administra';

  @override
  String get filterClear => 'Limpar';

  @override
  String get filterApply => 'Aplicar';

  @override
  String get groupOptionsTitle => 'Opções do grupo';

  @override
  String get createGroupDesc => 'Crie um novo grupo do zero';

  @override
  String get recoverGroup => 'Recuperar grupo';

  @override
  String get recoverGroupDesc =>
      'Receba todos os grupos que você criou ou participa.';

  @override
  String get homeCardTitle => 'Crie seu grupo agora';

  @override
  String get homeCardDesc =>
      'Convide amigos, defina as regras e deixe a mágica acontecer.';

  @override
  String get getStarted => 'Começar';

  @override
  String stepLabel(String step) {
    return 'PASSO $step';
  }

  @override
  String get quickAccess => 'ACESSO RÁPIDO';

  @override
  String get importContacts => 'Importar dos Contatos';

  @override
  String get participantNameHint => 'Ex: Simba';

  @override
  String get roleAdmin => 'Administrador';

  @override
  String get roleParticipant => 'Participante';

  @override
  String get createMyGroup => 'Crie seu grupo agora';

  @override
  String get onboardingHeroTitle => 'Crie seu Amigo Secreto em Segundos';

  @override
  String get onboardingHeroDesc =>
      'Organize seus grupos de Amigo Secreto, edite as informações dos grupos e adicione participantes de forma simples e rápida';

  @override
  String get onboardingFreeTitle => 'Totalmente Gratuito';

  @override
  String get onboardingFreeDesc =>
      'Organize quantos grupos quiser sem pagar nada. A diversão é por nossa conta!';

  @override
  String get onboardingStep1AltTitle => 'Crie o seu grupo';

  @override
  String get onboardingStep1AltDesc => 'Preencha nome, e-mail e nome do grupo.';

  @override
  String get onboardingStep2AltTitle => 'Preencha as informações';

  @override
  String get onboardingStep2AltDesc =>
      'Defina valor, data e regras do sorteio.';

  @override
  String get onboardingStep3AltTitle => 'Adicione os participantes';

  @override
  String get onboardingStep3AltDesc =>
      'Inclua seus amigos ou compartilhe o convite.';

  @override
  String get onboardingStep4AltTitle => 'Faça o sorteio';

  @override
  String get onboardingStep4AltDesc =>
      'Com tudo preenchido realize o sorteio e veja os resultados.';

  @override
  String get logoutLabel => 'CONFIRMAÇÃO DE ACESSO';

  @override
  String get logoutTitle => 'Deseja realmente sair?';

  @override
  String get logoutSubtitle =>
      'Você será desconectado do aplicativo e precisará dos seus dados para entrar novamente.';

  @override
  String get logoutButton => 'Sair da conta';

  @override
  String get logoutBack => 'Voltar para o app';

  @override
  String confirmDeleteGroup(String name) {
    return 'Deseja excluir o grupo $name?';
  }

  @override
  String confirmDeleteParticipant(String name) {
    return 'Deseja excluir o participante $name?';
  }

  @override
  String get adminCannotBeDeleted =>
      'O administrador do grupo não pode ser excluído.';

  @override
  String get groupActions => 'Gerencie este grupo e suas configurações';

  @override
  String get shareGroupSubtitle => 'CONVIDE NOVOS PARTICIPANTES';

  @override
  String get editGroupSubtitle2 => 'ATUALISE AS INFORMAÇÕES';

  @override
  String get deleteGroup => 'Excluir grupo';

  @override
  String get deleteGroupSubtitle => 'EXCLUIR GRUPO PERMANENTEMENTE';

  @override
  String get raffleCompleted => 'Sorteio realizado!';

  @override
  String get raffleCompletedMessage =>
      'O amigo secreto foi sorteado com sucesso!';

  @override
  String get adminRole => 'Admin';

  @override
  String get openSettings => 'Abrir configurações';

  @override
  String get onboardingGuideTitle => 'Guia rápido';

  @override
  String get onboardingGuideSubtitle =>
      'Tudo que você precisa saber para criar seu amigo secreto.';

  @override
  String get participantOptionsTitle => 'Opções do participante';

  @override
  String get participantOptionsSubtitle => 'Gerencie este participante';

  @override
  String get resendEmail => 'Reenviar e-mail';

  @override
  String get resendEmailSubtitle => 'Reenviar e-mail do sorteio';

  @override
  String get deleteParticipant => 'Excluir participante';

  @override
  String get deleteParticipantSubtitle => 'Remover do grupo permanentemente';
}
