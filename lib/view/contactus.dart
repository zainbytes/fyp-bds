import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fyp/services/firestore/contactus_store.dart';
import 'package:fyp/view/mycolors.dart';
import 'package:fyp/view/mywidgets/homepage/customappbar.dart';
import 'package:gap/gap.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();

    return Scaffold(
        appBar: CustomAppbar(title: 'Contact us'),
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            width: double.infinity,
          ),
          const Gap(20),
          Image.asset(
            'images/contact.jpg',
            width: 200,
          ),
          Gap(20),
          Container(
              width: 450,
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                'Leave us message, we will get contact as soon as possible.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )),

          Gap(20),

          Container(
            height: 200,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15)),
            child: TextField(
              controller: messageController,
              maxLines: 10,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'What do you want to tell us about?'),
            ),
          ),

          Gap(20),

          //send button

          GestureDetector(
            onTap: () async {
              if (messageController.text.isNotEmpty) {
                await ContactUsStore()
                    .saveMessage(message: messageController.text);
                messageController.clear();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Message sent')));
              }
            },
            child: Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 25),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: angryFlamingo,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.send, color: Colors.white),
                  Gap(10),
                  Text('Send us',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16))
                ])),
          ),
          Gap(20)
        ])));
  }
}
