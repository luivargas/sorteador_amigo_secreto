// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get refreshCompleted => 'Updated!';

  @override
  String get refreshing => 'Updating...';

  @override
  String get homeTitle => 'My Groups';

  @override
  String get homeSubtitle => 'Manage your secret santa groups';

  @override
  String get searchGroup => 'Search group';

  @override
  String get shareGroup => 'Share';

  @override
  String errorLoadingGroups(String error) {
    return 'Error loading groups: $error';
  }

  @override
  String get noGroupsFound => 'No groups found';

  @override
  String get createGroupTitle => 'Create your group now!';

  @override
  String get createGroupSubtitle => 'Fill in the details below';

  @override
  String groupCreatedSuccess(String name) {
    return 'Group $name created successfully!';
  }

  @override
  String get createGroupButton => 'Create group';

  @override
  String get edit => 'Edit';

  @override
  String errorTryAgain(String error) {
    return 'Error: $error, please try again';
  }

  @override
  String get notDefined => 'Not defined';

  @override
  String get noDescription => 'No description';

  @override
  String get drawButton => 'Draw';

  @override
  String get viewGroupSubtitle => 'Group details';

  @override
  String get editGroupTitle => 'Edit group!';

  @override
  String get editGroupSubtitle => 'Update the group information';

  @override
  String get selectDate => 'Select date';

  @override
  String get cancel => 'Cancel';

  @override
  String get selectTime => 'Select time';

  @override
  String get save => 'Save';

  @override
  String get ok => 'OK';

  @override
  String get yourName => 'Your name';

  @override
  String get email => 'E-mail';

  @override
  String get phoneField => 'Phone';

  @override
  String get groupName => 'Group Name';

  @override
  String get nameHint => 'Ex: John Smith';

  @override
  String get groupNameHint => 'Ex: Office Secret Santa';

  @override
  String get eventLocation => 'Event Location';

  @override
  String get minGiftValue => 'Minimum Value';

  @override
  String get maxGiftValue => 'Maximum Value';

  @override
  String get dateAndTime => 'Date and Time';

  @override
  String get groupDescription => 'Group Description';

  @override
  String get locationHint => 'Choose a location';

  @override
  String get minValueHint => 'Ex: \$ 100.00';

  @override
  String get maxValueHint => 'Ex: \$ 150.00';

  @override
  String get dateHint => 'mm/dd/yyyy hh:mm';

  @override
  String get eventDate => 'Event date';

  @override
  String get suggestedValue => 'Suggested value';

  @override
  String get location => 'Location';

  @override
  String get description => 'Description';

  @override
  String get addParticipantTitle => 'Add participant';

  @override
  String get addParticipantSubtitle => 'Add someone to the group';

  @override
  String participantAddedSuccess(String name) {
    return 'Participant $name added successfully!';
  }

  @override
  String get errorTitle => 'Error';

  @override
  String get participantTitle => 'Participant';

  @override
  String get participantSubtitle => 'View and edit the details';

  @override
  String participantUpdatedSuccess(String name) {
    return 'Participant $name updated successfully!';
  }

  @override
  String get name => 'Name';

  @override
  String get addParticipantButton => 'Add participant';

  @override
  String participants(int count) {
    return 'Participants ($count)';
  }

  @override
  String get viewAll => 'View all';

  @override
  String get viewLess => 'View less';

  @override
  String get badgePending => 'Awaiting Draw';

  @override
  String get badgeRaffled => 'Draw Complete';

  @override
  String get validatorInvalidEmail => 'Invalid e-mail';

  @override
  String get validatorRequired => 'Required field';

  @override
  String get validatorEnterEmail => 'Enter your e-mail';

  @override
  String get validatorFixValues => 'Fix the values';

  @override
  String get onboardingTitle => 'Free Raffle and Fast!';

  @override
  String get onboardingWhatsapp => 'Join via WhatsApp!';

  @override
  String get onboardingHowItWorks => 'How it works?';

  @override
  String get onboardingStep1Title => 'Create a group';

  @override
  String get onboardingStep1Desc => 'Set name, value and rules';

  @override
  String get onboardingStep2Title => 'Add participants';

  @override
  String get onboardingStep2Desc => 'Fill in name, phone and e-mail';

  @override
  String get onboardingStep3Title => 'Run the draw';

  @override
  String get onboardingStep3Desc => 'The system draws automatically';

  @override
  String get onboardingStep4Title => 'Receive the results';

  @override
  String get onboardingStep4Desc =>
      'Each participant receives their secret friend by email or WhatsApp (Premium plan)';

  @override
  String get contactNotValid => 'This contact must have a name and phone';

  @override
  String get contactsTitle => 'Select Participants';

  @override
  String get contactsSubtitle => 'Choose contacts for the draw';

  @override
  String get searchContacts => 'Search contacts';

  @override
  String get yourContacts => 'Your Contacts';

  @override
  String get contactPermissionDenied => 'Contact permission not granted';

  @override
  String confirmButton(int count) {
    return 'Confirm ($count)';
  }

  @override
  String errorAddingContact(String name, String message) {
    return 'Error adding $name: $message';
  }

  @override
  String get groupCode => 'Group code';

  @override
  String get groupCodeHint => 'Enter the group code here';

  @override
  String get shareLinkTitle => 'My site link';

  @override
  String get selectedLabel => 'Selected';

  @override
  String selectedCount(int count) {
    return '$count selected';
  }

  @override
  String get noParticipantsSelected => 'No participant selected';

  @override
  String get fieldRequired => 'Required';

  @override
  String get phone => 'Phone';

  @override
  String get selectPhone => 'Select phone';

  @override
  String get countryLabel => 'Country';

  @override
  String get selectEmail => 'Select e-mail';

  @override
  String get select => 'Select';

  @override
  String get retry => 'Try again';

  @override
  String get sessionExpired => 'Session expired.';

  @override
  String get verificationTitle => 'Access verification';

  @override
  String get verificationSubtitle => 'We will send a code to your email';

  @override
  String get sendCodeButton => 'Send code';

  @override
  String get almostThereTitle => 'Almost there!';

  @override
  String get almostThereSubtitle => 'Enter the code we sent to your email';

  @override
  String get confirmCodeButton => 'Confirm code';

  @override
  String get noName => 'No name';
}
