import 'package:flutter/material.dart';

class FinderView extends StatelessWidget {
  const FinderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
