import 'package:flutter/material.dart';
import 'package:fyp/services/authentication/auth.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text('Logout'),
        onPressed: () {
          Auth().signOut();
        },
      ),
    );
  }
}
