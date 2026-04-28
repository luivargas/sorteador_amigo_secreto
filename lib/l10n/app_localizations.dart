import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('pt'),
    Locale('en'),
    Locale('es'),
    Locale('it'),
  ];

  /// No description provided for @refreshCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Atualizado!'**
  String get refreshCompleted;

  /// No description provided for @refreshing.
  ///
  /// In pt, this message translates to:
  /// **'Atualizando...'**
  String get refreshing;

  /// No description provided for @homeTitle.
  ///
  /// In pt, this message translates to:
  /// **'Seus Grupos'**
  String get homeTitle;

  /// No description provided for @homeSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Gerencie seus grupos de amigo secreto'**
  String get homeSubtitle;

  /// No description provided for @searchGroup.
  ///
  /// In pt, this message translates to:
  /// **'Buscar grupo'**
  String get searchGroup;

  /// No description provided for @shareGroup.
  ///
  /// In pt, this message translates to:
  /// **'Compartilhar'**
  String get shareGroup;

  /// No description provided for @errorLoadingGroups.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar grupos: {error}'**
  String errorLoadingGroups(String error);

  /// No description provided for @noGroupsFound.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum grupo encontrado'**
  String get noGroupsFound;

  /// No description provided for @createGroupTitle.
  ///
  /// In pt, this message translates to:
  /// **'Crie seu grupo'**
  String get createGroupTitle;

  /// No description provided for @createGroupSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Preencha os dados abaixo'**
  String get createGroupSubtitle;

  /// No description provided for @groupCreatedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Grupo {name} criado com sucesso!'**
  String groupCreatedSuccess(String name);

  /// No description provided for @createGroupButton.
  ///
  /// In pt, this message translates to:
  /// **'Criar grupo'**
  String get createGroupButton;

  /// No description provided for @edit.
  ///
  /// In pt, this message translates to:
  /// **'Editar'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In pt, this message translates to:
  /// **'Excluir'**
  String get delete;

  /// No description provided for @archive.
  ///
  /// In pt, this message translates to:
  /// **'Arquivar'**
  String get archive;

  /// No description provided for @errorTryAgain.
  ///
  /// In pt, this message translates to:
  /// **'Erro: {error}, tente novamente'**
  String errorTryAgain(String error);

  /// No description provided for @notDefined.
  ///
  /// In pt, this message translates to:
  /// **'Não definido'**
  String get notDefined;

  /// No description provided for @noDescription.
  ///
  /// In pt, this message translates to:
  /// **'Sem descrição'**
  String get noDescription;

  /// No description provided for @drawButton.
  ///
  /// In pt, this message translates to:
  /// **'Sortear'**
  String get drawButton;

  /// No description provided for @viewGroupSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Detalhes do grupo'**
  String get viewGroupSubtitle;

  /// No description provided for @editGroupTitle.
  ///
  /// In pt, this message translates to:
  /// **'Edição do grupo!'**
  String get editGroupTitle;

  /// No description provided for @editGroupSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Atualize as informações do grupo'**
  String get editGroupSubtitle;

  /// No description provided for @selectDate.
  ///
  /// In pt, this message translates to:
  /// **'Selecione a data'**
  String get selectDate;

  /// No description provided for @cancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @selectTime.
  ///
  /// In pt, this message translates to:
  /// **'Selecione o horário'**
  String get selectTime;

  /// No description provided for @save.
  ///
  /// In pt, this message translates to:
  /// **'Salvar'**
  String get save;

  /// No description provided for @ok.
  ///
  /// In pt, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @yourName.
  ///
  /// In pt, this message translates to:
  /// **'Seu nome'**
  String get yourName;

  /// No description provided for @email.
  ///
  /// In pt, this message translates to:
  /// **'E-mail'**
  String get email;

  /// No description provided for @phoneField.
  ///
  /// In pt, this message translates to:
  /// **'DDD + Celular'**
  String get phoneField;

  /// No description provided for @groupName.
  ///
  /// In pt, this message translates to:
  /// **'Nome do Grupo'**
  String get groupName;

  /// No description provided for @nameHint.
  ///
  /// In pt, this message translates to:
  /// **'Ex: João da Silva'**
  String get nameHint;

  /// No description provided for @groupNameHint.
  ///
  /// In pt, this message translates to:
  /// **'Ex: Amigo Secreto do Escritório'**
  String get groupNameHint;

  /// No description provided for @eventLocation.
  ///
  /// In pt, this message translates to:
  /// **'Local do Evento'**
  String get eventLocation;

  /// No description provided for @minGiftValue.
  ///
  /// In pt, this message translates to:
  /// **'Valor Mínimo'**
  String get minGiftValue;

  /// No description provided for @maxGiftValue.
  ///
  /// In pt, this message translates to:
  /// **'Valor Máximo'**
  String get maxGiftValue;

  /// No description provided for @dateAndTime.
  ///
  /// In pt, this message translates to:
  /// **'Data e Hora'**
  String get dateAndTime;

  /// No description provided for @groupDescription.
  ///
  /// In pt, this message translates to:
  /// **'Descrição do Grupo'**
  String get groupDescription;

  /// No description provided for @locationHint.
  ///
  /// In pt, this message translates to:
  /// **'Escolha um local'**
  String get locationHint;

  /// No description provided for @minValueHint.
  ///
  /// In pt, this message translates to:
  /// **'Ex: R\$ 100,00'**
  String get minValueHint;

  /// No description provided for @maxValueHint.
  ///
  /// In pt, this message translates to:
  /// **'Ex: R\$ 150,00'**
  String get maxValueHint;

  /// No description provided for @dateHint.
  ///
  /// In pt, this message translates to:
  /// **'dd/mm/aaaa hh:mm'**
  String get dateHint;

  /// No description provided for @eventDate.
  ///
  /// In pt, this message translates to:
  /// **'Data do encontro'**
  String get eventDate;

  /// No description provided for @suggestedValue.
  ///
  /// In pt, this message translates to:
  /// **'Valor sugerido'**
  String get suggestedValue;

  /// No description provided for @location.
  ///
  /// In pt, this message translates to:
  /// **'Local'**
  String get location;

  /// No description provided for @description.
  ///
  /// In pt, this message translates to:
  /// **'Descrição'**
  String get description;

  /// No description provided for @addParticipantTitle.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar participante'**
  String get addParticipantTitle;

  /// No description provided for @addParticipantSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Preencha os dados do novo participante do seu amigo secreto'**
  String get addParticipantSubtitle;

  /// No description provided for @participantAddedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Participante {name} adicionado com sucesso!'**
  String participantAddedSuccess(String name);

  /// No description provided for @errorTitle.
  ///
  /// In pt, this message translates to:
  /// **'Erro'**
  String get errorTitle;

  /// No description provided for @participantTitle.
  ///
  /// In pt, this message translates to:
  /// **'Participante'**
  String get participantTitle;

  /// No description provided for @participantSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Veja e edite os dados'**
  String get participantSubtitle;

  /// No description provided for @participantUpdatedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Participante {name} atualizado com sucesso!'**
  String participantUpdatedSuccess(String name);

  /// No description provided for @participantDeletedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Participante {name} excluído com sucesso!'**
  String participantDeletedSuccess(String name);

  /// No description provided for @name.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get name;

  /// No description provided for @addParticipantButton.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar participante'**
  String get addParticipantButton;

  /// No description provided for @allParticipantsList.
  ///
  /// In pt, this message translates to:
  /// **'Todos os Participantes'**
  String get allParticipantsList;

  /// No description provided for @participantsSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'{count} pessoas cadastradas ao grupo'**
  String participantsSubtitle(int count);

  /// No description provided for @viewAll.
  ///
  /// In pt, this message translates to:
  /// **'Ver todos'**
  String get viewAll;

  /// No description provided for @viewLess.
  ///
  /// In pt, this message translates to:
  /// **'Ver menos'**
  String get viewLess;

  /// No description provided for @badgePending.
  ///
  /// In pt, this message translates to:
  /// **'Aguardando Sorteio'**
  String get badgePending;

  /// No description provided for @badgeRaffled.
  ///
  /// In pt, this message translates to:
  /// **'Sorteio Realizado'**
  String get badgeRaffled;

  /// No description provided for @validatorInvalidEmail.
  ///
  /// In pt, this message translates to:
  /// **'E-mail inválido'**
  String get validatorInvalidEmail;

  /// No description provided for @validatorRequired.
  ///
  /// In pt, this message translates to:
  /// **'Campo obrigatório'**
  String get validatorRequired;

  /// No description provided for @validatorEnterEmail.
  ///
  /// In pt, this message translates to:
  /// **'Informe seu e-mail'**
  String get validatorEnterEmail;

  /// No description provided for @validatorFixValues.
  ///
  /// In pt, this message translates to:
  /// **'Corrija os valores'**
  String get validatorFixValues;

  /// No description provided for @validatorEmailOrPhone.
  ///
  /// In pt, this message translates to:
  /// **'Informe o e-mail ou o telefone'**
  String get validatorEmailOrPhone;

  /// No description provided for @onboardingTitle.
  ///
  /// In pt, this message translates to:
  /// **'Sorteio Grátis e Rápido!'**
  String get onboardingTitle;

  /// No description provided for @onboardingWhatsapp.
  ///
  /// In pt, this message translates to:
  /// **'Participe pelo WhatsApp!'**
  String get onboardingWhatsapp;

  /// No description provided for @onboardingHowItWorks.
  ///
  /// In pt, this message translates to:
  /// **'Como funciona?'**
  String get onboardingHowItWorks;

  /// No description provided for @onboardingStep1Title.
  ///
  /// In pt, this message translates to:
  /// **'Crie um grupo'**
  String get onboardingStep1Title;

  /// No description provided for @onboardingStep1Desc.
  ///
  /// In pt, this message translates to:
  /// **'Defina nome, valor e regras do sorteio'**
  String get onboardingStep1Desc;

  /// No description provided for @onboardingStep2Title.
  ///
  /// In pt, this message translates to:
  /// **'Adicione participantes'**
  String get onboardingStep2Title;

  /// No description provided for @onboardingStep2Desc.
  ///
  /// In pt, this message translates to:
  /// **'Preencha nome, telefone e e-mail'**
  String get onboardingStep2Desc;

  /// No description provided for @onboardingStep3Title.
  ///
  /// In pt, this message translates to:
  /// **'Realize o sorteio'**
  String get onboardingStep3Title;

  /// No description provided for @onboardingStep3Desc.
  ///
  /// In pt, this message translates to:
  /// **'O sistema sorteia automaticamente'**
  String get onboardingStep3Desc;

  /// No description provided for @onboardingStep4Title.
  ///
  /// In pt, this message translates to:
  /// **'Receba os resultados'**
  String get onboardingStep4Title;

  /// No description provided for @onboardingStep4Desc.
  ///
  /// In pt, this message translates to:
  /// **'Cada participante recebe seu amigo secreto por email ou whatsapp (plano Premium)'**
  String get onboardingStep4Desc;

  /// No description provided for @contactNotValid.
  ///
  /// In pt, this message translates to:
  /// **'Este contato precisa ter nome e telefone'**
  String get contactNotValid;

  /// No description provided for @contactList.
  ///
  /// In pt, this message translates to:
  /// **'LISTA DE CONTATOS'**
  String get contactList;

  /// No description provided for @contactsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar Participantes'**
  String get contactsTitle;

  /// No description provided for @contactsSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Escolha os contatos para o sorteio'**
  String get contactsSubtitle;

  /// No description provided for @searchParticipants.
  ///
  /// In pt, this message translates to:
  /// **'Buscar participantes'**
  String get searchParticipants;

  /// No description provided for @yourContacts.
  ///
  /// In pt, this message translates to:
  /// **'Seus Contatos'**
  String get yourContacts;

  /// No description provided for @contactPermissionDenied.
  ///
  /// In pt, this message translates to:
  /// **'Permissão de contato não concedida'**
  String get contactPermissionDenied;

  /// No description provided for @confirmButton.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar ({count})'**
  String confirmButton(int count);

  /// No description provided for @errorAddingContact.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao adicionar {name}: {message}'**
  String errorAddingContact(String name, String message);

  /// No description provided for @groupCode.
  ///
  /// In pt, this message translates to:
  /// **'Código do grupo'**
  String get groupCode;

  /// No description provided for @groupCodeHint.
  ///
  /// In pt, this message translates to:
  /// **'Coloque aqui o código do grupo'**
  String get groupCodeHint;

  /// No description provided for @shareLinkTitle.
  ///
  /// In pt, this message translates to:
  /// **'Link do meu site'**
  String get shareLinkTitle;

  /// No description provided for @selectedLabel.
  ///
  /// In pt, this message translates to:
  /// **'Selecionados'**
  String get selectedLabel;

  /// No description provided for @selectedCount.
  ///
  /// In pt, this message translates to:
  /// **'{count} selecionados'**
  String selectedCount(int count);

  /// No description provided for @noParticipantsSelected.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum participante selecionado'**
  String get noParticipantsSelected;

  /// No description provided for @fieldRequired.
  ///
  /// In pt, this message translates to:
  /// **'Obrigatório'**
  String get fieldRequired;

  /// No description provided for @phone.
  ///
  /// In pt, this message translates to:
  /// **'Telefone'**
  String get phone;

  /// No description provided for @selectPhone.
  ///
  /// In pt, this message translates to:
  /// **'Selecione o telefone'**
  String get selectPhone;

  /// No description provided for @countryLabel.
  ///
  /// In pt, this message translates to:
  /// **'País'**
  String get countryLabel;

  /// No description provided for @selectEmail.
  ///
  /// In pt, this message translates to:
  /// **'Selecione o e-mail'**
  String get selectEmail;

  /// No description provided for @select.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar'**
  String get select;

  /// No description provided for @retry.
  ///
  /// In pt, this message translates to:
  /// **'Tentar novamente'**
  String get retry;

  /// No description provided for @sessionExpired.
  ///
  /// In pt, this message translates to:
  /// **'Sessão expirada.'**
  String get sessionExpired;

  /// No description provided for @verificationTitle.
  ///
  /// In pt, this message translates to:
  /// **'Verificação de acesso'**
  String get verificationTitle;

  /// No description provided for @verificationSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Digite seu e-mail e receba o código de acesso do seu Amigo Secreto'**
  String get verificationSubtitle;

  /// No description provided for @sendCodeButton.
  ///
  /// In pt, this message translates to:
  /// **'Enviar código'**
  String get sendCodeButton;

  /// No description provided for @almostThereTitle.
  ///
  /// In pt, this message translates to:
  /// **'Verifique o seu e-mail'**
  String get almostThereTitle;

  /// No description provided for @almostThereSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Digite o código de 6 dígitos que enviamos para o seu e-mail'**
  String get almostThereSubtitle;

  /// No description provided for @pasteCode.
  ///
  /// In pt, this message translates to:
  /// **'Colar código'**
  String get pasteCode;

  /// No description provided for @confirmCodeButton.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar código'**
  String get confirmCodeButton;

  /// No description provided for @noName.
  ///
  /// In pt, this message translates to:
  /// **'Sem nome'**
  String get noName;

  /// No description provided for @errorBadRequest.
  ///
  /// In pt, this message translates to:
  /// **'Dados inválidos. Verifique as informações e tente novamente.'**
  String get errorBadRequest;

  /// No description provided for @errorUnauthorized.
  ///
  /// In pt, this message translates to:
  /// **'Sessão expirada. Faça login novamente.'**
  String get errorUnauthorized;

  /// No description provided for @errorForbidden.
  ///
  /// In pt, this message translates to:
  /// **'Você não tem permissão para realizar esta ação.'**
  String get errorForbidden;

  /// No description provided for @errorNotFound.
  ///
  /// In pt, this message translates to:
  /// **'O recurso solicitado não foi encontrado.'**
  String get errorNotFound;

  /// No description provided for @errorConflict.
  ///
  /// In pt, this message translates to:
  /// **'Esta informação já existe.'**
  String get errorConflict;

  /// No description provided for @errorUnprocessable.
  ///
  /// In pt, this message translates to:
  /// **'Dados inválidos. Verifique as informações e tente novamente.'**
  String get errorUnprocessable;

  /// No description provided for @errorTooManyRequests.
  ///
  /// In pt, this message translates to:
  /// **'Muitas tentativas. Aguarde um momento e tente novamente.'**
  String get errorTooManyRequests;

  /// No description provided for @errorServer.
  ///
  /// In pt, this message translates to:
  /// **'Erro no servidor. Tente novamente mais tarde.'**
  String get errorServer;

  /// No description provided for @errorTimeout.
  ///
  /// In pt, this message translates to:
  /// **'Tempo limite excedido. Verifique sua internet e tente novamente.'**
  String get errorTimeout;

  /// No description provided for @errorNoConnection.
  ///
  /// In pt, this message translates to:
  /// **'Sem conexão com a internet.'**
  String get errorNoConnection;

  /// No description provided for @errorUnknown.
  ///
  /// In pt, this message translates to:
  /// **'Ocorreu um erro inesperado. Tente novamente.'**
  String get errorUnknown;

  /// No description provided for @statusConfirmed.
  ///
  /// In pt, this message translates to:
  /// **'Confirmado'**
  String get statusConfirmed;

  /// No description provided for @statusPending.
  ///
  /// In pt, this message translates to:
  /// **'Pendente'**
  String get statusPending;

  /// No description provided for @filterAll.
  ///
  /// In pt, this message translates to:
  /// **'Todos'**
  String get filterAll;

  /// No description provided for @needMoreParticipants.
  ///
  /// In pt, this message translates to:
  /// **'Adicione pelo menos 2 participantes para realizar o sorteio'**
  String get needMoreParticipants;

  /// No description provided for @filterTitle.
  ///
  /// In pt, this message translates to:
  /// **'Filtros'**
  String get filterTitle;

  /// No description provided for @filterRaffled.
  ///
  /// In pt, this message translates to:
  /// **'Grupos já sorteados'**
  String get filterRaffled;

  /// No description provided for @filterParticipating.
  ///
  /// In pt, this message translates to:
  /// **'Grupos que participa'**
  String get filterParticipating;

  /// No description provided for @filterManaging.
  ///
  /// In pt, this message translates to:
  /// **'Grupos que administra'**
  String get filterManaging;

  /// No description provided for @filterClear.
  ///
  /// In pt, this message translates to:
  /// **'Limpar'**
  String get filterClear;

  /// No description provided for @filterApply.
  ///
  /// In pt, this message translates to:
  /// **'Aplicar'**
  String get filterApply;

  /// No description provided for @groupOptionsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Opções do grupo'**
  String get groupOptionsTitle;

  /// No description provided for @createGroupDesc.
  ///
  /// In pt, this message translates to:
  /// **'Crie um novo grupo do zero'**
  String get createGroupDesc;

  /// No description provided for @recoverGroup.
  ///
  /// In pt, this message translates to:
  /// **'Recuperar grupo'**
  String get recoverGroup;

  /// No description provided for @recoverGroupDesc.
  ///
  /// In pt, this message translates to:
  /// **'Receba todos os grupos que você criou ou participa.'**
  String get recoverGroupDesc;

  /// No description provided for @homeCardTitle.
  ///
  /// In pt, this message translates to:
  /// **'Crie seu grupo agora'**
  String get homeCardTitle;

  /// No description provided for @homeCardDesc.
  ///
  /// In pt, this message translates to:
  /// **'Convide amigos, defina as regras e deixe a mágica acontecer.'**
  String get homeCardDesc;

  /// No description provided for @getStarted.
  ///
  /// In pt, this message translates to:
  /// **'Começar'**
  String get getStarted;

  /// No description provided for @stepLabel.
  ///
  /// In pt, this message translates to:
  /// **'PASSO {step}'**
  String stepLabel(String step);

  /// No description provided for @quickAccess.
  ///
  /// In pt, this message translates to:
  /// **'ACESSO RÁPIDO'**
  String get quickAccess;

  /// No description provided for @importContacts.
  ///
  /// In pt, this message translates to:
  /// **'Importar dos Contatos'**
  String get importContacts;

  /// No description provided for @participantNameHint.
  ///
  /// In pt, this message translates to:
  /// **'Ex: Simba'**
  String get participantNameHint;

  /// No description provided for @roleAdmin.
  ///
  /// In pt, this message translates to:
  /// **'Administrador'**
  String get roleAdmin;

  /// No description provided for @roleParticipant.
  ///
  /// In pt, this message translates to:
  /// **'Participante'**
  String get roleParticipant;

  /// No description provided for @createMyGroup.
  ///
  /// In pt, this message translates to:
  /// **'Crie seu grupo agora'**
  String get createMyGroup;

  /// No description provided for @onboardingHeroTitle.
  ///
  /// In pt, this message translates to:
  /// **'Crie seu Amigo Secreto em Segundos'**
  String get onboardingHeroTitle;

  /// No description provided for @onboardingHeroDesc.
  ///
  /// In pt, this message translates to:
  /// **'Organize seus grupos de Amigo Secreto, edite as informações dos grupos e adicione participantes de forma simples e rápida'**
  String get onboardingHeroDesc;

  /// No description provided for @onboardingFreeTitle.
  ///
  /// In pt, this message translates to:
  /// **'Totalmente Gratuito'**
  String get onboardingFreeTitle;

  /// No description provided for @onboardingFreeDesc.
  ///
  /// In pt, this message translates to:
  /// **'Organize quantos grupos quiser sem pagar nada. A diversão é por nossa conta!'**
  String get onboardingFreeDesc;

  /// No description provided for @onboardingStep1AltTitle.
  ///
  /// In pt, this message translates to:
  /// **'Crie o seu grupo'**
  String get onboardingStep1AltTitle;

  /// No description provided for @onboardingStep1AltDesc.
  ///
  /// In pt, this message translates to:
  /// **'Preencha nome, e-mail e nome do grupo.'**
  String get onboardingStep1AltDesc;

  /// No description provided for @onboardingStep2AltTitle.
  ///
  /// In pt, this message translates to:
  /// **'Preencha as informações'**
  String get onboardingStep2AltTitle;

  /// No description provided for @onboardingStep2AltDesc.
  ///
  /// In pt, this message translates to:
  /// **'Defina valor, data e regras do sorteio.'**
  String get onboardingStep2AltDesc;

  /// No description provided for @onboardingStep3AltTitle.
  ///
  /// In pt, this message translates to:
  /// **'Adicione os participantes'**
  String get onboardingStep3AltTitle;

  /// No description provided for @onboardingStep3AltDesc.
  ///
  /// In pt, this message translates to:
  /// **'Inclua seus amigos ou compartilhe o convite.'**
  String get onboardingStep3AltDesc;

  /// No description provided for @onboardingStep4AltTitle.
  ///
  /// In pt, this message translates to:
  /// **'Faça o sorteio'**
  String get onboardingStep4AltTitle;

  /// No description provided for @onboardingStep4AltDesc.
  ///
  /// In pt, this message translates to:
  /// **'Com tudo preenchido realize o sorteio e veja os resultados.'**
  String get onboardingStep4AltDesc;

  /// No description provided for @logoutLabel.
  ///
  /// In pt, this message translates to:
  /// **'CONFIRMAÇÃO DE ACESSO'**
  String get logoutLabel;

  /// No description provided for @logoutTitle.
  ///
  /// In pt, this message translates to:
  /// **'Deseja realmente sair?'**
  String get logoutTitle;

  /// No description provided for @logoutSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Você será desconectado do aplicativo e precisará dos seus dados para entrar novamente.'**
  String get logoutSubtitle;

  /// No description provided for @logoutButton.
  ///
  /// In pt, this message translates to:
  /// **'Sair da conta'**
  String get logoutButton;

  /// No description provided for @logoutBack.
  ///
  /// In pt, this message translates to:
  /// **'Voltar para o app'**
  String get logoutBack;

  /// No description provided for @confirmDeleteGroup.
  ///
  /// In pt, this message translates to:
  /// **'Deseja excluir o grupo {name}?'**
  String confirmDeleteGroup(String name);

  /// No description provided for @confirmDeleteParticipant.
  ///
  /// In pt, this message translates to:
  /// **'Deseja excluir o participante {name}?'**
  String confirmDeleteParticipant(String name);

  /// No description provided for @adminCannotBeDeleted.
  ///
  /// In pt, this message translates to:
  /// **'O administrador do grupo não pode ser excluído.'**
  String get adminCannotBeDeleted;

  /// No description provided for @groupActions.
  ///
  /// In pt, this message translates to:
  /// **'Gerencie este grupo e suas configurações'**
  String get groupActions;

  /// No description provided for @shareGroupSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'CONVIDE NOVOS PARTICIPANTES'**
  String get shareGroupSubtitle;

  /// No description provided for @editGroupSubtitle2.
  ///
  /// In pt, this message translates to:
  /// **'ATUALIZE AS INFORMAÇÕES'**
  String get editGroupSubtitle2;

  /// No description provided for @deleteGroup.
  ///
  /// In pt, this message translates to:
  /// **'Excluir grupo'**
  String get deleteGroup;

  /// No description provided for @deleteGroupSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'EXCLUIR GRUPO PERMANENTEMENTE'**
  String get deleteGroupSubtitle;

  /// No description provided for @raffleCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Sorteio realizado!'**
  String get raffleCompleted;

  /// No description provided for @raffleCompletedMessage.
  ///
  /// In pt, this message translates to:
  /// **'O amigo secreto foi sorteado com sucesso!'**
  String get raffleCompletedMessage;

  /// No description provided for @adminRole.
  ///
  /// In pt, this message translates to:
  /// **'Admin'**
  String get adminRole;

  /// No description provided for @openSettings.
  ///
  /// In pt, this message translates to:
  /// **'Abrir configurações'**
  String get openSettings;

  /// No description provided for @onboardingGuideTitle.
  ///
  /// In pt, this message translates to:
  /// **'Guia rápido'**
  String get onboardingGuideTitle;

  /// No description provided for @onboardingGuideSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Tudo que você precisa saber para criar seu amigo secreto.'**
  String get onboardingGuideSubtitle;

  /// No description provided for @successTitle.
  ///
  /// In pt, this message translates to:
  /// **'Sucesso'**
  String get successTitle;

  /// No description provided for @partialTitle.
  ///
  /// In pt, this message translates to:
  /// **'Parcial'**
  String get partialTitle;

  /// No description provided for @validatorInvalidPhone.
  ///
  /// In pt, this message translates to:
  /// **'Inclua o DDD + número'**
  String get validatorInvalidPhone;

  /// No description provided for @phoneHelperText.
  ///
  /// In pt, this message translates to:
  /// **'Inclua o DDD + número'**
  String get phoneHelperText;

  /// No description provided for @participantOptionsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Opções do participante'**
  String get participantOptionsTitle;

  /// No description provided for @participantOptionsSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Gerencie este participante'**
  String get participantOptionsSubtitle;

  /// No description provided for @resendEmail.
  ///
  /// In pt, this message translates to:
  /// **'Reenviar e-mail'**
  String get resendEmail;

  /// No description provided for @resendEmailSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Reenviar e-mail do sorteio'**
  String get resendEmailSubtitle;

  /// No description provided for @deleteParticipant.
  ///
  /// In pt, this message translates to:
  /// **'Excluir participante'**
  String get deleteParticipant;

  /// No description provided for @deleteParticipantSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Remover do grupo permanentemente'**
  String get deleteParticipantSubtitle;

  /// No description provided for @groupUpdatedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Grupo {name} atualizado com sucesso!'**
  String groupUpdatedSuccess(String name);

  /// No description provided for @groupDeletedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Grupo {name} excluído com sucesso!'**
  String groupDeletedSuccess(String name);

  /// No description provided for @resendEmailSuccess.
  ///
  /// In pt, this message translates to:
  /// **'E-mail reenviado com sucesso para {name}!'**
  String resendEmailSuccess(String name);

  /// No description provided for @resendEmailInvalid.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível reenviar o e-mail. O participante não possui um e-mail válido cadastrado.'**
  String get resendEmailInvalid;

  /// No description provided for @contactReviewTitle.
  ///
  /// In pt, this message translates to:
  /// **'Revisar contatos'**
  String get contactReviewTitle;

  /// No description provided for @contactReviewSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Confirme os dados antes de adicionar'**
  String get contactReviewSubtitle;

  /// No description provided for @whatsappPremiumTitle.
  ///
  /// In pt, this message translates to:
  /// **'WhatsApp Premium'**
  String get whatsappPremiumTitle;

  /// No description provided for @whatsappPremiumSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Turbine seu sorteio!'**
  String get whatsappPremiumSubtitle;

  /// No description provided for @whatsappPremiumPriceLabel.
  ///
  /// In pt, this message translates to:
  /// **'por grupo'**
  String get whatsappPremiumPriceLabel;

  /// No description provided for @whatsappPremiumDescription.
  ///
  /// In pt, this message translates to:
  /// **'Seus participantes consultam o resultado pelo WhatsApp automaticamente.'**
  String get whatsappPremiumDescription;

  /// No description provided for @whatsappPremiumCheck1.
  ///
  /// In pt, this message translates to:
  /// **'Participantes consultam resultado por WhatsApp'**
  String get whatsappPremiumCheck1;

  /// No description provided for @whatsappPremiumCheck2.
  ///
  /// In pt, this message translates to:
  /// **'Sistema automático 24h por dia'**
  String get whatsappPremiumCheck2;

  /// No description provided for @whatsappPremiumCheck3.
  ///
  /// In pt, this message translates to:
  /// **'Você pode cadastrar telefones depois'**
  String get whatsappPremiumCheck3;

  /// No description provided for @whatsappPremiumHowToActivate.
  ///
  /// In pt, this message translates to:
  /// **'COMO ATIVAR'**
  String get whatsappPremiumHowToActivate;

  /// No description provided for @whatsappPremiumStep1.
  ///
  /// In pt, this message translates to:
  /// **'Clique em \"Contratar WhatsApp\" e realize o pagamento.'**
  String get whatsappPremiumStep1;

  /// No description provided for @whatsappPremiumStep2.
  ///
  /// In pt, this message translates to:
  /// **'Preencha os dados da nota fiscal no checkout.'**
  String get whatsappPremiumStep2;

  /// No description provided for @whatsappPremiumStep3.
  ///
  /// In pt, this message translates to:
  /// **'Volte aqui e clique em \"Atualizar Painel\" para ativar.'**
  String get whatsappPremiumStep3;

  /// No description provided for @whatsappPremiumImportantLabel.
  ///
  /// In pt, this message translates to:
  /// **'Importante: '**
  String get whatsappPremiumImportantLabel;

  /// No description provided for @whatsappPremiumImportantBody.
  ///
  /// In pt, this message translates to:
  /// **'Após o pagamento, preencha os dados da nota fiscal. O WhatsApp só será habilitado após o preenchimento completo. Em seguida, volte aqui e clique em '**
  String get whatsappPremiumImportantBody;

  /// No description provided for @whatsappPremiumUpdatePanel.
  ///
  /// In pt, this message translates to:
  /// **'Atualizar Painel'**
  String get whatsappPremiumUpdatePanel;

  /// No description provided for @whatsappPremiumContractButton.
  ///
  /// In pt, this message translates to:
  /// **'Contratar WhatsApp – R\$ 5,99'**
  String get whatsappPremiumContractButton;

  /// No description provided for @whatsappPremiumAlreadyPaidButton.
  ///
  /// In pt, this message translates to:
  /// **'Já paguei – Atualizar Painel'**
  String get whatsappPremiumAlreadyPaidButton;

  /// No description provided for @whatsappPremiumCardSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Resultado por WhatsApp'**
  String get whatsappPremiumCardSubtitle;

  /// No description provided for @whatsappActivatedTitle.
  ///
  /// In pt, this message translates to:
  /// **'WhatsApp ativado neste grupo.'**
  String get whatsappActivatedTitle;

  /// No description provided for @whatsappActivatedAlertMessage.
  ///
  /// In pt, this message translates to:
  /// **'Compartilhe este link do WhatsApp com os participantes. Cada pessoa deve enviar uma mensagem usando o número que cadastrou para receber o nome do seu amigo secreto.'**
  String get whatsappActivatedAlertMessage;

  /// No description provided for @sendButton.
  ///
  /// In pt, this message translates to:
  /// **'Enviar'**
  String get sendButton;

  /// No description provided for @viewResult.
  ///
  /// In pt, this message translates to:
  /// **'Ver resultado'**
  String get viewResult;

  /// No description provided for @viewResultSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'VER RESULTADO DO SORTEIO'**
  String get viewResultSubtitle;

  /// No description provided for @copyright.
  ///
  /// In pt, this message translates to:
  /// **'© 2009–2026 Todos os direitos reservados.\nSorteador.com.br'**
  String get copyright;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'it', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'it':
      return AppLocalizationsIt();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
