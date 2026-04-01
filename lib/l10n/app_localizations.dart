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
    Locale('en'),
    Locale('es'),
    Locale('it'),
    Locale('pt'),
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
  /// **'Meus Grupos'**
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
  /// **'Crie seu grupo agora!'**
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
  /// **'Adicione alguém ao grupo'**
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

  /// No description provided for @participants.
  ///
  /// In pt, this message translates to:
  /// **'Participantes'**
  String get participants;

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

  /// No description provided for @searchContacts.
  ///
  /// In pt, this message translates to:
  /// **'Buscar contatos'**
  String get searchContacts;

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
  /// **'Enviaremos um código para o seu e-mail'**
  String get verificationSubtitle;

  /// No description provided for @sendCodeButton.
  ///
  /// In pt, this message translates to:
  /// **'Enviar código'**
  String get sendCodeButton;

  /// No description provided for @almostThereTitle.
  ///
  /// In pt, this message translates to:
  /// **'Quase lá!'**
  String get almostThereTitle;

  /// No description provided for @almostThereSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Digite o código que enviamos para o seu e-mail'**
  String get almostThereSubtitle;

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

  /// No description provided for @errorUnknow.
  ///
  /// In pt, this message translates to:
  /// **'Ocorreu um erro inesperado. Tente novamente.'**
  String get errorUnknow;
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
