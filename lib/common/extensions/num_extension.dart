import 'package:intl/intl.dart';

extension NumExtension on num {
  String formatterToPtBr() {
    final oCcy = NumberFormat("#,##0.00", "pt_BR");
    return oCcy.format(this);
  }
}
