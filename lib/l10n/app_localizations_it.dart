// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get refreshCompleted => 'Aggiornato!';

  @override
  String get refreshing => 'Aggiornamento...';

  @override
  String get homeTitle => 'I Miei Gruppi';

  @override
  String get homeSubtitle => 'Gestisci i tuoi gruppi di amico segreto';

  @override
  String get searchGroup => 'Cerca gruppo';

  @override
  String get shareGroup => 'Condividere';

  @override
  String errorLoadingGroups(String error) {
    return 'Errore nel caricamento dei gruppi: $error';
  }

  @override
  String get noGroupsFound => 'Nessun gruppo trovato';

  @override
  String get createGroupTitle => 'Crea il tuo gruppo adesso!';

  @override
  String get createGroupSubtitle => 'Compila i dati qui sotto';

  @override
  String groupCreatedSuccess(String name) {
    return 'Gruppo $name creato con successo!';
  }

  @override
  String get createGroupButton => 'Crea gruppo';

  @override
  String get edit => 'Modifica';

  @override
  String get delete => 'Elimina';

  @override
  String get archive => 'Archivia';

  @override
  String errorTryAgain(String error) {
    return 'Errore: $error, riprova';
  }

  @override
  String get notDefined => 'Non definito';

  @override
  String get noDescription => 'Senza descrizione';

  @override
  String get drawButton => 'Sorteggia';

  @override
  String get viewGroupSubtitle => 'Dettagli del gruppo';

  @override
  String get editGroupTitle => 'Modifica del gruppo!';

  @override
  String get editGroupSubtitle => 'Aggiorna le informazioni del gruppo';

  @override
  String get selectDate => 'Seleziona la data';

  @override
  String get cancel => 'Annulla';

  @override
  String get selectTime => 'Seleziona l\'orario';

  @override
  String get save => 'Salva';

  @override
  String get ok => 'OK';

  @override
  String get yourName => 'Il tuo nome';

  @override
  String get email => 'E-mail';

  @override
  String get phoneField => 'Prefisso + Cellulare';

  @override
  String get groupName => 'Nome del Gruppo';

  @override
  String get nameHint => 'Es: Mario Rossi';

  @override
  String get groupNameHint => 'Es: Amico Segreto dell\'Ufficio';

  @override
  String get eventLocation => 'Luogo dell\'Evento';

  @override
  String get minGiftValue => 'Valore Minimo';

  @override
  String get maxGiftValue => 'Valore Massimo';

  @override
  String get dateAndTime => 'Data e Ora';

  @override
  String get groupDescription => 'Descrizione del Gruppo';

  @override
  String get locationHint => 'Scegli un luogo';

  @override
  String get minValueHint => 'Es: € 100,00';

  @override
  String get maxValueHint => 'Es: € 150,00';

  @override
  String get dateHint => 'gg/mm/aaaa hh:mm';

  @override
  String get eventDate => 'Data dell\'incontro';

  @override
  String get suggestedValue => 'Valore suggerito';

  @override
  String get location => 'Luogo';

  @override
  String get description => 'Descrizione';

  @override
  String get addParticipantTitle => 'Aggiungi partecipante';

  @override
  String get addParticipantSubtitle => 'Aggiungi qualcuno al gruppo';

  @override
  String participantAddedSuccess(String name) {
    return 'Partecipante $name aggiunto con successo!';
  }

  @override
  String get errorTitle => 'Errore';

  @override
  String get participantTitle => 'Partecipante';

  @override
  String get participantSubtitle => 'Visualizza e modifica i dati';

  @override
  String participantUpdatedSuccess(String name) {
    return 'Partecipante $name aggiornato con successo!';
  }

  @override
  String get name => 'Nome';

  @override
  String get addParticipantButton => 'Aggiungi partecipante';

  @override
  String get participants => 'Partecipanti';

  @override
  String participantsSubtitle(int count) {
    return '$count persone registrate nel gruppo';
  }

  @override
  String get viewAll => 'Vedi tutti';

  @override
  String get viewLess => 'Vedi meno';

  @override
  String get badgePending => 'Sorteggio In Attesa';

  @override
  String get badgeRaffled => 'Sorteggio Effettuato';

  @override
  String get validatorInvalidEmail => 'E-mail non valida';

  @override
  String get validatorRequired => 'Campo obbligatorio';

  @override
  String get validatorEnterEmail => 'Inserisci la tua e-mail';

  @override
  String get validatorFixValues => 'Correggi i valori';

  @override
  String get onboardingTitle => 'Sorteggio Gratuito e Veloce!';

  @override
  String get onboardingWhatsapp => 'Partecipa su WhatsApp!';

  @override
  String get onboardingHowItWorks => 'Come funziona?';

  @override
  String get onboardingStep1Title => 'Crea un gruppo';

  @override
  String get onboardingStep1Desc =>
      'Definisci nome, valore e regole del sorteggio';

  @override
  String get onboardingStep2Title => 'Aggiungi partecipanti';

  @override
  String get onboardingStep2Desc => 'Compila nome, telefono e e-mail';

  @override
  String get onboardingStep3Title => 'Effettua il sorteggio';

  @override
  String get onboardingStep3Desc => 'Il sistema sorteggia automaticamente';

  @override
  String get onboardingStep4Title => 'Ricevi i risultati';

  @override
  String get onboardingStep4Desc =>
      'Ogni partecipante riceve il suo amico segreto via email o WhatsApp (piano Premium)';

  @override
  String get contactNotValid => 'Questo contatto deve avere nome e telefono';

  @override
  String get contactsTitle => 'Seleziona Partecipanti';

  @override
  String get contactsSubtitle => 'Scegli i contatti per il sorteggio';

  @override
  String get searchContacts => 'Cerca contatti';

  @override
  String get yourContacts => 'I Tuoi Contatti';

  @override
  String get contactPermissionDenied =>
      'Autorizzazione ai contatti non concessa';

  @override
  String confirmButton(int count) {
    return 'Conferma ($count)';
  }

  @override
  String errorAddingContact(String name, String message) {
    return 'Errore nell\'aggiungere $name: $message';
  }

  @override
  String get groupCode => 'Codice del gruppo';

  @override
  String get groupCodeHint => 'Inserisci qui il codice del gruppo';

  @override
  String get shareLinkTitle => 'Link del mio sito';

  @override
  String get selectedLabel => 'Selezionati';

  @override
  String selectedCount(int count) {
    return '$count selezionati';
  }

  @override
  String get noParticipantsSelected => 'Nessun partecipante selezionato';

  @override
  String get fieldRequired => 'Obbligatorio';

  @override
  String get phone => 'Telefono';

  @override
  String get selectPhone => 'Seleziona il telefono';

  @override
  String get countryLabel => 'Paese';

  @override
  String get selectEmail => 'Seleziona l\'e-mail';

  @override
  String get select => 'Seleziona';

  @override
  String get retry => 'Riprova';

  @override
  String get sessionExpired => 'Sessione scaduta.';

  @override
  String get verificationTitle => 'Verifica di onboardingo';

  @override
  String get verificationSubtitle => 'Ti invieremo un codice alla tua email';

  @override
  String get sendCodeButton => 'Invia codice';

  @override
  String get almostThereTitle => 'Quasi fatto!';

  @override
  String get almostThereSubtitle =>
      'Inserisci il codice che abbiamo inviato alla tua email';

  @override
  String get confirmCodeButton => 'Conferma codice';

  @override
  String get noName => 'Senza nome';

  @override
  String get errorBadRequest =>
      'Dati non validi. Controlla le informazioni e riprova.';

  @override
  String get errorUnauthorized => 'Sessione scaduta. Accedi nuovamente.';

  @override
  String get errorForbidden =>
      'Non hai il permesso per eseguire questa azione.';

  @override
  String get errorNotFound => 'La risorsa richiesta non è stata trovata.';

  @override
  String get errorConflict => 'Questa informazione esiste già.';

  @override
  String get errorUnprocessable =>
      'Dati non validi. Controlla le informazioni e riprova.';

  @override
  String get errorTooManyRequests =>
      'Troppi tentativi. Aspetta un momento e riprova.';

  @override
  String get errorServer => 'Errore del server. Riprova più tardi.';

  @override
  String get errorTimeout =>
      'Tempo scaduto. Controlla la connessione e riprova.';

  @override
  String get errorNoConnection => 'Nessuna connessione a internet.';

  @override
  String get errorUnknow => 'Si è verificato un errore imprevisto. Riprova.';
}
