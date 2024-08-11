import 'package:flutter/material.dart';
import 'package:fyp/controller/signup_controller.dart';
import 'package:gap/gap.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  ControllerSignUp controllerSignUp = ControllerSignUp();

  @override
  void dispose() {
    controllerSignUp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          customTextField(
              label: 'Full name',
              controller: controllerSignUp.fulNameController),
          Gap(10),
          customTextField(
              label: 'Email', controller: controllerSignUp.emailController),
          Gap(10),
          customTextField(
              label: 'Phone no e.g +92xxxx',
              controller: controllerSignUp.phoneNoController),
          Gap(10),
          customTextField(
              label: 'Blood Type',
              controller: controllerSignUp.bloodGropuController),
          Gap(10),
          customTextField(
              label: 'Other blood releated detail',
              controller: controllerSignUp.bloodDescriptionContoller),
          Gap(10),
          customTextField(
              label: 'Password',
              controller: controllerSignUp.passwordController),
          Gap(10),

          //signup button
          GestureDetector(
            onTap: () {
              //create account with email & pasword
              //store usre to database

              controllerSignUp.createAccount();
            },
            child: Container(
              width: 300,
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(15)),
              child: Text('Signup'),
            ),
          )
        ],
      ),
    );
  }

  Container customTextField(
      {String label = '', TextEditingController? controller}) {
    return Container(
      width: 300,
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(16)),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(border: InputBorder.none, hintText: label),
      ),
    );
  }
}
