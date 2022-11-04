import 'package:flutter/material.dart';

class LikesView extends StatelessWidget {
  const LikesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text('Likes'),
        ],
      ),
    );
  }
}
