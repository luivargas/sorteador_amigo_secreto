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
  String get homeTitle => 'I Tuoi Gruppi';

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
  String get createGroupTitle => 'Crea il tuo gruppo';

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
  String get addParticipantSubtitle =>
      'Compila i dati del nuovo partecipante del tuo amico segreto';

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
  String participantDeletedSuccess(String name) {
    return 'Partecipante $name eliminato con successo!';
  }

  @override
  String get name => 'Nome';

  @override
  String get addParticipantButton => 'Aggiungi partecipante';

  @override
  String get allParticipantsList => 'Tutti i Partecipanti';

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
  String get validatorEmailOrPhone => 'Inserisci l\'email o il telefono';

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
  String get contactList => 'ELENCO CONTATTI';

  @override
  String get contactsTitle => 'Seleziona Partecipanti';

  @override
  String get contactsSubtitle => 'Scegli i contatti per il sorteggio';

  @override
  String get searchParticipants => 'Cerca partecipanti';

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
  String get verificationTitle => 'Verifica di accesso';

  @override
  String get verificationSubtitle =>
      'Inserisci la tua email e ricevi il codice di accesso del tuo Amico Segreto';

  @override
  String get sendCodeButton => 'Invia codice';

  @override
  String get almostThereTitle => 'Controlla la tua email';

  @override
  String get almostThereSubtitle =>
      'Inserisci il codice a 6 cifre che abbiamo inviato alla tua email';

  @override
  String get pasteCode => 'Incolla codice';

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

  @override
  String get statusConfirmed => 'Confermato';

  @override
  String get statusPending => 'In attesa';

  @override
  String get filterAll => 'Tutti';

  @override
  String get needMoreParticipants =>
      'Aggiungi almeno 2 partecipanti per effettuare il sorteggio';

  @override
  String get filterTitle => 'Filtri';

  @override
  String get filterRaffled => 'Gruppi già sorteggiati';

  @override
  String get filterParticipating => 'Gruppi a cui partecipi';

  @override
  String get filterManaging => 'Gruppi che gestisci';

  @override
  String get filterClear => 'Cancella';

  @override
  String get filterApply => 'Applica';

  @override
  String get groupOptionsTitle => 'Opzioni del gruppo';

  @override
  String get createGroupDesc => 'Crea un nuovo gruppo da zero';

  @override
  String get recoverGroup => 'Recupera gruppo';

  @override
  String get recoverGroupDesc =>
      'Ricevi tutti i gruppi che hai creato o a cui partecipi.';

  @override
  String get homeCardTitle => 'Crea il tuo gruppo ora';

  @override
  String get homeCardDesc =>
      'Invita amici, definisci le regole e lascia che la magia accada.';

  @override
  String get getStarted => 'Inizia';

  @override
  String stepLabel(String step) {
    return 'PASSO $step';
  }

  @override
  String get quickAccess => 'ACCESSO RAPIDO';

  @override
  String get importContacts => 'Importa dai Contatti';

  @override
  String get participantNameHint => 'Es: Simba';

  @override
  String get roleAdmin => 'Amministratore';

  @override
  String get roleParticipant => 'Partecipante';

  @override
  String get createMyGroup => 'Crea il tuo gruppo ora';

  @override
  String get onboardingHeroTitle => 'Crea il tuo Amico Segreto in Secondi';

  @override
  String get onboardingHeroDesc =>
      'Organizza i tuoi gruppi di Amico Segreto, modifica le informazioni dei gruppi e aggiungi partecipanti in modo semplice e veloce';

  @override
  String get onboardingFreeTitle => 'Completamente Gratuito';

  @override
  String get onboardingFreeDesc =>
      'Organizza quanti gruppi vuoi senza pagare nulla. Il divertimento è a nostro carico!';

  @override
  String get onboardingStep1AltTitle => 'Crea il tuo gruppo';

  @override
  String get onboardingStep1AltDesc => 'Compila nome, email e nome del gruppo.';

  @override
  String get onboardingStep2AltTitle => 'Compila le informazioni';

  @override
  String get onboardingStep2AltDesc =>
      'Definisci valore, data e regole del sorteggio.';

  @override
  String get onboardingStep3AltTitle => 'Aggiungi partecipanti';

  @override
  String get onboardingStep3AltDesc =>
      'Includi i tuoi amici o condividi l\'invito.';

  @override
  String get onboardingStep4AltTitle => 'Effettua il sorteggio';

  @override
  String get onboardingStep4AltDesc =>
      'Con tutto compilato effettua il sorteggio e vedi i risultati.';

  @override
  String get logoutLabel => 'CONFERMA ACCESSO';

  @override
  String get logoutTitle => 'Vuoi davvero uscire?';

  @override
  String get logoutSubtitle =>
      'Verrai disconnesso dall\'app e dovrai reinserire i tuoi dati per accedere di nuovo.';

  @override
  String get logoutButton => 'Esci dall\'account';

  @override
  String get logoutBack => 'Torna all\'app';

  @override
  String confirmDeleteGroup(String name) {
    return 'Vuoi eliminare il gruppo $name?';
  }

  @override
  String confirmDeleteParticipant(String name) {
    return 'Vuoi eliminare il partecipante $name?';
  }

  @override
  String get adminCannotBeDeleted =>
      'L\'amministratore del gruppo non può essere eliminato.';

  @override
  String get groupActions => 'Gestisci questo gruppo e le sue impostazioni';

  @override
  String get shareGroupSubtitle => 'INVITA NUOVI PARTECIPANTI';

  @override
  String get editGroupSubtitle2 => 'AGGIORNA LE INFORMAZIONI';

  @override
  String get deleteGroup => 'Elimina gruppo';

  @override
  String get deleteGroupSubtitle => 'ELIMINA GRUPPO PERMANENTEMENTE';

  @override
  String get raffleCompleted => 'Sorteggio completato!';

  @override
  String get raffleCompletedMessage =>
      'L\'amico segreto è stato sorteggiato con successo!';

  @override
  String get adminRole => 'Admin';

  @override
  String get openSettings => 'Apri impostazioni';

  @override
  String get onboardingGuideTitle => 'Guida rapida';

  @override
  String get onboardingGuideSubtitle =>
      'Tutto quello che devi sapere per creare il tuo amico segreto.';

  @override
  String get successTitle => 'Successo';

  @override
  String get partialTitle => 'Parziale';

  @override
  String get validatorInvalidPhone => 'Includi il prefisso + numero';

  @override
  String get phoneHelperText => 'Includi il prefisso + numero';

  @override
  String get participantOptionsTitle => 'Opzioni partecipante';

  @override
  String get participantOptionsSubtitle => 'Gestisci questo partecipante';

  @override
  String get resendEmail => 'Reinvia email';

  @override
  String get resendEmailSubtitle => 'Reinvia l\'email del sorteggio';

  @override
  String get deleteParticipant => 'Elimina partecipante';

  @override
  String get deleteParticipantSubtitle => 'Rimuovi dal gruppo permanentemente';

  @override
  String groupUpdatedSuccess(String name) {
    return 'Gruppo $name aggiornato con successo!';
  }

  @override
  String groupDeletedSuccess(String name) {
    return 'Gruppo $name eliminato con successo!';
  }

  @override
  String resendEmailSuccess(String name) {
    return 'Email reinviata con successo a $name!';
  }

  @override
  String get resendEmailInvalid =>
      'Impossibile reinviare l\'email. Il partecipante non ha un\'email valida registrata.';

  @override
  String get contactReviewTitle => 'Rivedi contatti';

  @override
  String get contactReviewSubtitle => 'Conferma i dati prima di aggiungere';

  @override
  String get whatsappPremiumTitle => 'WhatsApp Premium';

  @override
  String get whatsappPremiumSubtitle => 'Potenzia il tuo sorteggio!';

  @override
  String get whatsappPremiumPriceLabel => 'per gruppo';

  @override
  String get whatsappPremiumDescription =>
      'I tuoi partecipanti consultano il risultato tramite WhatsApp automaticamente.';

  @override
  String get whatsappPremiumCheck1 =>
      'I partecipanti consultano il risultato via WhatsApp';

  @override
  String get whatsappPremiumCheck2 => 'Sistema automatico 24h al giorno';

  @override
  String get whatsappPremiumCheck3 =>
      'Puoi registrare i numeri di telefono in seguito';

  @override
  String get whatsappPremiumHowToActivate => 'COME ATTIVARE';

  @override
  String get whatsappPremiumStep1 =>
      'Clicca su \"Attiva WhatsApp\" ed effettua il pagamento.';

  @override
  String get whatsappPremiumStep2 => 'Compila i dati fiscali al checkout.';

  @override
  String get whatsappPremiumStep3 =>
      'Torna qui e clicca su \"Aggiorna Pannello\" per attivare.';

  @override
  String get whatsappPremiumImportantLabel => 'Importante: ';

  @override
  String get whatsappPremiumImportantBody =>
      'Dopo il pagamento, compila i dati fiscali. WhatsApp verrà abilitato solo dopo il completamento del checkout. Poi torna qui e clicca su ';

  @override
  String get whatsappPremiumUpdatePanel => 'Aggiorna Pannello';

  @override
  String get whatsappPremiumContractButton => 'Attiva WhatsApp – R\$ 5,99';

  @override
  String get whatsappPremiumAlreadyPaidButton =>
      'Ho già pagato – Aggiorna Pannello';

  @override
  String get whatsappPremiumCardSubtitle => 'Risultato via WhatsApp';

  @override
  String get whatsappActivatedTitle => 'WhatsApp attivato in questo gruppo.';

  @override
  String get whatsappActivatedAlertMessage =>
      'Condividi questo link WhatsApp con i partecipanti. Ogni persona deve inviare un messaggio usando il numero che ha registrato per ricevere il nome del proprio amico segreto.';

  @override
  String get sendButton => 'Invia';
}
