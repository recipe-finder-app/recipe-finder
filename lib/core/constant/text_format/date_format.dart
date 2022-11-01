import 'package:intl/intl.dart';

class DateFormatter{
  static DateFormatter instance = DateFormatter._init();
  DateFormatter._init();

  final date = DateFormat('yyyy-MM-dd');
  final time = DateFormat('HH:mm');
  final time12 = DateFormat('hh:mm');
}