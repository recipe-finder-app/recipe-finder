import 'package:flutter/material.dart';

abstract class IBaseViewModel {
  BuildContext? context;
  void setContext(BuildContext context);
  void init();
  void dispose();
}
