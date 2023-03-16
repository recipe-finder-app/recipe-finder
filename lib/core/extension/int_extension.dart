import 'dart:ui';

extension ToColorExtension on int {
  Color get toColor => Color(this).withOpacity(0.1);
}
