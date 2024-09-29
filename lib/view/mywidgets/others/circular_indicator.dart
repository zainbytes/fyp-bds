import 'package:flutter/material.dart';
import 'package:fyp/view/mycolors.dart';

class RedCircularProgress extends StatelessWidget {
  const RedCircularProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: angryFlamingo,
      ),
    );
  }
}
