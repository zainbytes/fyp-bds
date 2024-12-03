import 'package:flutter/material.dart';
import 'package:fyp/view/mywidgets/homepage/customappbar.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'About us'),
      body: Center(child: Text('about us'),),
    );
  }
}