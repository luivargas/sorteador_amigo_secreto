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
  String get searchGroup => 'Buscar grupo';

  @override
  String errorLoadingGroups(String error) {
    return 'Error al cargar grupos: $error';
  }

  @override
  String get noGroupsFound => 'Ningún grupo encontrado';

  @override
  String get createGroupTitle => '¡Crea tu grupo ahora!';

  @override
  String groupCreatedSuccess(String name) {
    return '¡Grupo $name creado con éxito!';
  }

  @override
  String get createGroupButton => 'Crear grupo';

  @override
  String get edit => 'Editar';

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
  String get editGroupTitle => '¡Edición del grupo!';

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
  String participantAddedSuccess(String name) {
    return '¡Participante $name agregado con éxito!';
  }

  @override
  String get errorTitle => 'Error';

  @override
  String get participantTitle => 'Participante';

  @override
  String participantUpdatedSuccess(String name) {
    return '¡Participante $name actualizado con éxito!';
  }

  @override
  String get name => 'Nombre';

  @override
  String get addParticipantButton => 'Agregar participante';

  @override
  String participants(int count) {
    return 'Participantes ($count)';
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
  String get accessFreeRaffle => 'Sorteo Gratis';

  @override
  String get accessFast => '¡y Rápido!';

  @override
  String get accessWhatsapp => '¡Participa por WhatsApp!';

  @override
  String get accessHowItWorks => '¿Cómo funciona?';

  @override
  String get accessStep1Title => 'Crea un grupo';

  @override
  String get accessStep1Desc => 'Define el nombre, valor y reglas del sorteo';

  @override
  String get accessStep2Title => 'Agrega participantes';

  @override
  String get accessStep2Desc =>
      'Completa nombre, teléfono y correo electrónico';

  @override
  String get accessStep3Title => 'Realiza el sorteo';

  @override
  String get accessStep3Desc => 'El sistema sortea automáticamente';

  @override
  String get accessStep4Title => 'Recibe los resultados';

  @override
  String get accessStep4Desc =>
      'Cada participante recibe su amigo secreto por correo o WhatsApp (plan Premium)';

  @override
  String get contactNotValid => 'Este contacto debe tener nombre y teléfono';

  @override
  String get contactsTitle => 'Seleccionar Participantes';

  @override
  String get contactsSubtitle => 'Elige los contactos para el sorteo';

  @override
  String get searchContacts => 'Buscar contactos';

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
}
