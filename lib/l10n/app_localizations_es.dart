// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get refreshCompleted => '¡Actualizado!';

  @override
  String get refreshing => 'Actualizando...';

  @override
  String get homeTitle => 'Mis Grupos';

  @override
  String get homeSubtitle => 'Gestiona tus grupos de amigo secreto';

  @override
  String get searchGroup => 'Buscar grupo';

  @override
  String get shareGroup => 'Compartir';

  @override
  String errorLoadingGroups(String error) {
    return 'Error al cargar grupos: $error';
  }

  @override
  String get noGroupsFound => 'Ningún grupo encontrado';

  @override
  String get createGroupTitle => '¡Crea tu grupo ahora!';

  @override
  String get createGroupSubtitle => 'Completa los datos a continuación';

  @override
  String groupCreatedSuccess(String name) {
    return '¡Grupo $name creado con éxito!';
  }

  @override
  String get createGroupButton => 'Crear grupo';

  @override
  String get edit => 'Editar';

  @override
  String get delete => 'Eliminar';

  @override
  String get archive => 'Archivar';

  @override
  String errorTryAgain(String error) {
    return 'Error: $error, inténtalo de nuevo';
  }

  @override
  String get notDefined => 'No definido';

  @override
  String get noDescription => 'Sin descripción';

  @override
  String get drawButton => 'Sortear';

  @override
  String get viewGroupSubtitle => 'Detalles del grupo';

  @override
  String get editGroupTitle => '¡Edición del grupo!';

  @override
  String get editGroupSubtitle => 'Actualiza la información del grupo';

  @override
  String get selectDate => 'Selecciona la fecha';

  @override
  String get cancel => 'Cancelar';

  @override
  String get selectTime => 'Selecciona la hora';

  @override
  String get save => 'Guardar';

  @override
  String get ok => 'OK';

  @override
  String get yourName => 'Tu nombre';

  @override
  String get email => 'Correo electrónico';

  @override
  String get phoneField => 'Código + Teléfono';

  @override
  String get groupName => 'Nombre del Grupo';

  @override
  String get nameHint => 'Ej: Juan García';

  @override
  String get groupNameHint => 'Ej: Amigo Secreto de la Oficina';

  @override
  String get eventLocation => 'Lugar del Evento';

  @override
  String get minGiftValue => 'Valor Mínimo';

  @override
  String get maxGiftValue => 'Valor Máximo';

  @override
  String get dateAndTime => 'Fecha y Hora';

  @override
  String get groupDescription => 'Descripción del Grupo';

  @override
  String get locationHint => 'Elige un lugar';

  @override
  String get minValueHint => 'Ej: \$ 100,00';

  @override
  String get maxValueHint => 'Ej: \$ 150,00';

  @override
  String get dateHint => 'dd/mm/aaaa hh:mm';

  @override
  String get eventDate => 'Fecha del encuentro';

  @override
  String get suggestedValue => 'Valor sugerido';

  @override
  String get location => 'Lugar';

  @override
  String get description => 'Descripción';

  @override
  String get addParticipantTitle => 'Agregar participante';

  @override
  String get addParticipantSubtitle => 'Agrega a alguien al grupo';

  @override
  String participantAddedSuccess(String name) {
    return '¡Participante $name agregado con éxito!';
  }

  @override
  String get errorTitle => 'Error';

  @override
  String get participantTitle => 'Participante';

  @override
  String get participantSubtitle => 'Ver y editar los datos';

  @override
  String participantUpdatedSuccess(String name) {
    return '¡Participante $name actualizado con éxito!';
  }

  @override
  String get name => 'Nombre';

  @override
  String get addParticipantButton => 'Agregar participante';

  @override
  String get participants => 'Participantes';

  @override
  String participantsSubtitle(int count) {
    return '$count personas registradas en el grupo';
  }

  @override
  String get viewAll => 'Ver todos';

  @override
  String get viewLess => 'Ver menos';

  @override
  String get badgePending => 'Sorteo Pendiente';

  @override
  String get badgeRaffled => 'Sorteo Realizado';

  @override
  String get validatorInvalidEmail => 'Correo electrónico inválido';

  @override
  String get validatorRequired => 'Campo obligatorio';

  @override
  String get validatorEnterEmail => 'Ingresa tu correo electrónico';

  @override
  String get validatorFixValues => 'Corrige los valores';

  @override
  String get onboardingTitle => 'Sorteo Gratis ¡y Rápido!';

  @override
  String get onboardingWhatsapp => '¡Participa por WhatsApp!';

  @override
  String get onboardingHowItWorks => '¿Cómo funciona?';

  @override
  String get onboardingStep1Title => 'Crea un grupo';

  @override
  String get onboardingStep1Desc =>
      'Define el nombre, valor y reglas del sorteo';

  @override
  String get onboardingStep2Title => 'Agrega participantes';

  @override
  String get onboardingStep2Desc =>
      'Completa nombre, teléfono y correo electrónico';

  @override
  String get onboardingStep3Title => 'Realiza el sorteo';

  @override
  String get onboardingStep3Desc => 'El sistema sortea automáticamente';

  @override
  String get onboardingStep4Title => 'Recibe los resultados';

  @override
  String get onboardingStep4Desc =>
      'Cada participante recibe su amigo secreto por correo o WhatsApp (plan Premium)';

  @override
  String get contactNotValid => 'Este contacto debe tener nombre y teléfono';

  @override
  String get contactsTitle => 'Seleccionar Participantes';

  @override
  String get contactsSubtitle => 'Elige los contactos para el sorteo';

  @override
  String get searchParticipants => 'Buscar participantes';

  @override
  String get yourContacts => 'Tus Contactos';

  @override
  String get contactPermissionDenied => 'Permiso de contacto no concedido';

  @override
  String confirmButton(int count) {
    return 'Confirmar ($count)';
  }

  @override
  String errorAddingContact(String name, String message) {
    return 'Error al agregar $name: $message';
  }

  @override
  String get groupCode => 'Código del grupo';

  @override
  String get groupCodeHint => 'Ingresa aquí el código del grupo';

  @override
  String get shareLinkTitle => 'Link de mi sitio';

  @override
  String get selectedLabel => 'Seleccionados';

  @override
  String selectedCount(int count) {
    return '$count seleccionados';
  }

  @override
  String get noParticipantsSelected => 'Ningún participante seleccionado';

  @override
  String get fieldRequired => 'Obligatorio';

  @override
  String get phone => 'Teléfono';

  @override
  String get selectPhone => 'Selecciona el teléfono';

  @override
  String get countryLabel => 'País';

  @override
  String get selectEmail => 'Selecciona el correo electrónico';

  @override
  String get select => 'Seleccionar';

  @override
  String get retry => 'Intentar de nuevo';

  @override
  String get sessionExpired => 'Sesión expirada.';

  @override
  String get verificationTitle => 'Verificación de acceso';

  @override
  String get verificationSubtitle =>
      'Te enviaremos un código a tu correo electrónico';

  @override
  String get sendCodeButton => 'Enviar código';

  @override
  String get almostThereTitle => '¡Casi listo!';

  @override
  String get almostThereSubtitle =>
      'Ingresa el código que enviamos a tu correo electrónico';

  @override
  String get confirmCodeButton => 'Confirmar código';

  @override
  String get noName => 'Sin nombre';

  @override
  String get errorBadRequest =>
      'Datos inválidos. Verifica la información e intenta nuevamente.';

  @override
  String get errorUnauthorized => 'Sesión expirada. Inicia sesión nuevamente.';

  @override
  String get errorForbidden => 'No tienes permiso para realizar esta acción.';

  @override
  String get errorNotFound => 'El recurso solicitado no fue encontrado.';

  @override
  String get errorConflict => 'Esta información ya existe.';

  @override
  String get errorUnprocessable =>
      'Datos inválidos. Verifica la información e intenta nuevamente.';

  @override
  String get errorTooManyRequests =>
      'Demasiados intentos. Espera un momento e intenta nuevamente.';

  @override
  String get errorServer =>
      'Error en el servidor. Intenta nuevamente más tarde.';

  @override
  String get errorTimeout =>
      'Tiempo de espera agotado. Verifica tu conexión e intenta nuevamente.';

  @override
  String get errorNoConnection => 'Sin conexión a internet.';

  @override
  String get errorUnknow => 'Ocurrió un error inesperado. Intenta nuevamente.';

  @override
  String get statusConfirmed => 'Confirmado';

  @override
  String get statusPending => 'Pendiente';

  @override
  String get filterAll => 'Todos';

  @override
  String get needMoreParticipants =>
      'Agrega al menos 2 participantes para realizar el sorteo';
}
