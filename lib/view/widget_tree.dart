import 'package:flutter/material.dart';
import 'package:fyp/services/authentication/auth.dart';
import 'package:fyp/view/homepage.dart';
import 'package:fyp/view/loginpage.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: Auth().authStateChange, builder:(context, snapshot) {
        //if user log in
        if (snapshot.hasData) {
          return const Homepage();
        } 
        //not log in
        else {
          return const LoginPage();
        }
      },),
    );
  }
}