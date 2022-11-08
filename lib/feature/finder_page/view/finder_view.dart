import 'package:flutter/material.dart';
import 'package:recipe_finder/product/widget/button_navbar/button_navbar.dart';

import '../../../product/widget/button_navbar/fab_widget.dart';

class FinderView extends StatelessWidget {
  const FinderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /**
       *  bottomNavigationBar: const BottomNavbar(
        pageid: 6,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const MyFAB(),
       */
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text('finder'),
        ],
      ),
    );
  }
}
