import 'dart:ffi';

class CreateGroupEntity {
  final String adminName;
  final String adminEmail;
  final String adminPhone;
  final String groupName;
  final String eventLocation;
  final Float minGiftValue;
  final Float maxGiftValue;
  final String eventDate;
  final String eventTime;
  final String groupDescription;

  CreateGroupEntity({
    required this.adminName,
    required this.adminEmail,
    required this.adminPhone,
    required this.groupName,
    required this.eventLocation,
    required this.minGiftValue,
    required this.maxGiftValue,
    required this.eventDate,
    required this.eventTime,
    required this.groupDescription,
  });

  Map<String, dynamic> toJson() {
    return {
      "group_name": groupName,
      "event_location": eventLocation,
      "min_gift_value": minGiftValue,
      "max_gift_value": maxGiftValue,
      "eventDate": eventDate,
      "eventTime": eventTime,
      "group_description": groupDescription,
    };
  }
}
