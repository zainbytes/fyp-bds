import 'package:flutter/material.dart';
import 'package:fyp/services/authentication/auth.dart';
import 'package:fyp/view/editprofile.dart';
import 'package:fyp/view/pick_location.dart';
import 'package:gap/gap.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(30),
        TileForSettingPage(
            title: "Edit profile",
            leading: Icons.person,
            trailing: Icons.arrow_forward_ios,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const EditProfile(),
              ));
            }),
        const Gap(30),
        TileForSettingPage(
            title: "Logout",
            leading: Icons.logout,
            trailing: Icons.arrow_forward_ios,
            onTap: () {
              Auth().signOut();
            }),
            const Gap(30),

            
      ],
    );
  }
}

class TileForSettingPage extends StatelessWidget {
  final String title;
  final IconData leading;
  final IconData trailing;
  final VoidCallback onTap;
  const TileForSettingPage({
    required this.title,
    required this.leading,
    required this.trailing,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        onTap: onTap,
        leading: Icon(leading),
        title: Text(title),
        trailing: Icon(trailing),
      ),
    );
  }
}
