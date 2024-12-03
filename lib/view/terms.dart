import 'package:flutter/material.dart';
import 'package:fyp/view/mywidgets/homepage/customappbar.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Terms & Condition'),
      body: Center(child: Text('Terms & Condition'),),
    );
  }
}