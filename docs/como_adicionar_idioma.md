# Como adicionar um novo idioma ao app

Este projeto usa o sistema oficial de localização do Flutter com arquivos `.arb`.

---

## Estrutura dos arquivos

```
lib/i18n/
├── app_pt.arb              ← Strings em Português (arquivo template)
├── app_en.arb              ← Strings em Inglês
├── app_localizations.dart  ← Gerado automaticamente (não edite)
├── app_localizations_pt.dart  ← Gerado automaticamente
└── app_localizations_en.dart  ← Gerado automaticamente
```

---

## Passo a passo para adicionar um idioma (ex: Espanhol)

### 1. Crie o arquivo de tradução

Crie o arquivo `lib/i18n/app_es.arb` baseado no arquivo português:

```json
{
  "@@locale": "es",

  "refreshCompleted": "¡Actualizado!",
  "refreshing": "Actualizando...",

  "searchGroup": "Buscar grupo",
  "errorLoadingGroups": "Error al cargar grupos: {error}",
  "@errorLoadingGroups": {
    "placeholders": { "error": { "type": "String" } }
  },
  "noGroupsFound": "No se encontraron grupos",

  "createGroupTitle": "¡Crea tu grupo ahora!",
  "groupCreatedSuccess": "¡Grupo {name} creado con éxito!",
  "@groupCreatedSuccess": {
    "placeholders": { "name": { "type": "String" } }
  },
  "createGroupButton": "Crear grupo",

  "edit": "Editar",
  "errorTryAgain": "Error: {error}, inténtalo de nuevo",
  "@errorTryAgain": {
    "placeholders": { "error": { "type": "String" } }
  },
  "notDefined": "No definido",
  "noDescription": "Sin descripción",
  "drawButton": "Sortear",

  "editGroupTitle": "¡Edición del grupo!",
  "selectDate": "Seleccionar fecha",
  "cancel": "Cancelar",
  "selectTime": "Seleccionar hora",
  "save": "Guardar",
  "ok": "OK",

  "yourName": "Tu nombre",
  "email": "E-mail",
  "phoneField": "Teléfono",
  "groupName": "Nombre del Grupo",
  "nameHint": "Ej: Juan García",
  "groupNameHint": "Ej: Amigo Secreto de la Oficina",

  "eventLocation": "Lugar del Evento",
  "minGiftValue": "Valor Mínimo",
  "maxGiftValue": "Valor Máximo",
  "dateAndTime": "Fecha y Hora",
  "groupDescription": "Descripción del Grupo",
  "locationHint": "Elige un lugar",
  "minValueHint": "Ej: $ 100,00",
  "maxValueHint": "Ej: $ 150,00",
  "dateHint": "dd/mm/aaaa hh:mm",

  "eventDate": "Fecha del evento",
  "suggestedValue": "Valor sugerido",
  "location": "Lugar",
  "description": "Descripción",

  "addParticipantTitle": "Añadir participante",
  "participantAddedSuccess": "¡Participante {name} añadido con éxito!",
  "@participantAddedSuccess": {
    "placeholders": { "name": { "type": "String" } }
  },
  "errorTitle": "Error",
  "participantTitle": "Participante",
  "participantUpdatedSuccess": "¡Participante {name} actualizado con éxito!",
  "@participantUpdatedSuccess": {
    "placeholders": { "name": { "type": "String" } }
  },
  "name": "Nombre",
  "addParticipantButton": "Añadir participante",

  "participants": "Participantes ({count})",
  "@participants": {
    "placeholders": { "count": { "type": "int" } }
  },
  "viewAll": "Ver todos",
  "viewLess": "Ver menos",

  "badgePending": "Esperando Sorteo",
  "badgeRaffled": "Sorteo Realizado",

  "validatorInvalidEmail": "E-mail inválido",
  "validatorRequired": "Campo obligatorio",
  "validatorEnterEmail": "Introduce tu e-mail",
  "validatorFixValues": "Corrige los valores",

  "accessFreeRaffle": "Sorteo Gratis",
  "accessFast": "¡y Rápido!",
  "accessWhatsapp": "¡Únete por WhatsApp!",
  "accessHowItWorks": "¿Cómo funciona?",
  "accessStep1Title": "Crea un grupo",
  "accessStep1Desc": "Define nombre, valor y reglas del sorteo",
  "accessStep2Title": "Añade participantes",
  "accessStep2Desc": "Define nombre, valor y reglas del sorteo",
  "accessStep3Title": "Realiza el sorteo",
  "accessStep3Desc": "El sistema sortea automáticamente",
  "accessStep4Title": "Recibe los resultados",
  "accessStep4Desc": "Cada participante recibe su amigo secreto por email o WhatsApp (plan Premium)",

  "contactNotValid": "Este contacto necesita nombre y teléfono",
  "contactsTitle": "Seleccionar Participantes",
  "contactsSubtitle": "Elige los contactos para el sorteo",
  "searchContacts": "Buscar contactos",
  "yourContacts": "Tus Contactos",
  "contactPermissionDenied": "Permiso de contacto no concedido",
  "confirmButton": "Confirmar ({count})",
  "@confirmButton": {
    "placeholders": { "count": { "type": "int" } }
  },
  "errorAddingContact": "Error al añadir {name}: {message}",
  "@errorAddingContact": {
    "placeholders": {
      "name": { "type": "String" },
      "message": { "type": "String" }
    }
  },
  "groupCode": "Código del grupo",
  "groupCodeHint": "Introduce aquí el código del grupo",

  "shareLinkTitle": "Link de mi sitio"
}
```

> **Regras importantes do arquivo `.arb`:**
> - A chave `"@@locale"` deve ter o código correto do idioma (`"es"`, `"fr"`, `"de"`, etc.)
> - Todas as chaves devem existir — copie o `app_pt.arb` como base e não remova nenhuma chave
> - Entradas que começam com `@` são metadados (ex: `@errorLoadingGroups`) — mantenha-as como estão

---

### 2. Gere os arquivos automáticos

No terminal, na raiz do projeto:

```bash
flutter gen-i18n
```

Isso vai gerar automaticamente `lib/i18n/app_localizations_es.dart`.

---

### 3. Pronto!

O `main.dart` já está configurado para detectar o idioma do dispositivo automaticamente via `AppLocalizations.supportedLocales`. Nenhuma alteração adicional é necessária.

Se o dispositivo estiver em espanhol, o app usará as strings do `app_es.arb`.

---

## Referência: Códigos de idioma comuns

| Idioma     | Código |
|------------|--------|
| Português  | `pt`   |
| Inglês     | `en`   |
| Espanhol   | `es`   |
| Francês    | `fr`   |
| Alemão     | `de`   |
| Italiano   | `it`   |
| Japonês    | `ja`   |
| Chinês     | `zh`   |

---

## Como adicionar uma nova string ao app

Quando criar uma nova tela com texto fixo, siga este processo:

### 1. Adicione a chave no `app_pt.arb`

```json
"minhaNovaMensagem": "Texto em português aqui"
```

### 2. Adicione a mesma chave em todos os outros arquivos `.arb`

```json
// app_en.arb
"minhaNovaMensagem": "Text in English here"
```

### 3. Rode `flutter gen-i18n`

```bash
flutter gen-i18n
```

### 4. Use no widget

```dart
import 'package:sorteador_amigo_secreto/i18n/app_localizations.dart';

// dentro do build(BuildContext context):
Text(AppLocalizations.of(context)!.minhaNovaMensagem)
```

---

## Strings com variáveis (placeholders)

Para strings que contêm valores dinâmicos, use placeholders:

**No `.arb`:**
```json
"boasVindas": "Olá, {nome}!",
"@boasVindas": {
  "placeholders": {
    "nome": { "type": "String" }
  }
}
```

**No Dart:**
```dart
Text(AppLocalizations.of(context)!.boasVindas('João'))
```
