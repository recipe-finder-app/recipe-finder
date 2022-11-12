import 'package:flutter/material.dart';

import '../../../product/widget/button_navbar/button_navbar.dart';
import '../../../product/widget/button_navbar/fab_widget.dart';

class DiscoverView extends StatelessWidget {
  const DiscoverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
     
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text('Discover'),
        ],
      ),
    );
  }
}
