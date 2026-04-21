  import 'package:phone_form_field/phone_form_field.dart';
                                                                                                                        
  class ContactReviewEntry {
    final String name;                                                                                                  
    String phone;                                                                                                     
    String email;
    IsoCode? isoCode;

    ContactReviewEntry({
      required this.name,
      this.phone = '',
      this.email = '',
      this.isoCode,                                                                                                     
    });
  }                                                                                                                     
                                                                                                                      
  class ContactReviewArgs {
    final List<ContactReviewEntry> entries;
    const ContactReviewArgs({required this.entries});
  }