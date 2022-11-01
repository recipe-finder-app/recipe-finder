import 'package:flutter/material.dart';

abstract class IBaseViewModel {
  BuildContext? context;

  //ICoreDioNullSafety? coreDio = NetworkManager.instance!.coreDio;
  // VexanaManager? vexanaManager = VexanaManager.instance;
  // VexanaManager get vexanaManagerComputed => VexanaManager.instance;

  /*CacheManager localeManager = CacheManager.instance;
  NavigationService navigation = NavigationService.instance;*/

  void setContext(BuildContext context);
  void init();
  void dispose();
}
