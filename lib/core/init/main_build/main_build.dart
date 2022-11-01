import 'package:flutter/material.dart';

import '../../component/widget/alert_dialog/alert_dialog_no_connection.dart';


class MainBuild {
  MainBuild._();
  static Widget build(BuildContext context, Widget? child) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child ?? const Center(),
        NoNetworkAlertDialog(),
      ],
    );
  }
}
