import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/notfound.png',
        width: 200,
      ),
    );
  }
}
