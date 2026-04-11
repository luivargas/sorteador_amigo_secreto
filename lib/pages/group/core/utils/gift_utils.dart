import 'package:intl/intl.dart';

class GiftUtils {
  static String toDisplayFormat(String? value) {
    if (value == null || value.isEmpty) return '';
    final parsed = double.tryParse(value);
    if (parsed == null) return value;
    return NumberFormat('#,##0.00', 'pt_BR').format(parsed);
  }

  static ({String min, String max}) resolveMinMax(String min, String max) {                                             
    final rawMin = min.replaceAll('.', '').replaceAll(',', '.');                                                        
    final rawMax = max.replaceAll('.', '').replaceAll(',', '.');                                                      
                                                                                                                        
    if (rawMin.isEmpty && rawMax.isNotEmpty) {                                                                        
      return (min: rawMax, max: rawMax);                                                                                
    }                                                                                                                   
                                                                                                                      
    return (min: rawMin, max: rawMax);                                                                                  
  }
}
