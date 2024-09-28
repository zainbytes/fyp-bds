import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/model/useful_link.dart';
import 'package:fyp/view/mywidgets/homepage/customappbar.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewLink extends StatelessWidget {
  final UsefulLink link;
  const ViewLink({required this.link, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: link.organization!),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(10),
              //title
              Text(
                link.title!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const Gap(10),

              //about
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(link.about!,
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(fontSize: 16)))),
              const Gap(30),

              //web link
              contact(Icons.link, link.webLink!),
              const Gap(10),

              //location
              contact(Icons.location_pin, link.address!),
              const Gap(10),

              //email
              contact(Icons.email, link.email!),
              const Gap(10),

              //phone no
              contact(Icons.phone, link.phoneNo!),
            ],
          ),
        ),
      ),
    );
  }

  Container contact(IconData icon, String info) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15)),
        child: ListTile(
            onLongPress: () async {
              await Clipboard.setData(ClipboardData(text: info));
            },
            titleTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
            leading: Icon(icon),
            title: Text(info)));
  }
}
