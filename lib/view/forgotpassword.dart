import 'package:flutter/material.dart';
import 'package:fyp/services/authentication/auth.dart';
import 'package:fyp/services/validation/validation.dart';
import 'package:fyp/view/mycolors.dart';
import 'package:fyp/view/mywidgets/homepage/customappbar.dart';
import 'package:fyp/view/mywidgets/homepage/my_textfield.dart';
import 'package:gap/gap.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    var emailController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        title: 'Reset password',
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            const Gap(20),
            //image
            Image.asset(
              'assets/images/forgot.jpg',
              width: 200,
            ),
            const Gap(20),

            //heading
            Text(
              'Forget password',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Gap(20),

            //email text field
            DecoratedTextField(
                controller: emailController,
                validator: (value) => emailValidation(value),
                icon: const Icon(Icons.email_rounded),
                label: 'Email'),
            const Gap(20),

            //send link button
            GestureDetector(
              onTap: () async {
                if (_formkey.currentState!.validate()) {
                  await Auth()
                      .resetPassword(email: emailController.text.trim());
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email sent')));
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                    color: angryFlamingo,
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  'Send verfication link',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
