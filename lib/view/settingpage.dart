import 'package:flutter/material.dart';
import 'package:fyp/services/authentication/auth.dart';
import 'package:fyp/view/aboutus.dart';
import 'package:fyp/view/contactus.dart';
import 'package:fyp/view/editprofile.dart';
import 'package:fyp/view/mycolors.dart';
import 'package:fyp/view/terms.dart';
import 'package:gap/gap.dart';
import 'package:share_plus/share_plus.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Gap(30),
          TileForSettingPage(
              title: "Logout",
              leading: Icons.logout,
              trailing: Icons.arrow_forward_ios,
              onTap: () {
                Auth().signOut();
              }),
          const Gap(20),
          TileForSettingPage(
              title: "Edit profile",
              leading: Icons.person,
              trailing: Icons.arrow_forward_ios,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const EditProfile(),
                ));
              }),
          const Gap(20),
          TileForSettingPage(
              title: "Contact us",
              leading: Icons.contact_support_rounded,
              trailing: Icons.arrow_forward_ios,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ContactUs()));
              }),
          const Gap(20),
          TileForSettingPage(
              title: "About us",
              leading: Icons.info,
              trailing: Icons.arrow_forward_ios,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutUs()));
              }),
              const Gap(20),
            TileForSettingPage(
              title: "Share App",
              leading: Icons.share,
              trailing: Icons.arrow_forward_ios,
              onTap: () {
                // Sharing functionality
                Share.share('Check out this amazing app!');
              },
            ),
              const Gap(20),
          TileForSettingPage(
              title: "Term & Conditions",
              leading: Icons.document_scanner,
              trailing: Icons.arrow_forward_ios,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Terms()));
              }),
              const Gap(20),
        ],
      ),
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
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15)),
        child: ListTile(
            onTap: onTap,
            leading: Icon(
              leading,
              color: angryFlamingo,
            ),
            title: Text(title),
            trailing: Icon(trailing)));
  }
}
