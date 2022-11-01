import 'package:intl/intl.dart';

class PriceFormat{
  static PriceFormat instance = PriceFormat._init();
  PriceFormat._init();

  final formatter = NumberFormat('#,##0.00', 'ID');
}